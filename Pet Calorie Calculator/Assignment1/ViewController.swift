//
//  ViewController.swift
//  Asssignment1
//
//  Created by Tran, Thi Khanh Uyen - traty145 on 3/9/20.
//  Copyright © 2020 Tran, Thi Khanh Uyen - traty145. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Declare global variables
    
    var caloRequire: Double = 0;
    var image = UIImage(named: "pet.png")
    var imageFooter = UIImage(named: "food.png")
    
    @IBOutlet weak var footerImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var typeLabel: UISegmentedControl!
    @IBOutlet weak var ageSegment: UISegmentedControl!
    @IBOutlet weak var weightSegment: UISegmentedControl!
    
    //When selected segment has been changed, weight is automaticaly converted from kg to pound and the other way
    
    @IBAction func weightSegment(_ sender: UISegmentedControl) {
        
        let weight = Double(weightTextField.text!)
        let segment = weightSegment.selectedSegmentIndex
        
        
        switch segment {
        case 0:
            let weightInKg = (weight ?? 0)/0.453592
            weightTextField.text = String(weightInKg)
        case 1:
            let weightInPound = (weight ?? 0)*0.453592
            weightTextField.text = String(weightInPound)
        default:
            weightTextField.text = "!!!"
        }
        
    }

    //Calculate calorie required amount
  
    @IBAction func calculateBtn(_ sender: UIButton) {
        let title = weightSegment.titleForSegment(at: weightSegment.selectedSegmentIndex)
        
        
        //check if input field is empty
        
        if(!weightTextField.hasText){
            outputLabel.text = "Valid input required!!!"
            
            //set focus on input text field
            weightTextField.becomeFirstResponder()
        }
        else
        {
        
            let weight = Double(weightTextField.text!)
            let weightInPoundConverted = (weight ?? 0)*0.453592
            var rerNumber: Double = 0;
            
            // weight is automatically converted to kg before calculating calorie required amount
            
            switch title{
            case "Kg":
                rerNumber = 70 * pow(weight ?? 0,0.75)
            case "Pound":
                rerNumber = 70 * pow(weightInPoundConverted ,0.75)
                weightTextField.text = String(round(weightInPoundConverted*100)/100)
                weightSegment.selectedSegmentIndex = 0
            case .none:
                weightTextField.becomeFirstResponder()
            case .some(_):
                weightTextField.becomeFirstResponder()

            }
        
        
        if(typeLabel.selectedSegmentIndex == 0){
            if(ageSegment.selectedSegmentIndex == 0){
                caloRequire = 1.6 * rerNumber
            }
            else if (ageSegment.selectedSegmentIndex == 1){
                caloRequire = 1.8 * rerNumber
            }
            else if (ageSegment.selectedSegmentIndex == 2){
                caloRequire = 2.5 * rerNumber
            }
            
        } else if(typeLabel.selectedSegmentIndex == 1){
            if(ageSegment.selectedSegmentIndex == 0){
                caloRequire = 1.2 * rerNumber
            }
            else if (ageSegment.selectedSegmentIndex == 1){
                caloRequire = 1.6 * rerNumber
            }
            else if (ageSegment.selectedSegmentIndex == 2){
                caloRequire = 2.5 * rerNumber
            }
            
            
            }
            outputLabel.text = String(round(caloRequire*10)/10);
        }
        
        
        
    }
    
    @IBOutlet weak var foodCaloTextField: UITextField!
    
    @IBOutlet weak var outputFoodAmountLabel: UILabel!
    
    //Calculate food amount based on calorie requirement
    
    @IBAction func calculateFoodAmountBtn(_ sender: UIButton) {
        
        let foodCalo = Double(foodCaloTextField.text!)
        var foodAmountRequired: Double
        
        //check if calorie required amount has been calculated
        
        if(outputLabel.text == "Valid input required!!!") {
            weightTextField.becomeFirstResponder()
            outputFoodAmountLabel.text = "Valid input required!!!"
            
        }else if (!foodCaloTextField.hasText){
            foodCaloTextField.becomeFirstResponder()
                outputFoodAmountLabel.text = "Valid input required!!!"
        }
        else {
            foodAmountRequired = Double((caloRequire)/(foodCalo ?? 1))
            outputFoodAmountLabel.text = String(round(foodAmountRequired*10)/10)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       //Load images into view
        logoImage.image = image;
        footerImage.image = imageFooter;
        
        // Divide segment width fit with content
        ageSegment.apportionsSegmentWidthsByContent = true
        typeLabel.apportionsSegmentWidthsByContent = true


    }


}

