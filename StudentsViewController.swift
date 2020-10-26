//
//  StudentsViewController.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 18/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit
import CoreData

extension UIView {
    //function to round corners of UIView
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var NavigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!

    var students = [NSManagedObject]()  //array of NSManagedObjects to hold students
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = ""
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //get cell
        
        info = String(students[indexPath.row].value(forKey: "id") as! Int) + ", "
        info += students[indexPath.row].value(forKey: "firstName") as! String + " "
        info += students[indexPath.row].value(forKey: "lastName") as! String + ", "
        info += students[indexPath.row].value(forKey: "gender") as! String + "\n"
        info += students[indexPath.row].value(forKey: "courseStudy") as! String + ", "
        info += students[indexPath.row].value(forKey: "address") as! String + ", "
        info += String(students[indexPath.row].value(forKey: "age") as! Int)
        
        //put info into rows label
        cell.textLabel?.text = info
        cell.textLabel?.numberOfLines = 2
        
        return cell
    }
    
    //Student info DELETION
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let student = students[indexPath.row]   //get the student that was clicked
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.persistentContainer.viewContext.delete(student) //delete that student from context
            students.remove(at: indexPath.row)  //delete from students array
            tableView.deleteRows(at: [indexPath], with: .fade)  //delete row from tableView
            
            appDelegate.saveContext() //save changes
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigation to next UIViewController
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StudentForm") as! StudentFormViewController
        
        //parse row values to StudentFormViewController and give textfields values
        nextViewController.studentIDString = String(students[indexPath.row].value(forKey: "id") as! Int)
        nextViewController.firstNameString = students[indexPath.row].value(forKey: "firstName") as! String
        nextViewController.lastNameString = students[indexPath.row].value(forKey: "lastName") as! String
        nextViewController.genderString = students[indexPath.row].value(forKey: "gender") as! String
        nextViewController.courseString = students[indexPath.row].value(forKey: "courseStudy") as! String
        nextViewController.addressString = students[indexPath.row].value(forKey: "address") as! String
        nextViewController.ageString = String(students[indexPath.row].value(forKey: "age") as! Int)
        nextViewController.isUpdate = true
                                                                                         
        //push view controller on top of current view
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SETTING GRADIENT FOR VIEW
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 255/255, green: 246/255, blue: 135/255, alpha: 1).cgColor, UIColor(red: 245/255, green: 65/255, blue: 108/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        view.layer.insertSublayer(gradient, below: ContentView.layer)
        ContentView.roundCorners([.topLeft, .topRight], radius: 50)
        
        //Retrieve entities
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.rowHeight = 88    //set tableView row height
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        students = appDelegate.getStudentInfo()
        tableView.reloadData()  //reload tableView data
    }
}
