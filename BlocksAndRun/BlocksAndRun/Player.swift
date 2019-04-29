//
//  Player.swift
//  BlocksAndRun
//
//  Created by Piumi on 2/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    /*
     Body parts of the player
     These parts will be used to animate the player
     */
    
    var animation: Animations!
    
    var mainRunningAnimation: SKSpriteNode!
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    
    
    var burningAnimation: SKSpriteNode!
    var burningTextureAtlas = SKTextureAtlas()
    var burningTextureArray = [SKTexture]()
    
    var head: SKSpriteNode!
    var face: SKSpriteNode!
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftHand: SKSpriteNode!
    var rightHand: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    var isUpsideDown = false
    var onGround = true
    
    
    
    // basic colors for body parts
    let skinColour = UIColor(red: 255.0/00, green: 173.0/255.00, blue: 96.0/255.00, alpha: 1.0)
    
    
    
    /*
     Override Function : init
     Parameters: none
     
     Purpose: this will give the iniial size and the color of the player.
     this will provide a clear box so developpers can create different body parts of the playerinside of that
     box
     
     ** Important note for developpers **
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
    
    init() {
        
        let size = CGSize(width: 80, height: 200)
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        loadAppearance ()
        loadPhisycBodyWithSize(size: size)
    }
    
    /*
     Function : loadAppearance
     Parameters: none
     
     Purpose: this function will creates all the body parts of the player inside of the box created in init()
     and gives position to each part.
     
     ** Important note for developpers **
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
    
    func loadAppearance() {
        
       /*
        let BodyTexture = SKTexture(imageNamed: "body")
        body = SKSpriteNode(texture:BodyTexture, size: CGSize(width: 100, height: 200))
        body.position = CGPoint(x:0, y: 180)
        addChild(body)
        
        //  let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        let faceTexture = SKTexture(imageNamed: "face")
        let face = SKSpriteNode(texture:faceTexture, size: CGSize(width: 120, height: 150))
        face.position = CGPoint(x: 30, y: 140)
        body.addChild(face)
        
        let eyeColor = UIColor.white
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSize(width: 10, height: 10))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.black, size: CGSize(width: 8, height: 8))
        
        pupil.position = CGPoint(x:2,y: 0)
        rightEye.addChild(pupil)
        //rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        rightEye.position = CGPoint(x:-4, y: 0)
        face.addChild(leftEye)
        
        //rightEye.position = CGPoint(x:14, y: 0)
       // face.addChild(rightEye)
        
        let eyebrow = SKSpriteNode(color: UIColor.black, size: CGSize(width: 11,height:  5))
        eyebrow.position = CGPoint(x: -1, y: leftEye.size.height/2)
        rightEye.addChild(eyebrow)
       // rightEye.addChild(eyebrow.copy() as! SKSpriteNode)
        
        
        let lefthadTexture = SKTexture(imageNamed: "lefthand")
        
        let armColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        arm = SKSpriteNode(texture:lefthadTexture, size: CGSize(width:100, height: 180))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        arm.position = CGPoint(x: 30, y: 60)
        body.addChild(arm)
        
      /*  let lefthadTexture = SKTexture(imageNamed: "lefthand")
        let hand = SKSpriteNode(texture:lefthadTexture, size: CGSize(width: arm.size.width,height:  10))
        hand.position = CGPoint(x: 0, y: -arm.size.height*0.9 + hand.size.height/2)
        arm.addChild(hand)
        */
        
        let leftShortTexture = SKTexture(imageNamed: "shortLeft")
        let leftshort = SKSpriteNode(texture:leftShortTexture, size: CGSize(width: 120, height: 110))
        leftshort.position = CGPoint(x: 5,y:  25)
        leftshort.zPosition = 7
        addChild(leftshort)
        
         let rightLegTexture = SKTexture(imageNamed: "rightleg")
        leftLeg = SKSpriteNode(texture:rightLegTexture, size: CGSize(width: 55, height: 200))
        leftLeg.position = CGPoint(x: 20,y: -130)
        leftLeg.zPosition = 6
        leftshort.addChild(leftLeg)
        
        rightLeg = leftLeg.copy() as? SKSpriteNode
        rightLeg.position.x = 15
        leftshort.addChild(rightLeg)

        */
    }
    
    /*
     
     funtion name : loadPhisycBodyWithSize
     parameters :size of the player
     
     what does : loads the physics body with the given size surounding a rectangle.
     when the player playerCategory)  hits a block (blockeCategory) it will be recorded
     as a contact
     
     */
    func loadPhisycBodyWithSize(size: CGSize){
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = playerCategory
        physicsBody?.contactTestBitMask = blockeCategory
        physicsBody?.affectedByGravity = false
        
    }
    
    /*
     Function: breath
     parameters: none
     
     what does: this funtion is called before user starts the game.
     this will gives the player a real look by giving a breath animation.
     the body part of the player simply move up and down when the player is not running
     
     */
    
  /*  func breath()  {
        
        let breathIn = SKAction.moveBy(x: 0, y: 4, duration: 0.5)
        let breathOut = SKAction.moveBy(x: 0, y: -4, duration: 0.5)
        let breath = SKAction.sequence([breathIn,breathOut])
        body.run(SKAction.repeatForever(breath))
    }*/
    
    
    /*
     
     Function: startRunning
     parameters: none
     
     Purpose: when player is running, arms of the player will rotate back.
     this will gives a real look of running
     
     */
    
    func startRunning()  {
        
      /*  let rotateBack  = SKAction.rotate(byAngle: -CGFloat(M_PI)/2.0, duration: 0.2)
        arm.run(rotateBack)*/
        performOneCycle()
    }
    
    /*
     
     Function: performOneCycle
     parameters: none
     
     Purpose: This function is to animate one step forward of running. I have user "forward" and "backward" variables with values and assign them to each left leg and right leg.this will gives a real look of running
    
     ** Important note for developers**
     This function is called in  startRunning function.
     
     */
    
    func performOneCycle()  {
        textureAtlas = SKTextureAtlas(named: "running")
        
        for i in 1...textureAtlas.textureNames.count{
            
            let imageName = "run\(i)"
            textureArray.append(SKTexture(imageNamed: imageName))
        }
        
        mainRunningAnimation = SKSpriteNode(imageNamed: textureAtlas.textureNames[0] as! String)
        mainRunningAnimation.size = CGSize(width: 300, height: 600)
        mainRunningAnimation.position = CGPoint(x: self.size.width/2, y: 80)
        mainRunningAnimation.zPosition = 2
        
        self.addChild(mainRunningAnimation)
        
        
        mainRunningAnimation.run(SKAction.repeatForever(SKAction.animate(with: textureArray, timePerFrame: 0.07)))
        
        
        
        /*
        
        let forward = SKAction.moveBy(x: 4, y: 4, duration: 0.03)
        let backward = SKAction.moveBy(x: -4, y: -4, duration: 0.03)
        
        leftLeg.run(forward, completion:  {
            self.leftLeg.run(backward)
            self.rightLeg.run(forward, completion: {
                self.rightLeg.run(backward, completion: {
                    self.performOneCycle() // repeats cycle
                })
            })
        }) */
    }
    
    /*
    
    Function: jump
    parameters: none
    
    Purpose: This function is to jump when user tap on the screen while running. I have user "up" and "down" variables with values and assign them to the body.
    
    ** Important note for developers**
    This function is called in  touchesBegan function in gamescene.swift.
    usage of 'SKAction' - you dont need to assign a same value in to seperate body part.
    
    */
    
    func jump () {
        
        let up = SKAction.moveBy(x: 0, y: 400, duration: 0.5)
        let down = SKAction.moveBy(x: 0, y: -400, duration: 0.5)
        let jump = SKAction.sequence([up,down])
        run(jump)
        
    }
    
    /*
     
     Function: stop
     
     Purpose: This funtion will stop all body funtions when user tap on the screen
     
     ** Important note for developers**
     This function is called in gamescene.swift file under touchesBegan function.
     
     */
    
    func  stop () {
      //  body.removeAllActions()
        //leftLeg.removeAllActions()
   //     rightLeg.removeAllActions()
        mainRunningAnimation.removeFromParent()
        burning()
    }
    
    func burning()  {
        
        burningTextureAtlas = SKTextureAtlas(named: "burning")
        
        for i in 1...burningTextureAtlas.textureNames.count
        {
            
            let imageName = "burning\(i)"
            burningTextureArray.append(SKTexture(imageNamed: imageName))
        }
        
        burningAnimation = SKSpriteNode(imageNamed: burningTextureAtlas.textureNames[0] as! String)
        burningAnimation.size = CGSize(width: 400, height: 700)
        burningAnimation.position = CGPoint(x: self.size.width/2, y: 140)
        burningAnimation.zPosition = 2
        
        self.addChild(burningAnimation)
        
        
        burningAnimation.run(SKAction.repeatForever(SKAction.animate(with: burningTextureArray, timePerFrame: 0.07)))
        
    }
    
    /*
     
     Function: burn
     
     Purpose: This funtion is to add a texture after player hits a fire to look like he is buring
     I have added a emititer to make it looks like real
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     */
    
    func burn(){
        
      //  let burntBodyTexture = SKTexture(imageNamed: "burntBody")
      //  body = SKSpriteNode(texture: burntBodyTexture, size: CGSize(width: 300, height: 180))
      // addChild(body)
        
        
        let burnEmitter = SKEmitterNode(fileNamed: "Burn")!
       // body.addChild(burnEmitter)
    }
    
    /*
     Function: required init?(coder aDecoder: NSCoder)
     
     Purpose: This is a default function comes wity ithe init
     
     */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
        
    
    


