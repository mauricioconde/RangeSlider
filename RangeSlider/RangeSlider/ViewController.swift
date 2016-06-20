//
//  ViewController.swift
//  RangeSlider
//
//  Created by gbmobile on 20/06/16.
//  Copyright © 2016 macxtter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rangeSlider: RangeSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let margin: CGFloat = 20.0
        let sliderFrame = CGRectMake(margin, 100, self.view.frame.size.width - margin * 2 , 30)
        rangeSlider = RangeSlider(frame: sliderFrame)
        rangeSlider.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(rangeSlider)
        
        //rangeSlider.addTarget(self, action: #selector(ViewController), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

