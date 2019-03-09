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
    var operand = 0
    var answer = 0.0
    var numberText = ""
    var convertToPercent = true
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        displayNumberText()
    }
    
    // Display selected number or result to resultLabel
    func displayNumberText() {
        resultLabel.text = numberText
    }

    // Concatenate numbers and decimal point into a string variable
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if sender.tag >= 0 && sender.tag <= 9 {
            numberText += String(sender.tag)
        }
        // Decimal point pressed
        if sender.tag == 10 {
            numberText += "."
        }
        displayNumberText()
    }
    
    // Clear/Operand button is pressed
    @IBAction func operandPressed(_ sender: UIButton) {
        
        // Save displayed number when operand button is pressed (/, *, -, +)
        if sender.tag >= 14 && sender.tag <= 17 {
            // Show error message when user press operand before entering a number
            if numberText.isEmpty {
                showAlert(withErrorMessage: "No number entered")
            }
            else {
                operand = sender.tag
                saveNum1()
            }
        }
        
        // Reset number variable and display when CLEAR button is pressed
        if sender.tag == 11 {
            numberText = ""
            displayNumberText()
            convertToPercent = false
        }
    }
    
    // Save the previous number
    func saveNum1() {
        num1 = Double(numberText)!
        displayNumberText()
        numberText = ""
    }
    
    // Calculate two numbers when equal button is pressed and display result
    @IBAction func calculate(_ sender: UIButton) {
        
        // Assign current number to working variable
        guard let num2 = Double(numberText) else {
            showAlert(withErrorMessage: "No number entered")
            return
        }
        
        switch operand {
        case plus:
            answer = num1 + num2
        case minus:
            answer = num1 - num2
        case multiply:
            answer = num1 * num2
        case divide:
            // If user is trying to divide by zero, show an error message and don't perform division
            if num2 == 0 {
                showAlert(withErrorMessage: "Cannot divide by zero")
            }
            else {
                answer = num1 / num2
            }
        default:
            break
        }
 
        // Assign answer to the number variable and display the result
        numberText = String(answer)
        displayNumberText()
        // numberText = ""
        
        // Reset working variables
        num1 = 0.0
        operand = 0
        answer = 0.0
    }
    
    // Determine factorial of a given whole number
    @IBAction func factorialButtonPressed(_ sender: UIButton) {
        
        guard let theNumber = Double(resultLabel.text!) else {
            showAlert(withErrorMessage: "No whole number entered for factorial.")
            return
        }
        
        if theNumber < 0 {
            showAlert(withErrorMessage: "Enter a positive whole number for factorial.")
            numberText = ""
            displayNumberText()
            return
        }
        else {
            var total = 1
            if theNumber != 0 {
                for num in 1...Int(theNumber){
                    total *= num
                }
            }
            numberText = String(total)
            displayNumberText()
        }
    }
    
    // Convert positive number to negative number and vice-versa
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        
        if numberText.isEmpty {
            numberText = "-"
        }
        else {
            if Double(numberText)! > 0 {
                numberText.insert("-", at: numberText.startIndex)
            }
            else {
                numberText.remove(at: numberText.startIndex)
            }
        }
        displayNumberText()
    }
    
    // Convert whole numbers to percents
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        
        guard let theNumber = Double(resultLabel.text!) else {
            showAlert(withErrorMessage: "No number entered. Please enter a number and press '%' again.")
            return
        }
        if convertToPercent {
            answer = theNumber / 100
            convertToPercent = false
        }
        else {
            answer = theNumber * 100
            convertToPercent = true
        }
        numberText = String(answer)
        displayNumberText()

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

