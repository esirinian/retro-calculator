//
//  ViewController.swift
//  retro-calculator
//
//  Created by Eric Sirinian on 1/8/17.
//  Copyright © 2017 Eric Sirinian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    
    var currentOp = Operation.Empty
    var runningNum =  ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
    
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = String(0)
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNum += "\(sender.tag)"
        outputLabel.text = runningNum
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualsPresse(sender: AnyObject) {
        processOperation(operation: currentOp)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(operation: .Clear)
        
    }
    
    func playSound() {
        if (btnSound.isPlaying) {
            btnSound.stop()
        }
        btnSound.play();
    }
    
    
    func processOperation (operation: Operation) {
        
        playSound()
        
        if currentOp != Operation.Empty {
            if runningNum != "" {
                rightValStr = runningNum
                runningNum = ""
                
                if currentOp == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOp == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOp == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOp == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLabel.text = result
                currentOp = operation
            }
        } else {
            leftValStr = runningNum
            runningNum = ""
            currentOp = operation
        }
        
        if operation == Operation.Clear {
            currentOp = Operation.Empty
            runningNum = ""
            result = "0.0"
            rightValStr = ""
            leftValStr = ""
            outputLabel.text = result
        }
    }
}

