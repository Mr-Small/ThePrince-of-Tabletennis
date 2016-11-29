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
    case title
    case count
    case game
    case score
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var initPostision: CGPoint?
    var uiLayerView: UILayerView?
    var sequence: GameSequence = .title
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
    fileprivate func setUiLayer() {
        uiLayerView = UILayerView(frame: self.view!.frame)
        uiLayerView!.setup()
        self.view!.addSubview(uiLayerView!)
    }
    
    // Draw background color.
    fileprivate func drawBackground() {
        //let box = SKSpriteNode(color: SKColor.blueColor(), size: self.size)
        let box = SKSpriteNode(imageNamed: "background.png")
        box.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        box.size = self.size
        self.addChild(box)
    }
    
    // Draw racket image.
    fileprivate func drawRacket() {
        // Set first position.
        initPostision = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 5)
        let image = SKSpriteNode(imageNamed: "racket.png")
        image.size.width *= 0.3
        image.size.height *= 0.3
        image.position = initPostision!
        image.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: image.size.width / 2, height: image.size.height / 2))
        image.physicsBody?.isDynamic = false
        image.physicsBody?.categoryBitMask = CATEGORY_RACKET
        image.physicsBody?.contactTestBitMask = CATEGORY_BALL
        image.name = "racket"
        self.addChild(image)
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        self.physicsBody?.categoryBitMask = CATEGORY_ROUND
        self.physicsBody?.contactTestBitMask = CATEGORY_BALL
        
        drawBackground()
    }
    
    fileprivate func addBall(_ location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: "ball.png")
        
        let width = ball.size.width * 0.1
        let height = ball.size.height * 0.1
        
        ball.size.width = width
        ball.size.height = height
        ball.position = location
        ball.physicsBody = SKPhysicsBody(circleOfRadius: width)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = CATEGORY_BALL
        ball.physicsBody?.contactTestBitMask = CATEGORY_RACKET | CATEGORY_ROUND
        self.addChild(ball)
    }
    
    // Called when a touch begins.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Touch in title sequence.
        if self.sequence == .title {
            self.sequence = .count
            countDown()
            return
        }
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            for r in self.children {
                if r.name == "racket" {
                    //if location.y < ((self.size.height * 2) / 3) {
                        let seq = SKAction.sequence([SKAction.move(to: location, duration: 0.15),
                            SKAction.move(to: initPostision!, duration: 0.4)])
                        r.run(seq)
                    //}
                }
            }
        }
    }
   
    func addCounter() {
        let posx = self.frame.width / 2
        let posy = self.frame.height / 2
        
        counter = SKLabelNode(fontNamed: "Courier")
        counter.text = "3"
        counter.fontColor = UIColor.red
        counter.fontSize = 100;
        counter.position = CGPoint(x: posx, y: posy)
        self.addChild(counter)
    }
    
    func countDown() {
        // Count down 3..2..1..
        addCounter()
        
        let fadeOut: SKAction = SKAction.fadeOut(withDuration: 0.8)
        let chg2: SKAction = SKAction.customAction(withDuration: 0.1,
          actionBlock: {(SKNode, CGFloat) in
            self.counter.alpha = 1.0
            self.counter.text = "2"
        })
        let chg1: SKAction = SKAction.customAction(withDuration: 0.1,
          actionBlock: {(SKNode, CGFloat) in
            self.counter.alpha = 1.0
            self.counter.text = "1"
        })
        
        let seq: SKAction = SKAction.sequence([fadeOut, chg2, fadeOut, chg1, fadeOut])
        counter.run(seq, completion: {
            self.counter.text = ""
            self.sequence = .game
            self.drawRacket()
            self.setUiLayer()
            self.addBall(CGPoint(x: self.frame.width / 2, y: self.frame.height - 10))
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if mask == (CATEGORY_RACKET | CATEGORY_BALL) {
            uiLayerView!.pointup(1) // TODO fix point value.
        } else if mask == (CATEGORY_ROUND | CATEGORY_BALL) {
            print("finish")
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
