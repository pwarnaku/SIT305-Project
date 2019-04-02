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
    var arms: SKSpriteNode!
    var leftHand: SKSpriteNode!
    var rightHand: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    
    // basic colors for body parts
    let skinColour = UIColor(red: 255.0/00, green: 173.0/255.00, blue: 96.0/255.00, alpha: 1.0)
    let eyeColour = UIColor(red: 3.0/255.0, green: 24.0/255.0, blue: 39.0/255.0, alpha: 1.0)
   
    
    
    // initial size of the player
     init() {
        
        super.init(texture: nil, color: UIColor.black, size: CGSize(width: 80, height: 200))
        
        body = SKSpriteNode(color: UIColor(red: 52.0/00, green: 50.0/255.00, blue: 14.0/255.00, alpha: 1.0), size: CGSize(width: self.frame.size.width, height: 200))
        body.position = CGPoint(x: 0, y: 90)
        
        self.addChild(body)
        
       
       
        face = SKSpriteNode(color: skinColour, size: CGSize(width: 70, height: 50))
        face.position = CGPoint(x: 0, y: 120)
        body.addChild(face)
        
        let leftEye = SKSpriteNode(color: eyeColour, size: CGSize(width: 10, height: 10))
        let rightEye = leftEye.copy() as! SKSpriteNode
        
        
        
        /*
        head = SKSpriteNode(color: UIColor.black, size: CGSize(width: 70, height: 10))
        head.position = CGPoint(x: 0, y: 105)
        face.addChild(head)
 */
        
    }
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
