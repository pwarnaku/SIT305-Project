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
    
    //Buttons
    var button: SKNode!
    var settingsButton: SKNode!
    
    //Scenes
    var liveScene: StartScene!
   
    //Objects
    var movingBridge: MovingBridge!
    var player: Player!
    var blocksGenerator: BlocksGenarator!
    var cloudGenerator: CloudsGenarator!
    
    //Audio clips
    let backgroundSound = SKAudioNode(fileNamed: "backgroundMusic.mp3")
    let screamSound = SKAudioNode(fileNamed: "Scream.mp3")
    
    //boolean values
    var isGameStarted = false
    var isGameOver = false
    var isLivesAvailable: Bool!
    
    //diamonds
    var diamonds:[Diamonds] = []
    
    //FireBalls
    var fireBalls: [FireBalls] = []
    
    //Lives array
    var livesArray: [SKSpriteNode]!
    var Defaultlives: Int = 2
    
    //collider types
    enum ColliderType:UInt32 {
        case Player = 1
         case FireBalls = 2
        case Diamonds = 3
    }
    //collider types
    
    let playerBody: UInt32 = 0x1 << 0
    let fireBallBody: UInt32 = 0x1 << 1
    
    
    //limits
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()

    //limits for birds
    var endOfScreenRightofFireBalls = CGFloat()
    var endOfScreenLeftofFireBalls = CGFloat()
    
    let array = UserDefaults.standard.object(forKey:"player") as? [String] ?? [String]()
  
    
    //variables related to Score and High Score
    var nameLable:SKLabelNode!
    var highScoreLable:SKLabelNode!
    var scoreLable:SKLabelNode!
    var score:Int = 0{
        didSet{
            scoreLable.text = " \(score) "
        }
    
    }
   // highscaore value
    var highScore:Int = 0{
        didSet{
            if getName() == "\(array[0])" {
                highScoreLable =  SKLabelNode(text: "High Score: \(array[1])")
            }
                
            else {
                
                highScoreLable =  SKLabelNode(text: "High Score: \(highScore)")
                
            }
        }
    }

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
        
        //creates buttons
        
        createLiveButton()
       
        
        endOfScreenLeft = (1200) * CGFloat(-1)
        endOfScreenRight = 2900
        
        endOfScreenLeftofFireBalls = (1200) * CGFloat(-1)
        endOfScreenRightofFireBalls = 1500
        
        // creates objects
        
        createTheBackground()
        createTheMovingBridge()
        createThePlayer()
        createBlocks()
        addFireBalls()
        generateClouds()
        startGameLable()
        scoreLabel()
        addLives()
       // nameLabel()
        highScoreLabel()

        // add background music
       
       self.addChild(backgroundSound)
        
        // Add the physics world
        physicsWorld.contactDelegate = self

    }
    
    
    
    /*
     
     Function: getName
     
     Purpose: This function gets the 'User name' that user has entered when start the game using UserDefaults
     
     ** Important note for developers**
     
     This function is called in few places to get the user name easily.
     
     */
    
    func getName() -> String{
        return UserDefaults.standard.string(forKey: "userName")!
    }
    
    
    /*
     
     Function: createTheBackground
     
     Purpose: This function creates the background.
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createTheBackground(){
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
    }
    
    /*
     
     Function: createTheMovingBridge
     
     Purpose: This function creates the moving bridge.
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createTheMovingBridge(){
        
        movingBridge = MovingBridge(size: CGSize(width: self.size.width, height: 420))
        movingBridge.position = view!.center
        movingBridge.zPosition = 1
        self.addChild(movingBridge)
        
    }
    /*
     
     Function: addLives
     
     Purpose: This function is to manage lives. By default, the user has 3 lives. i have used an array to display
     available lives.
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func addLives(){
        livesArray = [SKSpriteNode]()
        for live in 1 ... 3 {
            let liveNode = SKSpriteNode(imageNamed: "lives-1")
            
            liveNode.position = CGPoint(x: 1300 - CGFloat(4 - live)*liveNode.size.width, y: 1730 )
            liveNode.size = CGSize(width: 60, height: 60)
            
            self.addChild(liveNode)
            livesArray.append(liveNode)
            
        }
    }
    
    
    /*
     
     Function: createThePlayer
     
     Purpose: This function creates the player and starting animations.
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createThePlayer(){
        
        
        player = Player()
        player.position = CGPoint(x: 380, y: 800)
        
        
        self.addChild(player)
        
    }
    
    /*
 
     Function: createBlocks
 
     Purpose: This function creates tblocks (fire).
 
     ** Important note for developers**
 
 
     This function is called in gamescene.swift file under didMove function.
     */
    
    
    func createBlocks(){
        
        blocksGenerator = BlocksGenarator(color: UIColor.clear, size: view!.frame.size)
        blocksGenerator.position = view!.center
        addChild(blocksGenerator)
    }
    
        /*
     
         Function: generateClouds
     
         Purpose: This function generate clouds
     
         ** Important note for developers**
     
        This function is called in gamescene.swift file under didMove function.
     
         */
    
    func generateClouds(){
        
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view!.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
    }
    
    /*
     
     Function: startGameLable
     
     Purpose: This function creates the  label which allows user to tap on the screen to start the game
     this funtion named the label again to access the node in start method
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     
     */
    
    func startGameLable(){
        
        let tapToStartLabel = SKLabelNode(text: "Tap to Start")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.fontName = "Marion-Italic"
        tapToStartLabel.fontColor = UIColor.white
        tapToStartLabel.fontSize = 80
        self.addChild(tapToStartLabel)
        tapToStartLabel.run(fadeInOut())
    }
    
    /*
     
     Function: scoreLabel
     
     Purpose: This function creates the  score label
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     
     */
    
    func scoreLabel(){
        
        scoreLable = SKLabelNode(text: " 0 ")
        scoreLable.position = CGPoint(x: self.size.width/2, y: 1700)
        scoreLable.fontName = "AmericanTypewiter-Bold"
        scoreLable.fontColor = UIColor.white
        scoreLable.fontSize = 90
        score = 0
        self.addChild(scoreLable)
    }
    
    /*
     
     Function: nameLable
     
     Purpose: This function creates the name label
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     
     */
  /*
    func nameLabel(){
        
        if getName() == "\(array[0])" {
        
            nameLable = SKLabelNode(text: "\(array[0])")
        }
        
        else {
            nameLable = SKLabelNode(text: "\(getName())")

        }
        
        nameLable.position = CGPoint(x: 1080, y: 1850)
        nameLable.fontName = "AmericanTypewiter-Bold"
        nameLable.fontColor = UIColor.white
        nameLable.fontSize = 60
        self.addChild(nameLable)
        
    } */
    
    /*
     
     Function: highScoreLable
     
     Purpose: This function creates the High Score lable. It uses saved array data to get the high score.
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     
     */
    
    func highScoreLabel(){
        
/*        if getName() == "\(array[0])" {
            
            highScoreLable =  SKLabelNode(text: "High Score: \(array[1])")
        }
            
        else {
            
           highScoreLable =  SKLabelNode(text: "High Score: 0")
            
        } */
         highScoreLable =  SKLabelNode(text: "High Score: 0")
        highScoreLable.position = CGPoint(x: 1080, y: 1800)
        highScoreLable.fontName = "AmericanTypewiter-Bold"
        highScoreLable.fontColor = UIColor.white
        highScoreLable.fontSize = 40
        self.addChild(highScoreLable)
    }
    
    /*
    func highScoreLable(){
        highScoreLable =  SKLabelNode(text: "High Score: 0")
        highScoreLable.position = CGPoint(x: 1080, y: 1800)
        highScoreLable.fontName = "AmericanTypewiter-Bold"
        highScoreLable.fontColor = UIColor.white
        highScoreLable.fontSize = 40
        highScore = 0
        self.addChild(highScoreLable)
        
    }
 */
    
    /*
     
     Function: createLiveButton
     
     Purpose: This function creates the button (heart) top left corner of the view
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under didMove function.
    
     */
    
    func createLiveButton(){
        
        let liveButtonTexture = SKTexture(imageNamed: "heart")
        button = SKSpriteNode(texture: liveButtonTexture , size: CGSize(width: 100, height: 100))
        button.position = CGPoint(x: 390, y: 1850)
        button.zPosition = 1
        
        self.addChild(button)
        button.run(scalingAnimation())
        
        
    }
    
    /*
     
     Function: scalingAnimation
     
     Purpose: This function is to animate nodes. this will scale up and Wait for 2 seconds before
     repeating the actionown an node. Form a sequence with the scale actions, as well as the wait action.
     return the scalling sequence
     
     ** Important note for developers**
     
     if you want to apply the animation use nodename.run(action:scalingAnimation())
     
     */
    
    
    func scalingAnimation() -> SKAction{
        
      
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        let waitAction = SKAction.wait(forDuration: 2)
        let scallingSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])
        return SKAction.repeatForever(scallingSequence)
        
    }
    
    /*
     
     Function: fadeInOut
     
     Purpose: This function is to animate nodes. this will fade in and out  and Wait for 2 seconds before
     repeating the actionown an node. Form a sequence with the scale actions, as well as the wait action.
     return the scalling sequence
     
     ** Important note for developers**
     
     if you want to apply the animation use nodename.run(action:scalingAnimation())
     
     */
    
    func fadeInOut() -> SKAction {
        
        let duration = 0.4
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        
        return SKAction.repeatForever(blink)
        
    
    }
    
    
    
    
    
    
  /*
     
     Function: resetDiamonds
     
     Purpose: This function will reset the position of diamonds
     ** Important note for developers**
     
     This function is called in gamescene.swift file under addDiamond function.
     
     */
    
    func resetDiamonds(diamondNode:SKSpriteNode, yPos:CGFloat) {
        
        diamondNode.position.x = endOfScreenRight
        diamondNode.position.y = yPos
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
        player.startRunning()
        movingBridge.start()
        blocksGenerator.startBlocksGenaratingIsEvery(seconds: 10)
        
        
    }
    
    /*
     
     Function: gameOver
     
     Parameters : none
     
     Purpose: This function will stop everything after player hits a block
     User can restart the game by tapping on the label(gameOverLabel)
     
     And this function chnages the high score by comparing with current score.
     
     And this function saves user name and score in an array using user defaults
     
     */
    
    func gameOver()
    {
        
        
        //stops the background music
        backgroundSound.run(SKAction.stop())
        
        if self.livesArray.count > 0{
            let liveNode = self.livesArray.first
            liveNode!.removeFromParent()
            self.livesArray.removeFirst()
            if self.livesArray.count == 0{
                
            }
        }
        
        isGameOver = true
        player.physicsBody = nil
        blocksGenerator.stopBlocks()
        movingBridge.stop()
        player.stop()
        
        let gameOverLabel = SKLabelNode(text: "Ops! You are dead!")
        gameOverLabel.name = "gameOverLabel"
         gameOverLabel.fontName = "Marion-Italic"
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.fontSize = 100
        self.addChild(gameOverLabel)
        
        if highScore < score {
            highScore = score
            highScoreLable.text = "High Score: \(highScore)"
            //highScore = score
            let player = ["\(getName())", "\(highScore)"]
            UserDefaults.standard.set(player, forKey:"player");
            print(getName(), score)
        }
        
        else {
            
          //  print(getName(), score, array[1])
            

        }
     
    }
    
    /*
     
     Function: restart
     Parameters:none
     
     Purpose: This function will call after user taps on gameOverLabel.
     creates a new scene to retart the game
     
     The score label will be become to 0
     */
    
    func restart (){
        
       
        cloudGenerator.stopGeneratingClouds()
        let  newScene = GameScene(size: CGSize(width: 1536, height: 2048))
        newScene.scaleMode = .aspectFill
        view?.presentScene(newScene)
        score = 0
        //loadPlayer()
        
    }
    
    /*
     Function : Update
     
     Purpose: this funtion check whether the game is over.if not it calles the updateDiamondsPosition()
     function and will add score for the player.
     And this fucntion genarates the score. Player get 5 points when the player jump and avoid a block.
     
    */
    
    override func update(_ currentTime: CFTimeInterval){
        if isGameStarted {
        
           // updateDiamondsPosition()
            updateFireBallsPosition()
            
            if blocksGenerator.blocksTracker.count > 0 {
                let block = blocksGenerator.blocksTracker[0] as Blocks
                let blockLocation = blocksGenerator.convert(block.position, to: self)
                if blockLocation.x < player.position.x{
                    blocksGenerator.blocksTracker.remove(at: 0)
                    score+=5
                }
                else {
                    let temp = score
                    score = temp
                }
            }
        }
    }
    
    
    

    
    /*
     
     Function: addFireBalls
     
     Purpose: This function add fireballs and give speeds to each fireball
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    func addFireBalls()
    {
        addFireBall(named: "flameBall", speed: 40.0, yPos: CGFloat(1500))
        
    }
    
    func addFireBall(named: String, speed:Float, yPos:CGFloat) {
        let fireBallNode = SKSpriteNode(imageNamed: named)
        
        fireBallNode.physicsBody = SKPhysicsBody(circleOfRadius: fireBallNode.size.width/2)
        fireBallNode.physicsBody!.affectedByGravity = false
        fireBallNode.physicsBody?.isDynamic = false
        fireBallNode.physicsBody?.categoryBitMask = fireBallBody
        fireBallNode.physicsBody?.collisionBitMask = playerBody
        fireBallNode.physicsBody?.contactTestBitMask = playerBody
       
        
        let fireBall = FireBalls(speed: speed, guy: fireBallNode)
        fireBalls.append(fireBall)
        resetfireBalls(fireBallNode: fireBallNode, yPos: yPos)
        fireBall.yPos = fireBallNode.position.y
        fireBallNode.zPosition = 10
        fireBallNode.size = CGSize(width: 180, height: 150)
        let fireEmitter = SKEmitterNode(fileNamed: "Spark")!
        fireBallNode.addChild(fireEmitter)
        addChild(fireBallNode)
        
    }
    
    /*
     
     Function: resetfireBalls
     
     Purpose: This function will reset the position of fireball
     ** Important note for developers**
     
     This function is called in gamescene.swift file under addDiamond function.
     
     */
    
    func resetfireBalls(fireBallNode:SKSpriteNode, yPos:CGFloat) {
        
        fireBallNode.position.x = endOfScreenRight
        fireBallNode.position.y = yPos
    }
    /*
     
     Function: updateFireBallsPosition
     Parameters:none
     
     Purpose: This function check if fireball are already moving. if not it will increase the fram by 1
     
     **Imporatant notice for developpers**
     this function is called under update(_ currentTime: CFTimeInterval) function in this class
     */
    
    func updateFireBallsPosition() {
        
        for fireBall in fireBalls {
            if !fireBall.moving
            {
                fireBall.currentFrame += 10
                if fireBall.currentFrame > fireBall.randomFrame {
                    fireBall.moving = true
                }
            } else
                
            {
                fireBall.guy.position.y = CGFloat(Double(fireBall.guy.position.y) + sin(fireBall.angle) * fireBall.range)
                fireBall.angle += 0.10
                if fireBall.guy.position.x > endOfScreenLeft {
                    fireBall.guy.position.x -= CGFloat(fireBall.speed)
                } else
                    
                {
                    fireBall.guy.position.x = endOfScreenRightofFireBalls
                    fireBall.currentFrame = 0
                    fireBall.setRandomFrame()
                    fireBall.moving = false
                    fireBall.range += 0.1
                    
                }
            }
        }
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
        
  
       //screamSound.autoplayLooped = false
       addChild(screamSound)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if isGameOver
        {
            restart ()
        }
            
        else  if !isGameStarted
        {
            
             start()
        }

        else
        {
            player.jump()
            
        }
        
        
    }
    
    
    /*
     Funtion: touchesEnded
     
     Purpose: this funtion handles button click events
     
     */
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if button.contains(location) {
                print("tapped!")
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = LivesScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)

 
            }
            
            
           
        }
    }
        
    }
    
    
    


