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
    
    //boolean values
    var isGameStarted = false
    var isGameOver = false
    var isLivesAvailable: Bool!
    
    //diamonds
    var diamonds:[Diamonds] = []
    
    //Evil birds
    var birds: [Birds] = []
    
    var Defaultlives: Int = 2
    
    enum ColliderType:UInt32 {
        case Player = 1
        case Diamonds = 2
    }
    
    //limits
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()

    //limits for birds
    var endOfScreenRightofBirds = CGFloat()
    var endOfScreenLeftofBirds = CGFloat()
    let array = UserDefaults.standard.object(forKey:"player") as? [String] ?? [String]()
    //let player = UserDefaults.standard.set [String] ?? [String]()
    
    //variables related to Score and High Score
    var nameLable:SKLabelNode!
    var highScoreLable:SKLabelNode!
    var scoreLable:SKLabelNode!
    var score:Int = 0{
        didSet{
            scoreLable.text = " \(score) "
        }
    
    }
   
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
        createSettingsButton()
        
        endOfScreenLeft = (1200) * CGFloat(-1)
        endOfScreenRight = 2900
        
        endOfScreenLeftofBirds = (1200) * CGFloat(-1)
        endOfScreenRightofBirds = 1500
        
        // creates objects
        
        createTheBackground()
        createTheMovingBridge()
        createThePlayer()
        createBlocks()
        addDiamonds()
        addBirds()
        generateClouds()
        startGameLable()
        scoreLabel()
        nameLabel()
        highScoreLabel()

        
        // Add the physics world
        physicsWorld.contactDelegate = self

    }
    
    /*
    func dataStore(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.NSPersistentContainer.viewContext
        let newUser = NSEntityDescription.inserNewObjectr(forEntutyName: "PlayerDB", into: context)
    
        do{
            try context.save()
        }
        catch  {
        }
    }
    */
    
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
    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: "userHighScore")
    }
 
    func loadPlayer() {
        let array = UserDefaults.standard.object(forKey:"player") as? [String] ?? [String]()
       // print(array[0], array[1])
       // nameLable.text = "\(array[0])"
        if getName() == "\(array[0])" {
            
             highScoreLable.text = "\(array[1])"
             nameLable.text = "\(array[0])"
        }
    }
 */
    
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
     
     Function: createThePlayer
     
     Purpose: This function creates the player and starting animations.
     
     ** Important note for developers**
     
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createThePlayer(){
        
        player = Player()
        player.position = CGPoint(x: 380, y: 800)
        self.addChild(player)
        //  player.breath() // call the breath animation
        
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
        
    }
    
    /*
     
     Function: highScoreLable
     
     Purpose: This function creates the High Score lable. It uses saved array data to get the high score.
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     
     */
    
    func highScoreLabel(){
        
        if getName() == "\(array[0])" {
            
            highScoreLable =  SKLabelNode(text: "High Score: \(array[1])")
        }
            
        else {
            
           highScoreLable =  SKLabelNode(text: "High Score: 0")
            
        }
        
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
     
     Function: createSettingsButton
     
     Purpose: This function creates settings  button (gear) top left corner of the view
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createSettingsButton(){
        
        let settingsButtonTexture = SKTexture(imageNamed: "settings")
        settingsButton = SKSpriteNode(texture: settingsButtonTexture , size: CGSize(width: 100, height: 100))
        settingsButton.position = CGPoint(x: 500, y: 1850)
        settingsButton.zPosition = 1
        
        self.addChild(settingsButton)
        
        
    }
    
    /*
     
     Function: addDiamonds
     
     Purpose: This function add diamonds and give speeds to each diamond
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    
    
    func addDiamonds()
    {
        addDiamond(named: "diamond1", speed: 8.0, yPos: CGFloat(1500))
    }
    
    func addDiamond(named: String, speed:Float, yPos:CGFloat)
    {
        
        let diamondNode = SKSpriteNode(imageNamed: named)
        
       // badGuyNode.physicsBody = SKPhysicsBody(circleOfRadius: badGuyNode.size.width/2)
      //  badGuyNode.physicsBody!.affectedByGravity = false
      //  badGuyNode.physicsBody!.categoryBitMask = ColliderType.Diamonds.rawValue
      //  badGuyNode.physicsBody!.contactTestBitMask = ColliderType.Player.rawValue
       // badGuyNode.physicsBody!.collisionBitMask = ColliderType.Player.rawValue
        
        let diamond = Diamonds(speed: speed, guy: diamondNode)
        diamonds.append(diamond)
        resetDiamonds(diamondNode: diamondNode, yPos: yPos)
        diamond.yPos = diamondNode.position.y
        diamondNode.zPosition = 10
        diamondNode.size = CGSize(width: 200, height: 250)
        let fireEmitter = SKEmitterNode(fileNamed: "bok")!
        diamondNode.addChild(fireEmitter)
        addChild(diamondNode)
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
        //player.stop()
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
        
        if highScore < score {
            highScore = score
            highScoreLable.text = "High Score: \(highScore)"
            //highScore = score
            let player = ["\(getName())", "\(highScore)"]
            UserDefaults.standard.set(player, forKey:"player");
            print(getName(), score)
        }
        
        else {
            
            print(getName(), score, array[1])
            

        }
     /*
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
        gameOver.score = self.score
        gameOver.highScore = "\(array[1])"
        gameOver.userName = "\(getName())"
        self.view?.presentScene(gameOver, transition: transition)

        */
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
        
            updateDiamondsPosition()
            updateBirdsPosition()
            
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
     
     Function: updateDiamondsPosition
     Parameters:none
     
     Purpose: This function check if diamonds are already moving. if not it will increase the fram by 1
     
     */
    
    func updateDiamondsPosition() {
        
        for diamond in diamonds {
            if !diamond.moving
            {
                diamond.currentFrame += 10
                if diamond.currentFrame > diamond.randomFrame {
                    diamond.moving = true
                }
            } else
            
            {
                diamond.guy.position.y = CGFloat(Double(diamond.guy.position.y) + sin(diamond.angle) * diamond.range)
                diamond.angle += 0.10
                if diamond.guy.position.x > endOfScreenLeft {
                    diamond.guy.position.x -= CGFloat(diamond.speed)
                } else
                    
                {
                    diamond.guy.position.x = endOfScreenRight
                    diamond.currentFrame = 0
                    diamond.setRandomFrame()
                    diamond.moving = false
                    diamond.range += 0.1
                    //updateScore()
                }
            }
        }
    }
    
    
    func addBirds()
    {
        addBird(named: "flameBall", speed: 40.0, yPos: CGFloat(1500))
    
    }
    
    func addBird(named: String, speed:Float, yPos:CGFloat) {
        let birdNode = SKSpriteNode(imageNamed: named)
        
        // badGuyNode.physicsBody = SKPhysicsBody(circleOfRadius: badGuyNode.size.width/2)
        //  badGuyNode.physicsBody!.affectedByGravity = false
        //  badGuyNode.physicsBody!.categoryBitMask = ColliderType.Diamonds.rawValue
        //  badGuyNode.physicsBody!.contactTestBitMask = ColliderType.Player.rawValue
        // badGuyNode.physicsBody!.collisionBitMask = ColliderType.Player.rawValue
        
        
        
        
        let bird = Birds(speed: speed, guy: birdNode)
        birds.append(bird)
        resetBirds(birdNode: birdNode, yPos: yPos)
        bird.yPos = birdNode.position.y
        birdNode.zPosition = 10
        birdNode.size = CGSize(width: 180, height: 150)
        let fireEmitter = SKEmitterNode(fileNamed: "Spark")!
        birdNode.addChild(fireEmitter)
        addChild(birdNode)
        
    }
    
    /*
     
     Function: resetDiamonds
     
     Purpose: This function will reset the position of diamonds
     ** Important note for developers**
     
     This function is called in gamescene.swift file under addDiamond function.
     
     */
    
    func resetBirds(birdNode:SKSpriteNode, yPos:CGFloat) {
        
        birdNode.position.x = endOfScreenRight
        birdNode.position.y = yPos
    }
    
    func updateBirdsPosition() {
        
        for bird in birds {
            if !bird.moving
            {
                bird.currentFrame += 10
                if bird.currentFrame > bird.randomFrame {
                    bird.moving = true
                }
            } else
                
            {
                bird.guy.position.y = CGFloat(Double(bird.guy.position.y) + sin(bird.angle) * bird.range)
                bird.angle += 0.10
                if bird.guy.position.x > endOfScreenLeft {
                    bird.guy.position.x -= CGFloat(bird.speed)
                } else
                    
                {
                    bird.guy.position.x = endOfScreenRightofBirds
                    bird.currentFrame = 0
                    bird.setRandomFrame()
                    bird.moving = false
                    bird.range += 0.1
                    //updateScore()
                }
            }
        }
    }
    
   
    
    func manageLives() -> Bool {
       
        
        Defaultlives -= 1
        let currentlives = Defaultlives
        
        
        if currentlives == 0
            
        {
            isLivesAvailable = false
            
            // print("waithvgvvjhbhv")
         
        }
            
        else
            
        {
            isLivesAvailable = true
        }
        
        return isLivesAvailable
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
        
      //  player.burn()
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
            
            
            if settingsButton.contains(location) {
                print("tapped!")
                
                // createLivesWindow()
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = PlayerSelection(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
                
                
                
                
            }
        }
    }
        
    }
    
    
    


