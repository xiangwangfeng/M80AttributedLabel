//
//  TextAlignmentViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/13.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class TextAlignmentViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Text Alignment"
        
        let text = "Hello M80AttributedLabel"
        let alignments : [CTTextAlignment] = [.left,.right,.center,.justified,.natural]
        
        for alignment in alignments {
            
            let label = M80AttributedLabel()
            label.text = text
            label.textAlignment = alignment
            label.frame = CGRect.init(x: 20, y: 20 + Int(alignment.rawValue) * 60 , width: Int(self.view.bounds.width - 40), height: 25)
            
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.orange.cgColor
            
            self.view.addSubview(label)
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
