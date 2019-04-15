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
    
    var button: SKNode!
    var liveScreen: SKSpriteNode!
    
    var liveScene: StartScene!
   
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
        
       createLiveButton()
        
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
     
     Function: createLiveButton
     
     Purpose: This function creates the button (heart) top left corner of the view
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under didMove function.
    
     */
    
    func createLiveButton(){
        
        // Create a simple red rectangle that's 100x44
        let liveButtonTexture = SKTexture(imageNamed: "lives")
        button = SKSpriteNode(texture: liveButtonTexture , size: CGSize(width: 100, height: 100))
        // Put it in the center of the scene
        button.position = CGPoint(x: 400, y: 1800)
        button.zPosition = 1
        
        self.addChild(button)
        
    }
    
    /*
     
     Function: createLiveButton
     
     Purpose: This function creates the window and its elements when user taps onthe heart button
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under touchesEnded function.
     
     */
    
    func createLivesWindow()
    {
        
        liveScreen = SKSpriteNode(color: UIColor(red: 153.0/255.0, green: 255.0/255.0, blue: 204.0/255.0, alpha: 5.0), size: CGSize(width: 700, height: 700))
        liveScreen.position = CGPoint(x:770, y: 1300)
        self.isUserInteractionEnabled = true
        addChild(liveScreen)
        
        
        let livesLabel1 = SKLabelNode(text: "Get more Lives ")
        livesLabel1.name = "livesLabel1"
        livesLabel1.position = CGPoint(x:870, y: 1900)
        livesLabel1.zPosition = 10
        livesLabel1.fontColor = UIColor.black
        livesLabel1.fontSize = 200
        liveScreen.addChild(livesLabel1)
        
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
    
    func gameOver()
    {
        
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
     
     Purpose: This funtion will detect every time when the user hits a block. all the animatons after
     player hiting a block will call here
     
     ** Important note for developers**
     Developers can use  "print("did began called")" to see if the game
     workd correctly
     
     */
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        player.burn()
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
            }
        
            
            
        else {
            
            player.jump()
            
            }
        
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if button.contains(location) {
                print("tapped!")
                
            createLivesWindow()
 
 
 
 
            }
        }
    }
        
    }
    
    
    


