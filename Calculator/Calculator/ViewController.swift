//
//  ViewController.swift
//  Calculator
//
//  Created by user252223 on 11/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorWork: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    var work:String = ""
    
    func allClear() {
        work = ""
        calculatorWork.text = ""
        calculatorResult.text = ""
    }
    
    func addToWork(value: String) {
        work += value
        calculatorWork.text = work
    }
    
    func formatResult(result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        }
        else {
            return String(format: "%.2f", result)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allClear()
    }

    @IBAction func clearAll(_ sender: Any) {
        allClear()
    }
    
    
    @IBAction func clearSingle(_ sender: Any) {
        if(!work.isEmpty) {
            work.removeLast()
            calculatorWork.text = work
        }
    }
    
    
    @IBAction func percent(_ sender: Any) {
        addToWork(value: "%")
    }
    
    
    @IBAction func divide(_ sender: Any) {
        addToWork(value: "/")
    }
    
    
    @IBAction func multiply(_ sender: Any) {
        addToWork(value: "*")
    }
    
    
    @IBAction func add(_ sender: Any) {
        addToWork(value: "+")
    }
    
    
    @IBAction func substrack(_ sender: Any) {
        addToWork(value: "-")
    }
    
    
    @IBAction func equals(_ sender: Any) {
        if(validInput()) {
            let checkedWorkingForPercentage = work.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingForPercentage)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResult.text = resultString
        }
        else {
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator unable to do math based on input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() ->Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in work {
            if(specialCharacter(char: char)) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes {
            if(index == 0) {
                return false
            }
            
            if(index == work.count - 1) {
                return false
            }
            
            if (previous != -1) {
                if(index - previous == 1) {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func specialCharacter (char: Character) -> Bool {
        if(char == "*") {
            return true
        }
        if(char == "/") {
            return true
        }
        if(char == "+") {
            return true
        }
        return false
    }
    
    @IBAction func dot(_ sender: Any) {
        addToWork(value: ".")
    }
    
    
    @IBAction func zero(_ sender: Any) {
        addToWork(value: "0")
    }
    
    
    @IBAction func one(_ sender: Any) {
        addToWork(value: "1")
    }
    
    @IBAction func two(_ sender: Any) {
        addToWork(value: "2")
    }
    
    
    @IBAction func three(_ sender: Any) {
        addToWork(value: "3")
    }
    
    
    @IBAction func four(_ sender: Any) {
        addToWork(value: "4")
    }
    
    
    @IBAction func five(_ sender: Any) {
        addToWork(value: "5")
    }
    
    
    @IBAction func six(_ sender: Any) {
        addToWork(value: "6")
    }
    
    
    @IBAction func seven(_ sender: Any) {
        addToWork(value: "7")
    }
    
    
    @IBAction func eight(_ sender: Any) {
        addToWork(value: "8")
    }
    
    
    @IBAction func nine(_ sender: Any) {
        addToWork(value: "9")
    }
}

