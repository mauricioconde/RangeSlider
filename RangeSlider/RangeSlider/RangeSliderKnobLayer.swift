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
}
