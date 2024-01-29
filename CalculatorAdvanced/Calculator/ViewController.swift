//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    fileprivate var isFinishedTypingNumber: Bool = true
    
    override func viewDidLoad() {
        var aaa = "İELLO WORLD"
        print(aaa.lowercased().capitalized)
    }
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        
        set {
            displayLabel.text = String(newValue) ///newValue == displayValue
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true

    }
    
    func a() {
        var x = 0
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton)  {

        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
            displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
}

