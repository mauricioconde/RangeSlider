//
//  RangeSliderKnobLayer.swift
//  RangeSlider
//
//  Created by gbmobile on 20/06/16.
//  Copyright © 2016 macxtter. All rights reserved.
//

import UIKit

class RangeSliderKnobLayer: CALayer {
    var highlighted: Bool
    var slider: RangeSlider!
    
    override init() {
        highlighted = false
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let knobFrame: CGRect = CGRectInset(self.bounds, 2.0, 2.0);
        
        let knobPath: UIBezierPath = UIBezierPath(roundedRect: knobFrame,
                                                  cornerRadius: knobFrame.size.height * self.slider.curvaceousness / 2.0)
        
        
        // 1) fill - with a subtle shadow
        CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, UIColor.grayColor().CGColor);
        CGContextSetFillColorWithColor(ctx, self.slider.knobColour.CGColor);
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextFillPath(ctx);
        
        
        // 2) outline
        CGContextSetStrokeColorWithColor(ctx, UIColor.grayColor().CGColor);
        CGContextSetLineWidth(ctx, 0.5);
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextStrokePath(ctx);
        
        
        // 3) inner gradient
        let rect: CGRect = CGRectInset(knobFrame, 2.0, 2.0);
        let clipPath: UIBezierPath = UIBezierPath(roundedRect: rect,
                                                  cornerRadius: rect.size.height * self.slider.curvaceousness / 2.0)
        var myGradient: CGGradientRef;
        var myColorspace: CGColorSpaceRef;
        let num_locations: size_t = 2;
        let locations: [CGFloat] = [ 0.0, 1.0 ];
        let components: [CGFloat] = [ 0.0, 0.0, 0.0 , 0.15,  // Start color
            0.0, 0.0, 0.0, 0.05 ]; // End color
        
        myColorspace = CGColorSpaceCreateDeviceRGB()!;
        myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations)!;
        
        
        let startPoint: CGPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        let endPoint: CGPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, clipPath.CGPath);
        CGContextClip(ctx);
        CGContextDrawLinearGradient(ctx,
                                    myGradient,
                                    startPoint,
                                    endPoint,
                                    CGGradientDrawingOptions.DrawsBeforeStartLocation)
        
        CGContextRestoreGState(ctx);
        
        // 4) highlight
        if (self.highlighted)
        {
            // fill
            CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor);
            CGContextAddPath(ctx, knobPath.CGPath);
            CGContextFillPath(ctx);
        }
    }
}
