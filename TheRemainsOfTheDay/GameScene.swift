//
//  GameScene.swift
//  TheRemainsOfTheDay
//
//  Created by Mini Panton on 10/19/16.
//  Copyright (c) 2016 Some Feelers. All rights reserved.
//

import SpriteKit
import AVFoundation

var ghost : SKSpriteNode!
var bg:SKSpriteNode!
var ghostWalkingFrames : [SKTexture]!
var ghostWalkingFrames2 : [SKTexture]!
var go:Bool = false
var audioPlayer:AVAudioPlayer?
var bgAudio:AVAudioPlayer?

//var bgImage:UIImageView?

class GameScene: SKScene, AVAudioPlayerDelegate {
    
    func swipedRight(){
        print("swiped right")
        go = true;
    }
    
    
    override func didMove(to view: SKView) {
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        prepareAudio()
        playBGAudio()
        
        let bgImage = SKSpriteNode(imageNamed: "bg.png")
        bgImage.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        
        let ghostAnimatedAtlas : SKTextureAtlas = SKTextureAtlas(named: "Blip")

        //Load the animation frames from the TextureAtlas
        var walkFrames = [SKTexture]()
        var walkFrames2 = [SKTexture]()
        let numImages : Int = ghostAnimatedAtlas.textureNames.count
        
        for i in 0...22 {
            let ghostTextureName = "Seq_\(i)"
            walkFrames.append(ghostAnimatedAtlas.textureNamed(ghostTextureName))
        }
        
        for i in 23...numImages-1 {
            let ghostTextureName = "Seq_\(i)"
            walkFrames2.append(ghostAnimatedAtlas.textureNamed(ghostTextureName))
            
        }
        
        ghostWalkingFrames = walkFrames
        ghostWalkingFrames2 = walkFrames2
  
        let temp : SKTexture = ghostWalkingFrames[0]
        ghost = SKSpriteNode(texture: temp)
        ghost.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        addChild(ghost)
        
        
        
        //Start the bear walking
        talkingGhost()
        
    }
    
    func talkingGhost() {
        
        var moveAction = SKAction.animate(with: ghostWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)
        
        let doneAction = SKAction.run({
            
            if(go == false)
            {
                self.talkingGhost()
            }
            else {
                
                self.talkingGhost2()
            }
            
            
        })
        
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        
        ghost.run(moveActionWithDone, withKey:"bearWalking")

        
    }
    
    func prepareAudio()
    {
        // set URL of the sound
        let soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: "wind_then_voice_no_chirping", ofType: "wav")!)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer!.delegate = self
            
            // check if audioPlayer is prepared to play audio
            if (audioPlayer!.prepareToPlay())
            {
                audioPlayer!.play()
                audioPlayer!.pause()
            }
        }
        catch
        { }
    }
    
    func playBGAudio()
    {
        // set URL of the sound
        let soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: "chirping", ofType: "wav")!)
        
        do
        {
            bgAudio = try AVAudioPlayer(contentsOf: soundURL)
            bgAudio!.delegate = self
            bgAudio?.numberOfLoops = -1
            
            // check if audioPlayer is prepared to play audio
            if (bgAudio!.prepareToPlay())
            {
                bgAudio!.play()
                //bgAudio!.pause()
            }
        }
        catch
        { }
    }
 
    override func touchesEnded(_ touches:Set<UITouch>, with event: UIEvent?) {
        
        go = true;
        
        
    }
    
    func talkingGhost2() {
        
        if (audioPlayer!.prepareToPlay())
        {
            audioPlayer!.play()
        }
                let moveAction = (SKAction.animate(with: ghostWalkingFrames2, timePerFrame: 0.06, resize: false, restore: true))
                let doneAction = (SKAction.run({
                    print("Animation Completed")
                    self.bearMoveEnded()
                    go = false
                }))
                let moveActionWithDone = (SKAction.sequence([moveAction, doneAction]))
        
                ghost.run(moveActionWithDone, withKey:"bearMovingMore")
        
    }
    func bearMoveEnded()
    {
        ghost.removeAllActions()
        talkingGhost()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event:UIEvent?){
        
    }
   

    
    
    
}
