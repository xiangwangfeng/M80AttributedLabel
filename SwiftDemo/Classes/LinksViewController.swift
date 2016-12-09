//
//  LinksViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class LinksViewController: BaseViewController,M80AttributedLabelDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Link"
        
        let text = "The game which I current play is hearthstone,and its website is www.hearthstone.com.cn"
        let label = M80AttributedLabel()
        label.text = text
        
        let range = (text as NSString).range(of: "hearthstone")
        if range.location != NSNotFound {
            label.addCustomLink(NSValue(range:range),for: range)
        }
        label.delegate = self
        
        label.frame = self.view.bounds.insetBy(dx: 20, dy: 20)
        
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func m80AttributedLabel(_ label: M80AttributedLabel, clickedOnLink linkData: Any) {
        
        let message = "LinkData is \(linkData) "
        let controller = UIAlertController(title: "you click a link", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }

    
}
