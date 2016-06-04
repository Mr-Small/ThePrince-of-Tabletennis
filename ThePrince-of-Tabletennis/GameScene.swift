//
//  GameScene.swift
//  ThePrince-of-Tabletennis
//
//  Created by Mr-Small on 2016/06/02.
//  Copyright (c) 2016 mr.small. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // not supported construct.
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        drawBackground()
        drawRacket()
    }
    
    // Draw background color.
    private func drawBackground() {
        let box = SKSpriteNode(color: SKColor.blueColor(), size: self.size)
        box.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        self.addChild(box)
    }
    
    // Draw racket image.
    private func drawRacket() {
        let image = SKSpriteNode(imageNamed: "racket.png")
        image.size = self.size
        image.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addChild(image)
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
