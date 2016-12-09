//
//  DemoTableViewController.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

struct Item {
    let title : String
    let subTitle : String
    let vcName : String
    
    init(_ title : String, _ subTitle : String, _ vcName : String) {
        self.title = title
        self.subTitle = subTitle
        self.vcName = vcName
    }
}




class DemoTableViewController: UITableViewController {
    
    let items : [Item] = [Item("Basic","How to create a simple M80AttributedLabel","BasicAttributedLabelViewController"),
                          Item("Customizing Text","How to use NSAttributedString","CustomTextViewController"),
                          Item("Links","Automatic and explicit Links","LinksViewController"),
                          Item("Images","How to display images using M80AttributedLabel","ImagesViewController"),
                          Item("LongText","Performance for displaying long text","LongTextViewController"),
                          Item("Attachment","Add UIView as attachment instead of UIImag","AttachmentViewController"),
                          Item("LineBreakMode","Different line break modes","LineBreakModeViewController"),
                          Item("TextAlignment","Different test alignments","TextAlignmentViewController")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        self.navigationController?.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "demo_identifier"
        let item = self.items[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier:identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = item.subTitle

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        let name = item.vcName
        if let vcClass = ClassByName(name: name) as? UIViewController.Type {
            let vc = vcClass.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
