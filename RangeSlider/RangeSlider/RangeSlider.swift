//
//  RangeSlider.swift
//  RangeSlider
//
//  Created by gbmobile on 20/06/16.
//  Copyright © 2016 macxtter. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    
    var maximunValue: CGFloat = 10.0
    var minimumValue: CGFloat = 0.0
    var upperValue: CGFloat = 8.0
    var lowerValue: CGFloat = 2.0
    var trackLayer: CALayer
    var upperKnobLayer: RangeSliderKnobLayer
    var lowerKnobLayer: RangeSliderKnobLayer
    var knobWidth: CGFloat = 0.0
    var usableTrackLength: CGFloat = 0.0
    var previousTouchPoint: CGPoint

    
    override init(frame: CGRect) {
        previousTouchPoint = CGPoint.zero
        trackLayer = CALayer()
        trackLayer.backgroundColor = UIColor.blueColor().CGColor
        
        upperKnobLayer = RangeSliderKnobLayer()
        upperKnobLayer.backgroundColor = UIColor.greenColor().CGColor
        
        lowerKnobLayer = RangeSliderKnobLayer()
        lowerKnobLayer.backgroundColor = UIColor.greenColor().CGColor
        
        super.init(frame: frame)
        upperKnobLayer.slider = self
        lowerKnobLayer.slider = self
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(upperKnobLayer)
        self.layer.addSublayer(lowerKnobLayer)
        
        self.setLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func positionForValue(value: CGFloat) -> CGFloat{
        return usableTrackLength * (value - minimumValue) / (maximunValue - minimumValue) + (knobWidth / 2)
    }
    
    func setLayerFrames(){
        trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5)
        trackLayer.setNeedsDisplay()
        
        knobWidth = self.bounds.size.height
        usableTrackLength = self.bounds.size.width - knobWidth
        
        let upperKnobCentre = self.positionForValue(upperValue)
        upperKnobLayer.frame = CGRectMake(upperKnobCentre - knobWidth / 2.0, 0, knobWidth, knobWidth)
        
        let lowerKnobcentre = self.positionForValue(lowerValue)
        lowerKnobLayer.frame = CGRectMake(lowerKnobcentre - knobWidth / 2.0, 0, knobWidth, knobWidth)
        
        upperKnobLayer.setNeedsDisplay()
        lowerKnobLayer.setNeedsDisplay()
        
    }
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousTouchPoint = touch.locationInView(self)
        
        //hit test the knob layers
        if(CGRectContainsPoint(lowerKnobLayer.frame, previousTouchPoint)){
            lowerKnobLayer.highlighted = true
            lowerKnobLayer.setNeedsDisplay()
            
        }else if(CGRectContainsPoint(upperKnobLayer.frame, previousTouchPoint)){
            upperKnobLayer.highlighted = true
            upperKnobLayer.setNeedsDisplay()
        }
        
        return upperKnobLayer.highlighted || lowerKnobLayer.highlighted
    }

    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint: CGPoint = touch.locationInView(self)
        
        //1. determine by how muchthe user has dragged
        let delta = touchPoint.x - previousTouchPoint.x
        let valueDelta = (maximunValue - minimumValue) * delta / usableTrackLength
        
        previousTouchPoint = touchPoint
        
        //2. Update the values
        if(lowerKnobLayer.highlighted){
            lowerValue += valueDelta
            upperValue = min(max(upperValue,lowerValue),maximunValue)
        }
        if(upperKnobLayer.highlighted){
            upperValue += valueDelta
            upperValue = min(max(upperValue,lowerValue),maximunValue)
        }
        
        //3. update the UI state
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.setLayerFrames()
        
        CATransaction.commit()
        
        return true
        
    }
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        lowerKnobLayer.highlighted = false
        upperKnobLayer.highlighted = false
        lowerKnobLayer.setNeedsDisplay()
        upperKnobLayer.setNeedsDisplay()
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
