//
//  GameScene5.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import SpriteKit

class GameScene5: SKScene {
    
    let alien = SKSpriteNode(imageNamed: "alien1")
    let player = SKSpriteNode(imageNamed: "player")
    let fire = SKAction.playSoundFileNamed("fire.caf", waitForCompletion: false)
    let hit = SKAction.playSoundFileNamed("hit.caf", waitForCompletion: false)
    let miss = SKAction.playSoundFileNamed("miss.caf", waitForCompletion: false)
    
    var anim = SKAction()
    var alienDir = 1

    override func didMoveToView(view: SKView) {
        print("GameScene5: \(view.frame.size)")
        
        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
        
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
        
        self.anim = SKAction.animateWithTextures([t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t9,t8,t7,t6,t5,t4,t3,t2,t1], timePerFrame: 0.08)
        
        self.alien.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.alien.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height - self.alien.size.height)
        self.alien.runAction(SKAction.repeatActionForever(self.anim))
        self.addChild(self.alien)

        self.player.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.player.position = CGPoint(x: self.frame.width * 0.5, y: self.player.size.height)
        self.player.zPosition = 2.0
        self.addChild(player)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            print("FIRE!")
            self.runAction(self.fire)
            
            let missile = SKSpriteNode(imageNamed: "missile")
            missile.name = "missile"
            missile.position = self.player.position
            missile.zPosition = 1.0
            missile.alpha = 0.0
            self.addChild(missile)
            
            missile.runAction(SKAction.fadeAlphaTo(1.0, duration: 0.2))
        }
    }
    

   
    override func update(currentTime: CFTimeInterval) {
        //move alien
        if self.alien.alpha > 0 {
            var newX = self.alien.position.x + CGFloat(self.alienDir)
            
            if newX < self.alien.size.width {
                newX = self.alien.size.width
                self.alienDir = 1
            } else if newX > (self.size.width - self.alien.size.width) {
                newX = self.frame.width - self.alien.size.width
                self.alienDir = -1
            }
            
            self.alien.position = CGPoint(x: newX, y: self.alien.position.y)
        }
        
        //move missiles
        self.enumerateChildNodesWithName("missile") {
            missile, stop in
            missile.position = CGPoint(x: missile.position.x, y: missile.position.y + 5)
            if missile.position.y > self.frame.height {
                //miss
                print("miss")
                self.runAction(self.miss)
                missile.removeFromParent()
            } else if self.alien.alpha > 0 && self.alien.containsPoint(missile.position) {
                //hit
                print("hit")
                self.runAction(self.hit)
                self.alien.alpha = 0
                missile.alpha = 0
                missile.removeFromParent()
                self.alien.runAction(SKAction.sequence([
                    SKAction.fadeOutWithDuration(0.1),
                    SKAction.waitForDuration(0.5),
                    SKAction.runBlock(self.alienReborn),
                    SKAction.fadeInWithDuration(0.1)]))
            }
        }
    }
    
    func alienReborn() {
        //give alien random position & direction
        self.alien.position = CGPoint(x: self.frame.width * 0.5 + CGFloat(arc4random_uniform(201)) - 100.0, y: self.alien.position.y)
        self.alienDir = arc4random_uniform(2) == 0 ? -1 : 1
        self.alien.alpha = 0
    }
}
