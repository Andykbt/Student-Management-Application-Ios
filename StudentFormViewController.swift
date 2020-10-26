//
//  StudentFormViewController.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 19/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit

class StudentFormViewController: UIViewController {

    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var StudentIDTextField: UITextField!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var CourseTextField: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var AgeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var AgeLabel: UILabel!
    @IBOutlet weak var AgeStepper: UIStepper!
    
    var studentIDString : String = ""
    var firstNameString : String = ""
    var lastNameString : String = ""
    var genderString : String = ""
    var courseString : String = ""
    var addressString : String = ""
    var ageString : String = "0"
    var isUpdate : Bool = false;
    var chosenGender : String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If this ViewController is called from StudentsViewController, set form fields to parsed values
        StudentIDTextField.text = studentIDString
        FirstNameTextField.text = firstNameString
        LastNameTextField.text = lastNameString
        CourseTextField.text = courseString
        AddressTextField.text = addressString
        AgeLabel.text = ageString
        if isUpdate {
            chosenGender = genderString
        }
        AgeStepper.value = Double(ageString)!
        
        //SETTING GRADIENT FOR VIEW
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 255/255, green: 246/255, blue: 135/255, alpha: 1).cgColor, UIColor(red: 245/255, green: 65/255, blue: 108/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        view.layer.insertSublayer(gradient, below: ContentView.layer)
        ContentView.roundCorners([.topLeft, .topRight], radius: 50)
    }
    
    //GenderSegmentedControll
    @IBAction func genderSegControl(_ sender: Any) {
        if AgeSegmentedControl.selectedSegmentIndex == 0 {
            chosenGender = "Male"
        } else {
            chosenGender = "Female"
        }
    }
    
    //changes the value of the label for age
    @IBAction func stepperChange(_ sender: Any) {
        let step = Int(AgeStepper.value)
        AgeLabel.text = String(step)
    }
    
    @IBAction func submitStudentForm(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if !isUpdate {  //if not updating vals, store info
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.storeStudentInfo(
                id: Int(StudentIDTextField.text!)!,
                firstName: FirstNameTextField.text!,
                lastName: LastNameTextField.text!,
                gender: chosenGender,
                courseStudy: CourseTextField.text!,
                age: Int(AgeLabel.text!)!,
                address: AddressTextField.text!)
        } else {    //else update values
            isUpdate = !isUpdate
            
            appDelegate.updateStudentInfo(
                id: Int(StudentIDTextField.text!)!,
                firstName: FirstNameTextField.text!,
                lastName: LastNameTextField.text!,
                gender: chosenGender,
                courseStudy: CourseTextField.text!,
                age: Int(AgeLabel.text!)!,
                address: AddressTextField.text!,
                oldID: Int(studentIDString)!,
                oldFName: firstNameString,
                oldLName: lastNameString,
                oldGender: genderString,
                oldCourseStudy: courseString,
                oldAge: Int(ageString)!,
                oldAddress: addressString)
        }
        
        //pop the view controller
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
