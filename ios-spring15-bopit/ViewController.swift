//
//  ViewController.swift
//  ios-spring15-bopit
//
//  Created by Ethan Eldred on 3/5/15.
//  Copyright (c) 2015 Ethan Eldred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var directions: [String] = ["Blue","Red"]
    var index: Int = Int(arc4random_uniform(2))
    var score: Int = 0
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func redButtonPressed(sender: UIButton) {
        if (directions[index] == "Red"){
            index = Int(arc4random_uniform(2))
            instructionLabel.text = "Press" + directions[index]
            score++
            scoreLabel.text = "Score: " + String(score)
        }
        else {
            instructionLabel.text = "GAME OVER"
            buttons[0].enabled = false
            buttons[1].enabled = false
            
        }
        println("Red Pressed")
        
    }
    @IBAction func blueButtonPressed(sender: UIButton) {
        
        if (directions[index] == "Blue"){
            index = Int(arc4random_uniform(2))
            instructionLabel.text = "Press" + directions[index]
            score++
            scoreLabel.text = "Score: " + String(score)
        }
        else {
            instructionLabel.text = "GAME OVER"
            buttons[0].enabled = false
            buttons[1].enabled = false
        }
        println("Blue Pressed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructionLabel.text = "Press" + directions[index]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

