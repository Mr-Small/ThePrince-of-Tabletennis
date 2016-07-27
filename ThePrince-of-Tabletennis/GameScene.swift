//
//  GameScene.swift
//  ThePrince-of-Tabletennis
//
//  Created by Mr-Small on 2016/06/02.
//  Copyright (c) 2016 mr.small. All rights reserved.
//

import SpriteKit

// Sequence during game.
public enum GameSequence {
    case TITLE
    case COUNT
    case GAME
    case SCORE
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var initPostision: CGPoint?
    var uiLayerView: UILayerView?
    var sequence: GameSequence = .TITLE
    var counter: SKLabelNode!
    
    let CATEGORY_RACKET: UInt32 = 0x00000001
    let CATEGORY_BALL: UInt32 = 0x00000010
    let CATEGORY_ROUND: UInt32 = 0x00000100
    
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
        uiLayerView = UILayerView(frame: self.view!.frame)
        uiLayerView!.setup()
        self.view!.addSubview(uiLayerView!)
    }
    
    // Draw background color.
    private func drawBackground() {
        //let box = SKSpriteNode(color: SKColor.blueColor(), size: self.size)
        let box = SKSpriteNode(imageNamed: "background.png")
        box.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        box.size = self.size
        self.addChild(box)
    }
    
    // Draw racket image.
    private func drawRacket() {
        // Set first position.
        initPostision = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 5)
        let image = SKSpriteNode(imageNamed: "racket.png")
        image.size.width *= 0.3
        image.size.height *= 0.3
        image.position = initPostision!
        image.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(image.size.width / 2, image.size.height / 2))
        image.physicsBody?.dynamic = false
        image.physicsBody?.categoryBitMask = CATEGORY_RACKET
        image.physicsBody?.contactTestBitMask = CATEGORY_BALL
        image.name = "racket"
        self.addChild(image)
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        self.physicsBody?.categoryBitMask = CATEGORY_ROUND
        self.physicsBody?.contactTestBitMask = CATEGORY_BALL
        
        drawBackground()
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
        ball.physicsBody?.categoryBitMask = CATEGORY_BALL
        ball.physicsBody?.contactTestBitMask = CATEGORY_RACKET | CATEGORY_ROUND
        self.addChild(ball)
    }
    
    // Called when a touch begins.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Touch in title sequence.
        if self.sequence == .TITLE {
            self.sequence = .COUNT
            countDown()
            return
        }
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            for r in self.children {
                if r.name == "racket" {
                    if location.y < ((self.size.height * 2) / 3) {
                        let seq = SKAction.sequence([SKAction.moveTo(location, duration: 0.25),
                            SKAction.moveTo(initPostision!, duration: 0.5)])
                        r.runAction(seq)
                    }
                }
            }
        }
    }
   
    func addCounter() {
        let posx = self.frame.width / 2
        let posy = self.frame.height / 2
        
        counter = SKLabelNode(fontNamed: "Courier")
        counter.text = "3"
        counter.fontColor = UIColor.redColor()
        counter.fontSize = 100;
        counter.position = CGPointMake(posx, posy)
        self.addChild(counter)
    }
    
    func countDown() {
        // Count down 3..2..1..
        addCounter()
        
        let fadeOut: SKAction = SKAction.fadeOutWithDuration(0.8)
        let chg2: SKAction = SKAction.customActionWithDuration(0.1,
          actionBlock: {(SKNode, CGFloat) in
            self.counter.alpha = 1.0
            self.counter.text = "2"
        })
        let chg1: SKAction = SKAction.customActionWithDuration(0.1,
          actionBlock: {(SKNode, CGFloat) in
            self.counter.alpha = 1.0
            self.counter.text = "1"
        })
        
        let seq: SKAction = SKAction.sequence([fadeOut, chg2, fadeOut, chg1, fadeOut])
        counter.runAction(seq, completion: {
            self.counter.text = ""
            self.sequence = .GAME
            self.drawRacket()
            self.setUiLayer()
            self.addBall(CGPointMake(self.frame.width / 2, self.frame.height - 10))
        })
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if mask == (CATEGORY_RACKET | CATEGORY_BALL) {
            uiLayerView!.pointup(1) // TODO fix point value.
        } else if mask == (CATEGORY_ROUND | CATEGORY_BALL) {
            print("finish")
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
