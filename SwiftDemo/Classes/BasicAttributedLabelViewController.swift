//
//  BasicAttributedLabelViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class BasicAttributedLabelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Basic"

        let label = M80AttributedLabel()
        label.text = "Hello M80AttribtuedLabel"
        label.font = UIFont(name: "Zapfino", size: 25)
        label.textColor = RGB(0xFF9F00)
        label.shadowColor = UIColor.gray
        label.shadowBlur = 1
        label.frame = self.view.bounds.insetBy(dx: 20, dy: 20)
        
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
