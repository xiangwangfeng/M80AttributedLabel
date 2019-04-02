//
//  AttachmentViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

class AttachmentViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Attachment"
        
        let label = M80AttributedLabel()

        for i in 0..<3 {
            label.appendText("Click the icon to fire event")
            
            let button = UIButton(type: .custom)
            button.setBackgroundImage(UIImage(named:"play"), for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            button.bounds = CGRect.init(x: 0, y: 0, width: 30, height: 30)
            button.tag = i
            label.append(button)
            label.appendText("\n\n\n")
        }
        
        label.frame = self.view.bounds.insetBy(dx: 20, dy: 20)
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonClicked(_ sender : AnyObject) {
        if let button = sender as? UIButton {
            let message = "button tag is \(button.tag)"
            let controller = UIAlertController(title: "you click a button", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)

        }
    }

}
