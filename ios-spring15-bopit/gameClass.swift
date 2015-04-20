//
//  gameClass.swift
//  ios-spring15-bopit
//
//  Created by Alex Heinen on 4/8/15.
//  Copyright (c) 2015 Ethan Eldred. All rights reserved.
//

import Foundation
import UIKit


class gameClass{

    private var isPaused: Bool
    private let buttons: [UIButton]!
    private var instructionLabel: UILabel!
    private var scoreLabel: UILabel!
    private let pauseLabel: UILabel!
    private let gameOverButtons: [UIButton]!
    private let directions: [String]
    private var rand: Int
    private var swipeRand: Int
    private var buttonRand: Int
    private var swipeGestures: [UISwipeGestureRecognizer]!
    
    
    var score : Int = 0
    init (buttons: [UIButton], instructionLabel: UILabel, scoreLabel: UILabel, gameOverButtons: [UIButton], pauseLabel: UILabel, swipeGestures: [UISwipeGestureRecognizer]) {
        directions = ["Blue", "Red","Left", "Right", "Up", "Down"]
        rand = Int(arc4random_uniform(6))
        buttonRand = Int(arc4random_uniform(2))
        swipeRand = Int(arc4random_uniform(4))
        isPaused = false
        self.buttons = buttons
        self.instructionLabel = instructionLabel
        self.scoreLabel = scoreLabel
        self.gameOverButtons = gameOverButtons
        self.pauseLabel = pauseLabel
        self.swipeGestures = swipeGestures
    }

    func startNewGame() {
        instructionLabel.text = directions[rand]
        score = 0;
        pauseLabel.hidden = true
        enableActions()
        hideGameOver()
        updateScore()
    }
    
    func checkActions(action: String){
        if directions[rand] == action{
            rand = Int(arc4random_uniform(6))
            instructionLabel.text = directions[rand]
            score++
            updateScore()
        }
        else {
            gameOver()
        }
    }
    
    func updateScore() {
        scoreLabel.text = "Score: " + String(score)
    }
    
    func pauseActions() {
        if (isPaused) {
            enableActions()
            isPaused = false
            pauseLabel.hidden = true
        }
        else {
            disableActions()
            
            pauseLabel.hidden = false
            isPaused = true
        }
    }
    
    func enableActions() {
        for x in 0...buttons.count - 1 {
            buttons[x].enabled = true
        }
        for n in 0...swipeGestures.count - 1 {
            swipeGestures[n].enabled = true
        }
    }
    
    func disableActions() {
        for x in 0...buttons.count - 1 {
            buttons[x].enabled = false
        }
        for n in 0...swipeGestures.count - 1 {
            swipeGestures[n].enabled = false
        }
    }
    
    func showGameOver(){
        for i in 0...gameOverButtons.count - 1{
            gameOverButtons[i].hidden = false
        }
    }
    
    func hideGameOver(){
        for i in 0...gameOverButtons.count - 1{
            gameOverButtons[i].hidden = true
        }
    }
    
    func gameOver (){
        disableActions()
        rand = Int(arc4random_uniform(6))
        instructionLabel.text = "GAME OVER"
        showGameOver()
    }
    
    
    
}