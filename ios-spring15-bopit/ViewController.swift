//
//  ViewController.swift
//  ios-spring15-bopit
//
//  Created by Ethan Eldred on 3/5/15.
//  Copyright (c) 2015 Ethan Eldred. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var game : gameClass!
    var audioPlayer = AVAudioPlayer()
    
    var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonPressed", ofType: "mp3")!)
    var swipeSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("swiped", ofType: "wav")!)
    
    //Timer Variables
    let aSelector : Selector = "updateCounter"
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var restartGameTime : Double = 7
    var gameTime: Double = 7
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var gameOverButtons: [UIButton]!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var swipeGestures: [UISwipeGestureRecognizer]!
    
    var swipeGestureStrings: [String]!
    
    @IBAction func playAgainPressed(sender: UIButton) {
        game.startNewGame()
        gameTime = restartGameTime
        restartTimer()
        
    }
    
    @IBAction func pausePressed(sender: AnyObject) {
            game.pauseActions()
            print("Paused Game")
            timer.invalidate()
    }
    
    //going to reimplement timer just to make it work for now
    @IBAction func redButtonPressed(sender: UIButton) {
        if(game.checkActions("Red")){
            restartTimer()
        }
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        println("Red Pressed")
        
    }
    
    //going to reimplement timer just to make it work
    @IBAction func blueButtonPressed(sender: UIButton) {
        
        if (game.checkActions("Blue")){
            restartTimer()
        }
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        println("Blue Pressed")
    }
    
    
    //Going to reimplement later Just to make it work.
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        for i in 0...3{
            if(sender.direction == swipeGestures[i].direction){
                if game.checkActions(swipeGestureStrings[i]){
                    restartTimer()
                }
                else{
                    timer.invalidate()
                }
            }
        }
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: swipeSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()

    }
    
    //Timer functions
    func restartTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: aSelector, userInfo: nil, repeats: true)

        if ((game.score%10 == 0) && (gameTime > 1)){
            gameTime--
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        else{
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func updateCounter(){
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        var seconds = gameTime - elapsedTime
        if(seconds > 0){
            elapsedTime -= NSTimeInterval(seconds)
            timerLabel.text = String(NSInteger(seconds))
        }
        else{
            game.gameOver()
            timer.invalidate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        timerLabel.text = String(NSInteger(startTime))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)

        swipeGestures = [leftSwipe, rightSwipe, upSwipe, downSwipe]
        swipeGestureStrings = ["Left", "Right", "Up", "Down"]
        
        // Do any additional setup after loading the view, typically from a nib.
        game = gameClass(buttons: buttons, instructionLabel: instructionLabel, scoreLabel: scoreLabel,
            timerLabel: timerLabel, gameOverButtons: gameOverButtons, pauseLabel: pauseLabel, swipeGestures: swipeGestures)
        game.startNewGame()
        restartTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

