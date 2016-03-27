//
//  GameScene3.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import SpriteKit

class GameScene3: SKScene {
    
    let alien = SKSpriteNode(imageNamed: "alien1")
    let hit = SKAction.playSoundFileNamed("fire.caf", waitForCompletion: false)
    let miss = SKAction.playSoundFileNamed("miss.caf", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        print("GameScene3: \(view.frame.size)")
        
        self.backgroundColor = UIColor(red: 0.3, green: 0.1, blue: 0.1, alpha: 1.0)
        
        self.alien.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(self.alien)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.locationInNode(self)
            print("touch: \(loc)")
            
            if self.alien.containsPoint(loc) {
                print("HIT!")
                self.runAction(self.hit)
                
                //compute the new position
                let center = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                let newPos = CGPoint(x: center.x + CGFloat(arc4random_uniform(201)) - 100.0,
                    y: center.y + CGFloat(arc4random_uniform(201)) - 100.0)
                
                //1. Instead of the above, how could you adjust positioning for iPhone vs iPad
                
                let fadeOut = SKAction.fadeOutWithDuration(0.2)
                let fadeIn = SKAction.fadeInWithDuration(0.2)
                let move = SKAction.moveTo(newPos, duration:0.2)
                
                self.alien.runAction(SKAction.sequence([fadeOut, move, fadeIn]))
            } else {
                print("miss")
                self.runAction(self.miss)
            }
        }

    }
    
   
    override func update(currentTime: CFTimeInterval) {
        //pass
    }
}
