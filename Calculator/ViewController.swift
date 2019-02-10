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
    var percent = 0.0
    
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
                showAlert(withErrorMessage: "Enter a number")
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
            showAlert(withErrorMessage: "Enter a number")
        }
        else {
            percent = Double(theNumber)! / 100
            theNumber = String(percent)
            displayNumber()
        }
    }
    
    // Show alert with specific error message
    func showAlert(withErrorMessage errorMsg: String) {
        
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
}

