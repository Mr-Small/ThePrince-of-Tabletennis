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
    let BUTTON_RECT = CGRectMake(0, 0, 100, 40)
    // Declare function for click back button.
    let BUTTON_BACK_FUNCTION: Selector = #selector(UILayerView.onClickBack(_:))
    
    // Initialize.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up ui component.
    func setup() {
        addBackButton()
        addLabels()
    }
    
    // Draw labels.
    private func addLabels() {
        var posx = frame.width * 0.45
        var posy = frame.height * 0.05
        
        // Score:
        let score = UILabel(frame: CGRectMake(0, 0, 100, 50))
        score.text = "Score : "
        score.textColor = UIColor.whiteColor()
        score.layer.position = CGPoint(x: posx, y: posy)
        self.addSubview(score)
        // Point
        let scorePoint = UILabel(frame: CGRectMake(0, 0, 100, 50))
        scorePoint.text = "0"
        scorePoint.textColor = UIColor.whiteColor()
        scorePoint.textAlignment = NSTextAlignment.Right
        scorePoint.layer.position = CGPoint(x: posx + 5, y: posy)
        self.addSubview(scorePoint)
        
       
        posx = frame.width * 0.8
        posy = frame.height * 0.05
        // Time:
        let time = UILabel(frame: CGRectMake(0, 0, 100, 50))
        time.text = "Time : "
        time.textColor = UIColor.whiteColor()
        time.layer.position = CGPoint(x: posx, y: posy)
        self.addSubview(time)
        // Count
        let timeCount = UILabel(frame: CGRectMake(0, 0, 100, 50))
        timeCount.text = "0"
        timeCount.textColor = UIColor.whiteColor()
        timeCount.textAlignment = NSTextAlignment.Right
        timeCount.layer.position = CGPoint(x: posx + 5, y: posy)
        self.addSubview(timeCount)
    }
    
    // Add back button.
    private func addBackButton() {
        let posx = frame.width * 0.15
        let posy = frame.height * 0.05
        
        let button = UIButton()
        button.frame = BUTTON_RECT
        button.backgroundColor = UIColor.redColor()
        button.layer.masksToBounds = true
        button.setTitle("Back", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.position = CGPoint(x: posx, y: posy)
        button.addTarget(self, action: BUTTON_BACK_FUNCTION, forControlEvents: .TouchUpInside)
        
        self.addSubview(button)
    }
    
    // call when click back button
    func onClickBack(sender: UIButton) {

    }
}