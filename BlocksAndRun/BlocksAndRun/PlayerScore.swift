//
//  PlayerScore.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 17/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class PlayerScore: SKLabelNode {
    
    var score = 0
    
    init(number: Int) {
        super.init()
        
        fontColor = UIColor.white
        fontName = "Helvetica"
        fontSize = 20 
        
        
        score = number
        text = "\(number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment(){
        score+=5
        text = "Score: \(score)"
    }

}
