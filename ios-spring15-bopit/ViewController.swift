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
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pauseLabel: UILabel!
    
    var swipeGestures: [UISwipeGestureRecognizer]!
    
    
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
    
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            game.checkActions("Left")
        }
        
        if (sender.direction == .Right) {
            game.checkActions("Right")        }
        
        if (sender.direction == .Up) {
            game.checkActions("Up")
        }
        
        if (sender.direction == .Down) {
            game.checkActions("Down")        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added gestures (Swipes)
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)

        //swipeGestures.append(leftSwipe)
        //swipeGestures.append(rightSwipe)
        //swipeGestures.append(upSwipe)
        swipeGestures = [leftSwipe, rightSwipe, upSwipe, downSwipe]
        
        // Do any additional setup after loading the view, typically from a nib.
        game = gameClass(buttons: buttons, instructionLabel: instructionLabel, scoreLabel: scoreLabel, gameOverButtons: gameOverButtons, pauseLabel: pauseLabel, swipeGestures: swipeGestures)
        game.startNewGame()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

