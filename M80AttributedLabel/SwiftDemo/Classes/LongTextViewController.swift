//
//  LongTextViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class LongTextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "test", ofType: "txt"),
            let content = try? String(contentsOfFile: path) {
            
            let label = M80AttributedLabel()
            label.lineSpacing = 5.0
            label.paragraphSpacing = 10.0
            label.text = content
            
            let scrollView = UIScrollView(frame: self.view.bounds)
            scrollView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
            
            scrollView.addSubview(label)
            self.view.addSubview(scrollView)
            
            let size = label.sizeThatFits(CGSize.init(width: self.view.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude))
            label.frame = CGRect.init(x: 20, y: 10, width: size.width, height: size.height)
            scrollView.contentSize = CGSize.init(width: self.view.bounds.width, height: size.height + 20)
            

        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
