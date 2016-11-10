//
//  ViewController.swift
//  TheRemainsOfTheDay
//
//  Created by Mini Panton on 11/10/16.
//  Copyright © 2016 Mini Panton. All rights reserved.
//

import UIKit
import SpriteKit

var skView : SKView? = nil

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

