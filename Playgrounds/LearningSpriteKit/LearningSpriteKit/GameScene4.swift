//
//  GameScene4.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import SpriteKit

class GameScene4: SKScene {
    
    var anim:SKAction = SKAction.fadeAlphaTo(1.0, duration: 1.0)
    
    override func didMoveToView(view: SKView) {
        print("GameScene4: \(view.frame.size)")
        
        self.backgroundColor = UIColor(red: 0.3, green: 0.1, blue: 0.3, alpha: 1.0)
        
        let atlas = SKTextureAtlas(named: "alien")
        let t1 = atlas.textureNamed("alien1")
        let t2 = atlas.textureNamed("alien2")
        let t3 = atlas.textureNamed("alien3")
        let t4 = atlas.textureNamed("alien4")
        let t5 = atlas.textureNamed("alien5")
        let t6 = atlas.textureNamed("alien6")
        let t7 = atlas.textureNamed("alien7")
        let t8 = atlas.textureNamed("alien8")
        let t9 = atlas.textureNamed("alien9")
        let t10 = atlas.textureNamed("alien10")
        
        //create animation
        self.anim = SKAction.animateWithTextures([t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t9,t8,t7,t6,t5,t4,t3,t2,t1], timePerFrame: 0.05)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.locationInNode(self)
            print("touch: \(loc)")
            
            // move alien to touch pos
            let alien = SKSpriteNode(imageNamed: "alien1");
            alien.position = loc
            alien.alpha = 0.0
            self.addChild(alien);
            
            let fadeIn = SKAction.fadeInWithDuration(0.5);
            let fadeOut = SKAction.fadeOutWithDuration(0.5);
            
            alien.runAction(SKAction.sequence([fadeIn, self.anim, fadeOut]))
        }

    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        if let touch: AnyObject = touches.anyObject() {
//            let loc = touch.locationInNode(self)
//            print("touch: \(loc)")
//            
//            // move alien to touch pos
//            let alien = SKSpriteNode(imageNamed: "alien1");
//            alien.position = loc
//            alien.alpha = 0.0
//            self.addChild(alien);
//            
//            let fadeIn = SKAction.fadeInWithDuration(0.5);
//            let fadeOut = SKAction.fadeOutWithDuration(0.5);
//            
//            alien.runAction(SKAction.sequence([fadeIn, self.anim, fadeOut]))
//        }
//    }
   
    override func update(currentTime: CFTimeInterval) {
        //pass
    }
}
