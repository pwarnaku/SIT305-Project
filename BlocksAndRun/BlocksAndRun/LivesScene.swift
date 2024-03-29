//
//  LivesScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 14/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit
import Social
import StoreKit


class LivesScene: SKScene, SKPaymentTransactionObserver, SKProductsRequestDelegate  {
    
    var backgroundSegment1: SKShapeNode!
    var backgroundSegment2: SKShapeNode!
    var heart1: SKSpriteNode!
    var heart2: SKSpriteNode!
    var coin: SKSpriteNode!
    var fb: SKSpriteNode!
   // var underline: SKSpriteNode!
    
    var cancelButton: SKNode!
    
    
    //In App Purchases
    var list = [SKProduct]()
    var p = SKProduct()
    
    func buyProduct() {
        
        print("buy " + p.productIdentifier)
        var pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add paymnet")
        
        for transaction:AnyObject in transactions {
            var trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
                
            case .purchased, .restored:
                print("buy, ok unlock iap here")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                switch prodID {
                case "piumi_fernandz@icloud.com":
                    
                    //Here you should put the function you want to execute when the purchase is complete
                    var alert = UIAlertView(title: "Thank You", message: "You may have to restart the app before the banner ads are removed.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                default:
                    print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                break;
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break;
            default:
                print("default")
                break;
                
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        var myProduct = response.products
        
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product as! SKProduct)
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
        print("transactions restored")
        
        _ = []
        for transaction in queue.transactions {
            var t: SKPaymentTransaction = transaction as! SKPaymentTransaction
            
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "piumi_fernandz@icloud.come": break
                
            //Right here is where you should put the function that you want to execute when your in app purchase is complete
            default:
                print("IAP not setup")
            }
            
        }
        
        var alert = UIAlertView(title: "Thank You", message: "Your purchase(s) were restored. You may have to restart the app before banner ads are removed.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func finishTransaction(trans:SKPaymentTransaction)
    {
        print("finish trans")
    }
    func paymentQueue(queue: SKPaymentQueue!, removedTransactions transactions: [AnyObject]!)
    {
        print("remove trans");
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
        
        createCancelButton()
        
        // Set IAPS
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            var productID:NSSet = NSSet(objects: "piumi_fernandz@icloud.com")
            var request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject> as Set<NSObject> as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
        
        let background = SKSpriteNode(color: UIColor(red: 88.00/255.0, green: 101.00/255.0, blue: 100.00/255.0, alpha: 5.0), size: CGSize(width: 700, height: 700))
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let moreLives = SKLabelNode(text: "More lives")
        moreLives.name = "moreLivesLabel"
        moreLives.position = CGPoint(x: self.size.width/2, y: 1795)
        moreLives.zPosition = 10
        moreLives.fontName = "SnellRoundhand-Black"
        moreLives.fontColor = UIColor.white
        moreLives.fontSize = 100
        
        self.addChild(moreLives)
        
        
        
      /*
        let underlineTexture = SKTexture(imageNamed: "underline")
        underline = SKSpriteNode(texture: underlineTexture, size: CGSize(width: 700, height:900))
        
        underline.position = CGPoint(x: self.size.width/2, y: 1750)
        underline.zPosition = 20
        self.addChild(underline)
 
 */
        
        
        backgroundSegment1 = SKShapeNode(rect: CGRect(x: 398, y: 1150, width: 735, height: 280), cornerRadius: 80)
        backgroundSegment1.fillColor = UIColor(red: 92.00/255.0, green: 156.0/255.0, blue: 131.0/255.0, alpha: 5.0)
        backgroundSegment1.name = "inAppPurchaseNode"
        addChild(backgroundSegment1)
        
        heart1 = SKSpriteNode(imageNamed: "heart1")
        heart1.size = CGSize(width: 250, height: 250)
        heart1.position = CGPoint(x:560, y: 1280)
        addChild(heart1)
        heart1.run(scalingAnimation())
        
        coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 110, height: 110)
        coin.position = CGPoint(x:998, y: 1235)
        // self.isUserInteractionEnabled = true
        addChild(coin)
        
        let lives1 = SKLabelNode(text: "Buy lives")
        lives1.name = "tapToStartLabel"
        lives1.position = CGPoint(x: 850, y: 1275)
        lives1.fontName = "Marion-Italic"
        lives1.fontColor = UIColor.white
        lives1.fontSize = 80
        
        self.addChild(lives1)
        
    
        backgroundSegment2 = SKShapeNode(rect: CGRect(x: 398, y: 650, width: 735, height: 280), cornerRadius: 80)
        backgroundSegment2.fillColor = UIColor(red: 92.00/255.0, green: 156.0/255.0, blue: 131.0/255.0, alpha: 5.0)
        addChild(backgroundSegment2)
        
        heart2 = SKSpriteNode(imageNamed: "heart1")
        heart2.size = CGSize(width: 250, height: 250)
        heart2.position = CGPoint(x:560, y: 800)
        addChild(heart2)
        heart2.run(scalingAnimation())
       
        
        fb = SKSpriteNode(imageNamed: "fb")
        fb.size = CGSize(width: 110, height: 110)
        fb.position = CGPoint(x:998, y: 750)
        addChild(fb)
        
        let lives2 = SKLabelNode(text: "Ask lives")
        lives2.name = "tapToStartLabel"
        lives2.position = CGPoint(x: 850, y: 800)
        lives2.fontName = "Marion-Italic"
        lives2.fontColor = UIColor.white
        lives2.fontSize = 80
        self.addChild(lives2)
        
        
        
       
    }
    
    func scalingAnimation() -> SKAction{
    
    //let delayAction = SKAction.wait(forDuration: TimeInterval(index) * 0.2)
    
    // Scale up and then back down
    let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
    let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
    
    // Wait for 2 seconds before repeating the action
    let waitAction = SKAction.wait(forDuration: 2)
    
    // Form a sequence with the scale actions, as well as the wait action
    let scallingSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])
    
    return SKAction.repeatForever(scallingSequence)
    
    
    // Combine the delay and the repeat actions into another sequence
   // let actionSequence = SKAction.sequence([delayAction, repeatAction])
    
    // Run the action
    
    }
    
    /*
     
     Function: createCancelButton
     
     Purpose: This function takesback to the game
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createCancelButton(){
        
        // Create a simple red rectangle that's 100x44
        let CancelButtonTexture = SKTexture(imageNamed: "ok")
        cancelButton = SKSpriteNode(texture: CancelButtonTexture , size: CGSize(width: 100, height: 100))
        // Put it in the center of the scene
        cancelButton.position = CGPoint(x: 1120, y: 1820)
        cancelButton.zPosition = 1
        
        self.addChild(cancelButton)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
    
    let touch =  touches.first as? UITouch
        let positionInScene = touch!.location(in:  self)
    let touchedNode = self.atPoint(positionInScene)
    if let name = touchedNode.name {
        if name == "inAppPurchaseNode" {
            
            for product in list {
                var prodID = product.productIdentifier
                if(prodID == "piumi_fernandz@icloud.com") {
                    p = product
                    buyProduct()  //This is one of the functions we added earlier
                    break;
                }
            }
        }
        
    }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if cancelButton.contains(location) {
                print("tapped!")
                
                // createLivesWindow()
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
                
                
                
                
            }
        }
    }
}
