//
//  ExamFormViewController.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 22/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit

class ExamFormViewController: UIViewController {
    @IBOutlet weak var ExamNameTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ContentView: UIView!
    
    var examNameString : String = ""
    var locationString : String = ""
    var datetime : Date = Date()
    var isUpdate : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign textfields to parsed info, if info is parsed
        ExamNameTextField.text = examNameString
        LocationTextField.text = locationString
        datePicker.date = datetime
        
        //Setting gradient for UIViewController
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 94/255, green: 18/255, blue: 76/255, alpha: 1).cgColor, UIColor(red: 62/255, green: 96/255, blue: 148/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        view.layer.insertSublayer(gradient, below: ContentView.layer)
        ContentView.roundCorners([.topLeft, .topRight], radius: 50)
    }
    
    @IBAction func submitExamForm(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if !isUpdate {  //Store Exam info to DB
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let strDate = dateFormatter.string(from: datePicker.date)
            appDelegate.storeExamInfo(name: ExamNameTextField.text!, location: LocationTextField.text!, dateTime: datePicker.date)
        } else {    //Upate info
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let strDate = dateFormatter.string(from: datePicker.date)
            appDelegate.updateExamInfo(name: ExamNameTextField.text!, location: LocationTextField.text!, dateTime: datePicker.date, oldName: examNameString, oldLocation: locationString, oldDate: datetime)
        }
        
        navigationController?.popViewController(animated: true)
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
