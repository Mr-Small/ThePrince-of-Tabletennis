//
//  UILayerView.swift
//  ThePrince-of-Tabletennis
//
//  Created by Mr-Small on 2016/06/05.
//  Copyright © 2016 mr.small. All rights reserved.
//

import Foundation
import UIKit

class UILayerView : UIView {
    
    // unify top y position
    let UILAYER_TOP_Y: CGFloat = 30.0
    // Declare button rect size.
    let BUTTON_RECT = CGRect(x: 0, y: 0, width: 100, height: 40)
    // Declare function for click back button.
    let BUTTON_BACK_FUNCTION: Selector = #selector(UILayerView.onClickBack(_:))
    
    var score: Int
    var time: Int
    
    var scorePoint: UILabel?
    var timeCount: UILabel?
    
    // Initialize.
    override init(frame: CGRect) {
        
        time = 0
        score = 0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up ui component.
    func setup() {
        addBackButton()
        addLabels()
        
        // Start count timer.
        Timer.scheduledTimer(
            timeInterval: 1.0, target: self, selector: #selector(UILayerView.countup), userInfo: nil, repeats: true)
    }
    
    // Point up.
    func pointup(_ point: Int) {
        score += point
        scorePoint!.text = String(score)
    }
    
    func countup() {
        time += 1
        timeCount!.text = String(time)
    }
    
    // Draw labels.
    fileprivate func addLabels() {
        var posx = frame.width * 0.45
        var posy = frame.height * 0.05
        
        // Score:
        let score = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        score.text = "Score : "
        score.textColor = UIColor.white
        score.layer.position = CGPoint(x: posx, y: posy)
        self.addSubview(score)
        // Point
        scorePoint = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        scorePoint!.text = "0"
        scorePoint!.textColor = UIColor.white
        scorePoint!.textAlignment = NSTextAlignment.right
        scorePoint!.layer.position = CGPoint(x: posx + 5, y: posy)
        self.addSubview(scorePoint!)
        
       
        posx = frame.width * 0.8
        posy = frame.height * 0.05
        // Time:
        let time = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        time.text = "Time : "
        time.textColor = UIColor.white
        time.layer.position = CGPoint(x: posx, y: posy)
        self.addSubview(time)
        // Count
        timeCount = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        timeCount!.text = "0"
        timeCount!.textColor = UIColor.white
        timeCount!.textAlignment = NSTextAlignment.right
        timeCount!.layer.position = CGPoint(x: posx + 5, y: posy)
        self.addSubview(timeCount!)
    }
    
    // Add back button.
    fileprivate func addBackButton() {
        let posx = frame.width * 0.15
        let posy = frame.height * 0.05
        
        let button = UIButton()
        button.frame = BUTTON_RECT
        button.backgroundColor = UIColor.red
        button.layer.masksToBounds = true
        button.setTitle("Back", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitleColor(UIColor.yellow, for: UIControlState.highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.position = CGPoint(x: posx, y: posy)
        button.addTarget(self, action: BUTTON_BACK_FUNCTION, for: .touchUpInside)
        
        self.addSubview(button)
    }
    
    // call when click back button
    func onClickBack(_ sender: UIButton) {

    }
}
