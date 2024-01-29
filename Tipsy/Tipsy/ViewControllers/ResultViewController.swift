//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Bengi Anıl on 13.01.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var result = "0.0"
    var tip = 10
    var split = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewComponents()
    }
    
    private func prepareViewComponents() {
        let personByBill = (Double(result) ?? 0.0)/Double(split)
        totalLabel.text = String(personByBill)
    }
    
    @IBAction func tappedRecalculate(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
