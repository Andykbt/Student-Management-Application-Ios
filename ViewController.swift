//
//  ViewController.swift
//  Assignment 2 - Student Management App
//
//  Created by Andy Truong on 18/10/20.
//  Copyright © 2020 Andy Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var StudentCard: UIView!
    @IBOutlet weak var ExamCard: UIView!
    @IBOutlet weak var StudentLabel: UILabel!
    @IBOutlet weak var ExamLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCards()
    }
    
    func setUpCards() {
        StudentCard.layer.cornerRadius = 50.0
        StudentCard.layer.shadowColor = UIColor.gray.cgColor
        StudentCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        StudentCard.layer.shadowRadius = 12.0
        StudentCard.layer.shadowOpacity = 0.7
        
        ExamCard.layer.cornerRadius = 20.0
        ExamCard.layer.shadowColor = UIColor.gray.cgColor
        ExamCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        ExamCard.layer.shadowRadius = 12.0
        ExamCard.layer.shadowOpacity = 0.7
        
        //GRADIENT LAYER FOR EXAM CARD
        let gradientLayerExam = CAGradientLayer()
        gradientLayerExam.colors = [UIColor(red: 94/255, green: 18/255, blue: 76/255, alpha: 1).cgColor, UIColor(red: 96/255, green: 148/255, blue: 234/255, alpha: 1).cgColor]
        gradientLayerExam.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayerExam.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayerExam.frame = ExamCard.bounds;
        gradientLayerExam.cornerRadius = 20.0
        
        //GRADIENT LAYER FOR STUDENT CARD
        let gradientLayerStudent = CAGradientLayer()
        gradientLayerStudent.colors = [UIColor(red: 255/255, green: 246/255, blue: 135/255, alpha: 1).cgColor, UIColor(red: 245/255, green: 65/255, blue: 108/255, alpha: 1).cgColor]
        gradientLayerStudent.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayerStudent.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayerStudent.frame = ExamCard.bounds;
        gradientLayerStudent.cornerRadius = 20.0
        
        gradientLayerExam.shouldRasterize = true
        gradientLayerStudent.shouldRasterize = true
        
        StudentCard.layer.insertSublayer(gradientLayerStudent, below:StudentLabel.layer);
        ExamCard.layer.insertSublayer(gradientLayerExam, below: ExamLabel.layer);
    }


}

