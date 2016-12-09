//
//  LineBreakModeViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/13.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class LineBreakModeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LineBreakMode"
        
        let text = "有关美国的一切，可以用一句话来描述：“Americans business is business”，这句话的意思就是说，那个国家永远是在经商热中，而且永远是一千度的白热。所以你要是看了前文之后以为那里有某种气氛会有助于人立志写作就错了。连我哥哥到了那里都后悔了，觉得不该学逻辑，应当学商科或者计算机。虽然他依旧未证出的逻辑定理，但是看到有钱人豪华的住房，也免不了唠叨几句他对妻儿的责任。"
        
        let modes : [CTLineBreakMode] = [.byWordWrapping,.byCharWrapping,.byClipping,.byTruncatingHead,.byTruncatingMiddle,.byTruncatingTail]
        
        for mode in modes {
        
            let label = M80AttributedLabel()
            label.text = text
            label.lineBreakMode = mode
            label.numberOfLines = 2
            label.frame = CGRect.init(x: 20, y: 20 + Int(mode.rawValue) * 80, width: Int(self.view.bounds.width - 40.0), height: 70)
            
            label.layer.borderColor = UIColor.orange.cgColor
            label.layer.borderWidth = 1
            
            self.view.addSubview(label)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
