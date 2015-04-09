//
//  ViewController.swift
//  ios-spring15-bopit
//
//  Created by Ethan Eldred on 3/5/15.
//  Copyright (c) 2015 Ethan Eldred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game : gameClass!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var gameOverButtons: [UIButton]!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func playAgainPressed(sender: UIButton) {
        game.startNewGame()
        
    }
    @IBAction func pausePressed(sender: AnyObject) {
        
        game.pauseActions()
        print("Paused Pressed")
    }
    
    @IBAction func redButtonPressed(sender: UIButton) {
        game.checkActions("Red")
        println("Red Pressed")
        
    }
    
    @IBAction func blueButtonPressed(sender: UIButton) {
        
        game.checkActions("Blue")
        println("Blue Pressed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = gameClass(buttons: buttons, instructionLabel: instructionLabel, scoreLabel: scoreLabel, gameOverButtons: gameOverButtons)
        game.startNewGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

