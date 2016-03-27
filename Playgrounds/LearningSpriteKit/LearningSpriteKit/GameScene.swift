//
//  GameScene.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let alien = SKSpriteNode(imageNamed: "alien1")
    
    override func didMoveToView(view: SKView) {
        print("GameScene: \(view.frame.size)")
        
        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
        
        self.addChild(self.alien)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.locationInNode(self)
            print("touch: \(loc)")
            
            // move alien to touch pos
            self.alien.position = loc
            self.alien.xScale = 1
            self.alien.yScale = 1
        }
    }
    

   
    override func update(currentTime: CFTimeInterval) {
        //move it
        self.alien.position = CGPoint(x: self.alien.position.x + 1.0,
                                      y: self.alien.position.y + 1.0)
        
        // 1. move it faster
        //self.alien.position = CGPoint(x: self.alien.position.x + 2.0,
        //                              y: self.alien.position.y + 2.0)
        
        // 2. make it bigger, smaller
        self.alien.xScale += 0.01
        self.alien.yScale += 0.01
        
        // 3. make it rotate
        self.alien.zRotation -= 0.01
        
        // 4. make is disappear
        //self.alien.alpha -= 0.002
        
        // 5. make it bounce at the edges...
    }
}
