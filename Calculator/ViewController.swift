//
//  ViewController.swift
//  Calculator
//
//  Created by NKT on 2/25/17.
//  Copyright © 2017 NKT. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiaction
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    
    
    
    var labelString: String = "0"
    var currentMode: modes = modes.not_set
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: modes.addition)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: modes.subtraction)
    }
    
    @IBAction func didPressMulti(_ sender: Any) {
        changeMode(newMode: modes.multiaction)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        if(currentMode == modes.not_set || lastButtonWasMode){
            return
        }
        if(currentMode == modes.addition) {
            savedNum += labelInt
        }else if(currentMode == modes.subtraction){
            savedNum -= labelInt
        }
        else if(currentMode == modes.multiaction){
            savedNum *= labelInt
        }
        currentMode = modes.not_set
        labelString = String(savedNum)
        updateText()
        lastButtonWasMode = true
    }

    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = modes.not_set
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue: String? = sender.titleLabel?.text
        if (lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    func updateText() {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        if(currentMode == modes.not_set) {
            savedNum = labelInt
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        label.text = formatter.string(from: num)
    }
    
    func changeMode(newMode: modes) {
        if (savedNum == 0) {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
        
    }

}

