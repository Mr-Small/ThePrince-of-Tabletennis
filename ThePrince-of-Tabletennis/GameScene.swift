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
    
    // Initialize.
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    // Set up UI layer component.
    private func setUiLayer() {
        let uiLayerView = UILayerView(frame: self.view!.frame)
        uiLayerView.setup()
        self.view!.addSubview(uiLayerView)
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
        image.size.width *= 0.3
        image.size.height *= 0.3
        image.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3)
        image.physicsBody = SKPhysicsBody(rectangleOfSize: image.size)
        image.name = "racket"
        self.addChild(image)
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        
        drawBackground()
        drawRacket()
        
        setUiLayer()
    }
    
    private func addBall(location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: "ball.png")
        
        let width = ball.size.width * 0.1
        let height = ball.size.height * 0.1
        
        ball.size.width = width
        ball.size.height = height
        ball.position = location
        ball.physicsBody = SKPhysicsBody(circleOfRadius: width)
        ball.physicsBody?.dynamic = true
        self.addChild(ball)
    }
    
    // Called when a touch begins.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var isRacket = false
            for r in self.children {
                if r.name == "racket" {
                    if r.containsPoint(location) {
                        print(location)
                        r.physicsBody?.applyImpulse(CGVectorMake(0, 1000))
                        isRacket = true
                    }
                }
            }
            if !isRacket {
                addBall(location)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
