//
//  GameScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 25/3/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    
    var movingBridge: MovingBridge!
    var player: Player!
    var blocksGenerator: BlocksGenarator!
    var cloudGenerator: CloudsGenarator!
    
    var isGameStarted = false
    var isGameOver = false
    
    /*
     
     Function: didMove
     Parameters: SKView
     
     Purpose: This function will run as soon as the screen loads-up
     creates all elements of the scene
     
     "CGPoint" method is use for positioning all the elements inside od the view
     
     **Important note for developpers**
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // creates the moving bridge
        movingBridge = MovingBridge(size: CGSize(width: self.size.width, height: 420))
        movingBridge.position = view.center
        movingBridge.zPosition = 1
        self.addChild(movingBridge)
        
        
        // creates the player
        player = Player()
        player.position = CGPoint(x: 350, y: movingBridge.position.y + movingBridge.frame.size.height/2 + player.frame.size.height/2)
        self.addChild(player)
        player.breath() // call the breath animation
        
        // creates the blocks
        
        blocksGenerator = BlocksGenarator(color: UIColor.clear, size: view.frame.size)
        blocksGenerator.position = view.center
        addChild(blocksGenerator)
        
        // add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
        
        
        
        /*
         This label is allow user to tap on the screen to start the game
         this funtion named the label again to access the node in start method
         
         */
        
        let tapToStartLabel = SKLabelNode(text: "Tap to Start")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.fontColor = UIColor.white
        tapToStartLabel.fontSize = 100
        // tapToStartLabel.zPosition = 1
        self.addChild(tapToStartLabel)
        
        
        func addPointsLabels(){
            // let pointLabel = PointsLabel(num:0)
            
        }
        /*
         Add the physics world
         */
        
        physicsWorld.contactDelegate = self
        
    }
    
    /*
     
     Function: start
     Parameters: none
     
     Purpose : Provide a lable telling user to tap to start the game.
     After user taps, the lable disapear annd player stops breathing animation,starts running
     Also the bridge moves and blocks generates every 1 seconds
     
     ** Important note for developers**
     Developer can change the time of blocks generating as they want
     
     */
    
    func start(){
        
        isGameStarted = true
        let tapToStartLable = childNode(withName: "tapToStartLabel")
        tapToStartLable?.removeFromParent()
        player.stop()
        player.startRunning()
        movingBridge.start()
        blocksGenerator.startBlocksGenaratingIsEvery(seconds: 1)
        
        
    }
    
    /*
     
     Function: gameOver
     
     Parameters : none
     
     Purpose: This function will stop everything after player hits a block
     User can restart the game by tapping on the label(gameOverLabel)
     
     
     */
    
    func gameOver(){
        
        isGameOver = true
        player.physicsBody = nil
        blocksGenerator.stopBlocks()
        movingBridge.stop()
        player.stop()
        
        let gameOverLabel = SKLabelNode(text: "Ops! You are dead!")
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.fontSize = 100
        self.addChild(gameOverLabel)
        
        
    }
    
    /*
     
     Function: restart
     Parameters:none
     
     Purpose: This function will call after user taps on gameOverLabel.
     creates a new scene to retart the game
     */
    
    func restart (){
        
       
        cloudGenerator.stopGeneratingClouds()
        let  newScene = GameScene(size: CGSize(width: 1536, height: 2048))
        newScene.scaleMode = .aspectFill
        view?.presentScene(newScene)
        
    }
    
    
    /*
     Funtion : didBegin
     
     Purpose: This funtion will detect every time when the user hits a block
     
     ** Important note for developers**
     Developers can use  "print("did began called")" to see if the game
     workd correctly
     
     */
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        gameOver()
        //print("did began called")
    }
    
    /*
     Funtion: touchesBegan
     
     Purpose: this function is called when user taps on the screen.
     first, the game will start, all the background images will uploaded
     
     if the game is over, user can tap on the screen to restart the game
     if game game is not over but not started (newgame), user can tap on the screen to strat.
     while running, user can tap to jump
     
     ** Important note for developers**
     If developers want to add animation parts of any background elements make sure those funtions
     are called here
     
     
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver {
            restart ()
        }
            
        else  if !isGameStarted {
            start()
            
            
        }else {
            player.jump()
            
        }
        
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    

}
