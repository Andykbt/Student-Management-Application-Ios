//
//  ExamsViewController.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 22/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit
import CoreData

class ExamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var exams = [NSManagedObject]() //array of NSManagedObject to hold exams
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exams.count
    }
    
    // assign the values in your array variable to cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = ""
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath)
        
        //get name and location attributes from core entity
        info = exams[indexPath.row].value(forKey: "name") as! String + ", "
        info += exams[indexPath.row].value(forKey: "location") as! String + "\n"
        
        var date : Date
        date = exams[indexPath.row].value(forKey: "dateTime") as! Date
        
        //Convert Date object to string with DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: date)
        info += strDate
        
        //assign info to text label of cell
        cell.textLabel?.text = info
        cell.textLabel?.numberOfLines = 2
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //lets the user edit the row if tableView.EditMode is off
        if !tableView.isEditing {
            
            //parse info to nextView
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ExamForm") as! ExamFormViewController
            
            nextViewController.examNameString = exams[indexPath.row].value(forKey: "name") as! String
            nextViewController.locationString = exams[indexPath.row].value(forKey: "location") as! String
            nextViewController.datetime = exams[indexPath.row].value(forKey: "dateTime") as! Date
            nextViewController.isUpdate = true

            //push UIViewController ontop of current ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @IBAction func editTable(_ sender: Any) {
        //settings for tableView editMode
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(!tableView.isEditing, animated: true)
        deleteButton.isHidden = !deleteButton.isHidden
    }
    
    @IBAction func deleteRows(_ sender: Any) {
        //Delete table rows that are selected
        if let selectedRows = tableView.indexPathsForSelectedRows {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            var items = [NSManagedObject]()
            for indexPath in selectedRows  {
                items.append(exams[indexPath.row])
                appDelegate.persistentContainer.viewContext.delete(exams[indexPath.row])
            }
            
            for item in items {
                if let index = exams.index(of: item) {
                    exams.remove(at: index)
                }
            }
            
            //update TableView and saveContext
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
            
            appDelegate.saveContext()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setting Gradient for UIViewController
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 94/255, green: 18/255, blue: 76/255, alpha: 1).cgColor, UIColor(red: 62/255, green: 96/255, blue: 148/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        view.layer.insertSublayer(gradient, below: ContentView.layer)
        ContentView.roundCorners([.topLeft, .topRight], radius: 50)
        deleteButton.isHidden = true    //hide delete button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        //reload the tableView data if view is going to appear
        exams = appDelegate.getExamInfo()
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
