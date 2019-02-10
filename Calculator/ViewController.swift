//
//  ViewController.swift
//  Calculator
//
//  Created by Ian Regino on 2/9/19.
//  Copyright © 2019 student14. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    let divide = 14
    let multiply = 15
    let minus = 16
    let plus = 17
    var num1 = 0.0
    var num2 = 0.0
    var operand = 0
    var answer = 0.0
    var theNumber = ""
    var percent = false
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        displayNumber()
    }
    
    // Display selected number or result to resultLabel
    func displayNumber() {
        resultLabel.text = theNumber
    }

    // Concatenate numbers and decimal point into a string variable
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if sender.tag >= 0 && sender.tag <= 9 {
            theNumber += String(sender.tag)
            displayNumber()
        }
        // Decimal point pressed
        if sender.tag == 10 {
            theNumber += "."
            displayNumber()
        }
    }
    
    // Clear/Operand button is pressed
    @IBAction func operandPressed(_ sender: UIButton) {
        
        // Save displayed number when operand button is pressed (/, *, -, +)
        if sender.tag >= 14 && sender.tag <= 17 {
            // Show error message when user press operand before entering a number
            if theNumber.isEmpty {
                showAlert(withErrorMessage: "No number entered")
            }
            else {
                operand = sender.tag
                saveNum1()
            }
        }
        
        // Reset number variable and display when clear button is pressed
        if sender.tag == 11 {
            theNumber = ""
            displayNumber()
            percent = false
        }
    }
    
    // Save the previous number
    func saveNum1() {
        num1 = Double(theNumber)!
        displayNumber()
        theNumber = ""
    }
    
    // Calculate two numbers when equal button is pressed and display result
    @IBAction func calculate(_ sender: UIButton) {
        
        // Assign current number to working variable
        num2 = Double(theNumber)!
        
        // Determine operand and perform appropriate calculation
        if operand == plus {
            answer = num1 + num2
        }
        if operand == minus {
            answer = num1 - num2
        }
        if operand == multiply {
            answer = num1 * num2
        }
        if operand == divide {
            // If user is trying to divide by zero, show an error message and don't perform division
            if num2 == 0 {
                showAlert(withErrorMessage: "Cannot divide by zero")
            }
            else {
                answer = num1 / num2
            }
        }
 
        // Assign answer to the number variable and display the result
        theNumber = String(answer)
        displayNumber()
        
        // Reset working variables
        num1 = 0.0
        num2 = 0.0
        operand = 0
        answer = 0.0
    }
    
    // Determine factorial of a given whole number
    @IBAction func factorialButtonPressed(_ sender: UIButton) {
        
        if theNumber.isEmpty || Int(theNumber)! < 0 {
            showAlert(withErrorMessage: "Enter a positive number, then press ! button")
        }
        else {
            let factorialNum = Int(theNumber)!
            var total = 1
            if factorialNum != 0 {
                for num in 1...factorialNum {
                    total *= num
                }
            }
            theNumber = String(total)
            displayNumber()
            theNumber = ""
        }
    }
    
    // Convert positive number to negative number and vice-versa
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        
        if theNumber.isEmpty {
            theNumber = "-"
        }
        else {
            if Double(theNumber)! > 0 {
                theNumber.insert("-", at: theNumber.startIndex)
            }
            else {
                theNumber.remove(at: theNumber.startIndex)
            }
        }
        displayNumber()
    }
    
    // Convert whole numbers to percents
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        
        if theNumber.isEmpty {
            showAlert(withErrorMessage: "No number entered")
        }
        else {
            if percent {
                answer = Double(theNumber)! * 100
                percent = false
            }
            else {
                answer = Double(theNumber)! / 100
                percent = true
            }
            theNumber = String(answer)
            displayNumber()
        }
    }
    
    // Show alert with specific error message
    func showAlert(withErrorMessage errorMsg: String) {
        // Create an alert instance
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        // Create an alert action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // Add alert action to alert instance
        alert.addAction(cancelAction)
        // Present the alert to user
        present(alert, animated: true)
    }
    
}

