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
    private let gameOverButtons: [UIButton]!
    private let directions: [String]
    private var rand: Int
    
    
    var score : Int = 0
    init (buttons: [UIButton], instructionLabel: UILabel, scoreLabel: UILabel, gameOverButtons: [UIButton]) {
        directions = ["Blue", "Red"]
        rand = Int(arc4random_uniform(2))
        isPaused = false
        self.buttons = buttons
        self.instructionLabel = instructionLabel
        self.scoreLabel = scoreLabel
        self.gameOverButtons = gameOverButtons
    
    }

    func startNewGame() {
        instructionLabel.text = "Press " + directions[rand]
        score = 0;
        enableActions()
        hideGameOver()
        updateScore()
    }
    
    func checkActions(action: String){
        if directions[rand] == action{
            rand = Int(arc4random_uniform(2))
            instructionLabel.text = "Press " + directions[rand]
            
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
        }
        else {
            disableActions()
            isPaused = true
        }
    }
    
    func enableActions() {
        for x in 0...buttons.count - 1 {
            buttons[x].enabled = true
        }
    }
    
    func disableActions() {
        for x in 0...buttons.count - 1 {
            buttons[x].enabled = false
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
        instructionLabel.text = "GAME OVER"
        showGameOver()
    }
    
    
    
}