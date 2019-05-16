//
//  GameOverScene.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 15/5/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var cloudGenerator:CloudsGenarator!
    
    var score: Int = 0
    var highScore: String?
    var userName: String?
    
    override func didMove(to view: SKView) {
        
        //background image
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Blocks and Run name label
        let nameOfTheGameLabel = SKLabelNode(text: "Blocks and Run")
        nameOfTheGameLabel.name = "tapToStartLabel"
        nameOfTheGameLabel.position = CGPoint(x: self.size.width/2, y: 1500)
        nameOfTheGameLabel.fontColor = UIColor.white
        nameOfTheGameLabel.fontSize = 100
        self.addChild(nameOfTheGameLabel)
        
        //add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
        let gameOverLabel = SKLabelNode(text: "GAME OVER !!")
        gameOverLabel.name = "tapToStartLabel"
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: 1600)
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.fontSize = 100
        self.addChild(gameOverLabel)
        
        let ScoreLabel = SKLabelNode(text: "Score: \(score)")
        ScoreLabel.name = "tapToStartLabel"
        ScoreLabel.position = CGPoint(x: self.size.width/2, y: 1500)
        ScoreLabel.fontColor = UIColor.white
        ScoreLabel.fontSize = 100
        self.addChild(ScoreLabel)
        
        let HighScoreLable = SKLabelNode(text: "High Score: \(String(describing: highScore))")
        HighScoreLable.name = "tapToStartLabel"
        HighScoreLable.position = CGPoint(x: self.size.width/2, y: 1400)
        HighScoreLable.fontColor = UIColor.white
        HighScoreLable.fontSize = 100
        self.addChild(HighScoreLable)
        
        
        
        
    }
    
    

}
