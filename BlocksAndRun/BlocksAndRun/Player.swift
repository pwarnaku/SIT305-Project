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
        
        body = SKSpriteNode(color: UIColor.black, size: CGSize(width: self.frame.size.width, height: 180))
        body.position = CGPoint(x:0, y: 80)
        addChild(body)
        
        //  let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        let face = SKSpriteNode(color: skinColour, size: CGSize(width: self.frame.size.width, height: 50))
        face.position = CGPoint(x: 0, y: 40)
        body.addChild(face)
        
        let eyeColor = UIColor.white
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSize(width: 10, height: 10))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.black, size: CGSize(width: 8, height: 8))
        
        pupil.position = CGPoint(x:2,y: 0)
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        leftEye.position = CGPoint(x:-4, y: 0)
        face.addChild(leftEye)
        
        rightEye.position = CGPoint(x:14, y: 0)
        face.addChild(rightEye)
        
        let eyebrow = SKSpriteNode(color: UIColor.black, size: CGSize(width: 11,height:  5))
        eyebrow.position = CGPoint(x: -1, y: leftEye.size.height/2)
        leftEye.addChild(eyebrow)
        rightEye.addChild(eyebrow.copy() as! SKSpriteNode)
        
        let armColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        arm = SKSpriteNode(color: armColor, size: CGSize(width:20, height: 54))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        arm.position = CGPoint(x: -10, y: -7)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColour, size: CGSize(width: arm.size.width,height:  10))
        hand.position = CGPoint(x: 0, y: -arm.size.height*0.9 + hand.size.height/2)
        arm.addChild(hand)
        
        leftLeg = SKSpriteNode(color: skinColour, size: CGSize(width: 15, height: 100))
        leftLeg.position = CGPoint(x: -8,y:  -size.height/2 + leftLeg.size.height/2)
        addChild(leftLeg)
        
        rightLeg = leftLeg.copy() as? SKSpriteNode
        rightLeg.position.x = 15
        addChild(rightLeg)
        
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
    
    func breath()  {
        
        let breathIn = SKAction.moveBy(x: 0, y: 4, duration: 0.5)
        let breathOut = SKAction.moveBy(x: 0, y: -4, duration: 0.5)
        let breath = SKAction.sequence([breathIn,breathOut])
        body.run(SKAction.repeatForever(breath))
    }
    
    
    /*
     
     Function: startRunning
     parameters: none
     
     Purpose: when player is running, arms of the player will rotate back.
     this will gives a real look of running
     
     */
    
    func startRunning()  {
        
        let rotateBack  = SKAction.rotate(byAngle: -CGFloat(M_PI)/2.0, duration: 0.2)
        arm.run(rotateBack)
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
        let forward = SKAction.moveBy(x: 4, y: 4, duration: 0.03)
        let backward = SKAction.moveBy(x: -4, y: -4, duration: 0.03)
        
        leftLeg.run(forward, completion:  {
            self.leftLeg.run(backward)
            self.rightLeg.run(forward, completion: {
                self.rightLeg.run(backward, completion: {
                    self.performOneCycle() // repeats cycle
                })
            })
        })
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
        body.removeAllActions()
        leftLeg.removeAllActions()
        rightLeg.removeAllActions()
    }
    
    
    /*
     
     Function: burn
     
     Purpose: This funtion is to add a texture after player hits a fire to look like he is buring
     I have added a emititer to make it looks like real
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     */
    
    func burn(){
        
        let burntBodyTexture = SKTexture(imageNamed: "burntBody")
        body = SKSpriteNode(texture: burntBodyTexture, size: CGSize(width: 300, height: 180))
       addChild(body)
        
        
        let burnEmitter = SKEmitterNode(fileNamed: "Burn")!
        body.addChild(burnEmitter)
    }
    
    /*
     Function: required init?(coder aDecoder: NSCoder)
     
     Purpose: This is a default function comes wity ithe init
     
     */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
        
    
    


