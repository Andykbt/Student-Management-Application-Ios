//
//  AppDelegate.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 18/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
     /*
        student Id
        first name
        last name
        gender,
        course study,
        age
        address
     */
    
    func storeStudentInfo(id: Int, firstName: String, lastName: String, gender: String, courseStudy: String, age: Int, address: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entity = NSEntityDescription.entity(forEntityName: "StudentEntity", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)

        //set entity values
        transc.setValue(id, forKey: "id")
        transc.setValue(firstName, forKey: "firstName")
        transc.setValue(lastName, forKey: "lastName")
        transc.setValue(gender, forKey: "gender")
        transc.setValue(courseStudy, forKey: "courseStudy")
        transc.setValue(age, forKey: "age")
        transc.setValue(address, forKey: "address")
        
        do {
            try context.save()  //save changes
            print("saved")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func updateStudentInfo(id: Int, firstName: String, lastName: String, gender: String, courseStudy: String, age: Int, address: String,
                           oldID: Int, oldFName: String, oldLName : String, oldGender : String, oldCourseStudy: String, oldAge : Int, oldAddress : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StudentEntity")
        //Predicate to get entity that matches the entity that will be updated
        let predicate = NSPredicate(format: "id = '\(oldID)' AND firstName = '\(oldFName)' AND lastName = '\(oldLName)' AND gender = '\(oldGender)' AND courseStudy = '\(oldCourseStudy)' AND age = '\(oldAge)' AND address = '\(oldAddress)'")
        fetchRequest.predicate = predicate

        do {    //update values of the entity
            let object = try persistentContainer.viewContext.fetch(fetchRequest)
            let objectUpdate = object.first as! NSManagedObject
            objectUpdate.setValue(id, forKey: "id")
            objectUpdate.setValue(firstName, forKey: "firstName")
            objectUpdate.setValue(lastName, forKey: "lastName")
            objectUpdate.setValue(gender, forKey: "gender")
            objectUpdate.setValue(courseStudy, forKey: "courseStudy")
            objectUpdate.setValue(age, forKey: "age")
            objectUpdate.setValue(address, forKey: "address")
            do {
                try persistentContainer.viewContext.save()  //save
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func getStudentInfo() -> [NSManagedObject]{
        var students = [NSManagedObject]()

        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StudentEntity")
        
        do {
            //get results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] { students.append(trans) }
        } catch {
            print("Error with request: \(error)")
        }
            
        return students
    }
    
    /*
     name,
     location,
     datetime
     */
    
    func storeExamInfo(name : String, location : String, dateTime : Date) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entity = NSEntityDescription.entity(forEntityName: "ExamEntity", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set entity values
        transc.setValue(name, forKey: "name")
        transc.setValue(location, forKey: "location")
        transc.setValue(dateTime, forKey: "dateTime")
        
        do {
            try context.save()  //save
            print("saved")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func updateExamInfo(name : String, location : String, dateTime : Date, oldName : String, oldLocation : String, oldDate : Date) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExamEntity")
        //Predicate to get entity that matches the entity that will be updated
        let predicate = NSPredicate(format: "name = '\(oldName)' AND location = '\(oldLocation)'")
        fetchRequest.predicate = predicate
        
        do {
            let object = try persistentContainer.viewContext.fetch(fetchRequest)
            
            //update values of the fetched entity
            let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(name, forKey: "name")
                objectUpdate.setValue(location, forKey: "location")
                objectUpdate.setValue(dateTime, forKey: "dateTime")
            do {
                try persistentContainer.viewContext.save() //save
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func getExamInfo() -> [NSManagedObject]{
        var exams = [NSManagedObject]()

        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExamEntity")
        
        do {
            //get results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] { exams.append(trans) }
        } catch {
            print("Error with request: \(error)")
        }
            
        return exams
    }

}

