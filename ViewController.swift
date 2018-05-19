//
//  ViewController.swift
//  mvc_calc
//
//  Created by mino on 4/15/18.
//  Copyright © 2018 marwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTypingNumber = false
    
    var model = calc_Brain()
    
    var displayNumber: Double {
        get {
            
            return Double(display.text!)!
        }
        set {
            
            self.display.text = String(newValue)
        
           
        }
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        self.model.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func digits(_ sender: AnyObject) {
        
        guard let digitToAdd = sender.currentTitle else { return }
        
        if userIsTypingNumber {
        display.text! += digitToAdd!
        } else {
        guard digitToAdd != "0" else {
        display.text = "0"
        return
        }
        display.text = digitToAdd
        userIsTypingNumber = true
        }
       
        
    }

    var displayValue: Double {
        get {
           return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }


    @IBAction func performOperation(_ sender: UIButton) {
        userIsTypingNumber = false
        self.model.accumulator = displayNumber
        
        if let operationToPerform = sender.currentTitle {
            self.model.performOperation(operationToPerform)
        }
        /*if  let mathsymbol=sender.currentTitle{
            switch mathsymbol {
            case "π":
                displayValue=Double.pi
            case"√":
                /*let operand=Double(display.text!)
                display.text=String(sqrt(operand!))
                */
                displayValue=sqrt(displayValue)
                
                
            default:
                print("default")
               
            }
        }*/
        
    }

    @IBAction func clear(_ sender: UIButton) {
        display.text=""
    }
}

extension ViewController: CalculatorBrainDelegate {
    func accumulatorDidChange(_ newValue: Double) {
        displayNumber = newValue
    }
}
