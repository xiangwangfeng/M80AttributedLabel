//
//  ImagesViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class ImagesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = M80AttributedLabel()
        label.lineSpacing = 5.0
        
    
        if let image = UIImage(named: "avatar") {
            label.append(image, maxSize: CGSize.init(width: 40, height: 40), margin:.zero)
        }
        
        let text = "say:\n有人问一位登山家为什么要去登山——谁都知道登山这件事既危险，又没什么实际的好处。[haha][haha][haha][haha]他回答道：“因为那座山峰在那里。”我喜欢这个答案，因为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。[haha][haha][haha]它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。[haha][haha][haha]用热力学的角度来看，这是个反熵的现象，所发趋害避利肯定反熵。"
        let components = text.components(separatedBy: "[haha]")
        let count = components.count
        for i in 0..<count {
            label.appendText(components[i])
            if i != count - 1 , let image = UIImage(named: "haha")  {
                label.append(image, maxSize: CGSize.init(width: 15, height: 15), margin: .zero, alignment: .center)
            }
        }
        
        label.frame = self.view.bounds.insetBy(dx: 20, dy: 20)
        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
