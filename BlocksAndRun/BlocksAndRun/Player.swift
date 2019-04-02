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
  //  var leftEye: SKSpriteNode!
  //  var rightEye: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftHand: SKSpriteNode!
    var rightHand: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    
    // basic colors for body parts
    let skinColour = UIColor(red: 255.0/00, green: 173.0/255.00, blue: 96.0/255.00, alpha: 1.0)
   // let eyeColour = UIColor(red: 3.0/255.0, green: 24.0/255.0, blue: 39.0/255.0, alpha: 1.0)
   
    
    
    // initial size of the player [piumi]
     init() {
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 80, height: 200))
    
   
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
    
    // breathing animation of the player [piumi]
    func breath()  {
        
        let breathIn = SKAction.moveBy(x: 0, y: 4, duration: 0.5)
        let breathOut = SKAction.moveBy(x: 0, y: -4, duration: 0.5)
        let breath = SKAction.sequence([breathIn,breathOut])
        body.run(SKAction.repeatForever(breath))
    }
    
    func startRunning()  {
        let rotateBack  = SKAction.rotate(byAngle: -CGFloat(M_PI)/2.0, duration: 0.2)
        arm.run(rotateBack)
        performOneCycle()
    }
    
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
    
    // this funtion will stop all body funtions when user tap on the screen 
    func  stop () {
        body.removeAllActions()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
    }
        
    
    


