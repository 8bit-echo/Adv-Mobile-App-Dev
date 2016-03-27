//
//  GameViewController.swift
//  LearningSpriteKit
//
//  Created by Justin on 12/1/14.
//  Copyright (c) 2014 SaturnBoy. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = UIScreen.mainScreen().applicationFrame
        let scale = UIScreen.mainScreen().scale
        print("appFrame: \(frame)")
        print("scale: \(scale)")
        
        let w = frame.width //* scale
        let h = frame.height //* scale
        let scene = GameScene5(size: CGSize(width: w, height: h))
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
