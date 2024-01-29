//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationViewController = segue.destination as! ResultViewController
            destinationViewController.split = numberOfPeople
            destinationViewController.tip = Int(tip)
            destinationViewController.result = finalResult
        }
    }
    
    @IBAction func changedTipAmount(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle =  sender.currentTitle!
        let tipAsInt = buttonTitle.filter { "0123456789".contains($0) }
        tip = (Double(tipAsInt) ?? 0.0)/100
    }
    
    @IBAction func changedStepperValue(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = String(numberOfPeople)
    }
    
    @IBAction func tappedCalculate(_ sender: UIButton) {
        if let bill = Double(billTextField.text ?? "0.0") {
            billTotal = bill + tip
        }
        finalResult = String(billTotal)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
}

