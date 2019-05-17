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
   
    
    var mainRunningAnimation: SKSpriteNode!
    
    //arrays
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    
    //animation
    var burningAnimation: SKSpriteNode!
    var burningTextureAtlas = SKTextureAtlas()
    var burningTextureArray = [SKTexture]()
    
    var isUpsideDown = false
    var onGround = true
    
    // collision detection elements
    let playerBody: UInt32 = 0x1 << 0
    let fireBallBody: UInt32 = 0x1 << 1
    
    enum ColliderType:UInt32 {
        case player = 1
        case FireBalls = 2
        case Diamonds = 3
    }
    
    

    
    
    /*
     Override Function : init
     Parameters: none
     
     Purpose: this will give the iniial size and the physics bod the player.
     this will provide a clear box so developpers can create different body parts of the playerinside of that
     box
     
     ** Important note for developpers **
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
    
    init() {
        
        let size = CGSize(width: 80, height: 200)
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        loadPhisycBodyWithSize(size: size)
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
        physicsBody?.categoryBitMask = playerBody
        physicsBody?.contactTestBitMask = fireBallBody
        physicsBody?.affectedByGravity = false
        physicsBody!.categoryBitMask = ColliderType.player.rawValue
        physicsBody!.collisionBitMask = playerBody | fireBallBody
        
    }

    
    
    /*
     
     Function: startRunning
     parameters: none
     
     Purpose: this function will animate the player by calling  performOneCycle() function
     
     */
    
    func startRunning()  {
        
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
        mainRunningAnimation.removeFromParent()
        let burningMan = SKSpriteNode(imageNamed: "burning")
        burningMan.position = CGPoint(x: self.size.width/2, y: 60)
        burningMan.size = CGSize(width: 300, height: 200)
        let BurningEmitter = SKEmitterNode(fileNamed: "Burn")!
        burningMan.addChild(BurningEmitter)
        self.addChild(burningMan)
        
        
        
    }
    
    /*
     Function: required init?(coder aDecoder: NSCoder)
     
     Purpose: This is a default function comes wity ithe init
     
     */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
        
    
    


