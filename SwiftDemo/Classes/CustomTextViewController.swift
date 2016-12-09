//
//  CustomTextViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class CustomTextViewController: BaseViewController {
    
    let fontSize : [CGFloat] = [12,13,17,25]
    let colors = [RGB(0x000000),RGB(0x0000ff),RGB(0x00ff00),RGB(0xff0000)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom Text"
        
        let label = M80AttributedLabel()
        let text = "The release of iOS 7 brings a lot of new tools to the table for developers."
        let components = text.components(separatedBy: " ")
        for component in components {
            let index = Int(arc4random() % 4)
            let attributedText = NSMutableAttributedString(string: component)
            attributedText.m80_setFont(UIFont.systemFont(ofSize: fontSize[index]))
            attributedText.m80_setTextColor(colors[index])
            
            label.appendAttributedText(attributedText)
            label.appendText(" ")
        }
        
        label.frame = self.view.bounds.insetBy(dx: 20, dy: 20)
        self.view.addSubview(label)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
