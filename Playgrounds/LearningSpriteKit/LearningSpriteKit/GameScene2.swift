//
//  GameScene2.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import SpriteKit

class GameScene2: SKScene {
    
    let alien = SKSpriteNode(imageNamed: "alien1")
    
    override func didMoveToView(view: SKView) {
        print("GameScene2: \(view.frame.size)")
        
        self.backgroundColor = UIColor(red: 0.1, green: 0.3, blue: 0.1, alpha: 1.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.locationInNode(self)
            print("touch: \(loc)")
            
            // move alien to touch pos
            let alien = SKSpriteNode(imageNamed: "alien1")
            alien.position = loc
            self.addChild(alien)
            
            let move = SKAction.moveByX(25.0, y: 75.0, duration: 0.5)
            let rotate = SKAction.rotateByAngle(3.14, duration: 0.5)
            let fadeOut = SKAction.fadeOutWithDuration(0.5)
            let remove = SKAction.removeFromParent()
            
            // Try some other actions...
            
            // 1. wait
            //let wait = SKAction.waitForDuration(1.0)
            
            // 2. fadeIn
            //let fadeIn = SKAction.fadeInWithDuration(1.0)
            
            // 3. scale
            //let doubleSize = SKAction.scaleBy(2.0, duration: 1.0)
            //let halfSize = SKAction.scaleBy(0.5, duration:1.0)
            
            // 4. colorize
            //let green = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1.0, duration: 1.0)
            //let ungreen = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 0, duration: 1.0)
            
            // 5. actions in parallel
            //let parallel = SKAction.group([move, rotate, halfSize]);
            
            // run these actions on alien in order
            alien.runAction(SKAction.sequence([move, rotate, fadeOut, remove]))
        }

    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        if let touch: AnyObject = touches.anyObject() {
//            let loc = touch.locationInNode(self)
//            print("touch: \(loc)")
//            
//            // move alien to touch pos
//            let alien = SKSpriteNode(imageNamed: "alien1")
//            alien.position = loc
//            self.addChild(alien)
//            
//            let move = SKAction.moveByX(25.0, y: 75.0, duration: 0.5)
//            let rotate = SKAction.rotateByAngle(3.14, duration: 0.5)
//            let fadeOut = SKAction.fadeOutWithDuration(0.5)
//            let remove = SKAction.removeFromParent()
//            
//            // Try some other actions...
//            
//            // 1. wait
//            //let wait = SKAction.waitForDuration(1.0)
//            
//            // 2. fadeIn
//            //let fadeIn = SKAction.fadeInWithDuration(1.0)
//            
//            // 3. scale
//            //let doubleSize = SKAction.scaleBy(2.0, duration: 1.0)
//            //let halfSize = SKAction.scaleBy(0.5, duration:1.0)
//            
//            // 4. colorize
//            //let green = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1.0, duration: 1.0)
//            //let ungreen = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 0, duration: 1.0)
//            
//            // 5. actions in parallel
//            //let parallel = SKAction.group([move, rotate, halfSize]);
//            
//            // run these actions on alien in order
//            alien.runAction(SKAction.sequence([move, rotate, fadeOut, remove]))
//        }
//    }
   
    override func update(currentTime: CFTimeInterval) {
        //pass
    }
}
