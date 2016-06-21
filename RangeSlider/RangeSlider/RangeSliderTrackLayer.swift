//
//  RangeSliderTrackLayer.swift
//  RangeSlider
//
//  Created by gbmobile on 21/06/16.
//  Copyright © 2016 macxtter. All rights reserved.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
    
    var slider: RangeSlider!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        //clip
        let cornerRadius = self.bounds.size.height * self.slider.curvaceousness / 2.0
        let switchOutline: UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        
        CGContextAddPath(ctx, switchOutline.CGPath)
        CGContextClip(ctx)
        
        // 1) fill the track
        CGContextSetFillColorWithColor(ctx, self.slider.trackColor.CGColor)
        CGContextAddPath(ctx, switchOutline.CGPath)
        CGContextFillPath(ctx)
        
        // 2) fill the highlighed range
        CGContextSetFillColorWithColor(ctx, self.slider.trackHighlightColor.CGColor)
        let lower: CGFloat = self.slider.positionForValue(self.slider.lowerValue)
        let upper: CGFloat = self.slider.positionForValue(self.slider.upperValue)
        CGContextFillRect(ctx, CGRectMake(lower, 0, upper - lower, self.bounds.size.height))
        
        // 3) add a lighlight over the track
        let highlight: CGRect = CGRectMake(cornerRadius/2,
                                           self.bounds.size.height/2,
                                           self.bounds.size.width - cornerRadius,
                                           self.bounds.size.height/2)
        let highlightPath: UIBezierPath = UIBezierPath(roundedRect: highlight,
                                                       cornerRadius: highlight.size.height * self.slider.curvaceousness / 2.0)
        CGContextAddPath(ctx, highlightPath.CGPath)
        CGContextSetFillColorWithColor(ctx, UIColor(white: 1.0, alpha: 0.4).CGColor)
        CGContextFillPath(ctx)
        
        // 4) inner shadow
        CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.0), 3.0, UIColor.grayColor().CGColor)
        CGContextAddPath(ctx, switchOutline.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.greenColor().CGColor)
        CGContextStrokePath(ctx)
        
        // 5) outline the track
        CGContextAddPath(ctx, switchOutline.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 0.5)
        CGContextStrokePath(ctx)
    }


}
