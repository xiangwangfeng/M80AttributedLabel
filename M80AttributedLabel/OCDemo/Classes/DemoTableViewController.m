//
//  DemoTableViewController.m
//  M80AttributedLabel
//
//  Created by amao on 4/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "DemoTableViewController.h"

@interface TableItem : NSObject
@property (nonatomic,strong)    NSString    *title;
@property (nonatomic,strong)    NSString    *subTitle;
@property (nonatomic,strong)    NSString    *vcName;
@end

@implementation TableItem
+ (TableItem *)itemWithTitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                      vcName:(NSString *)vcName
{
    TableItem *instance = [[TableItem alloc]init];
    instance.title      = title;
    instance.subTitle   = subTitle;
    instance.vcName= vcName;
    return instance;
}
@end

@interface DemoTableViewController ()
@property (nonatomic,strong)    NSArray *items;
@end

@implementation DemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"M80AttributedLabel";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    _items = @[[TableItem itemWithTitle:@"Basic"
                               subTitle:@"How to create a simple M80AttributedLabel"
                                 vcName:@"BasicAttributedLabelViewController"],
               
               
               [TableItem itemWithTitle:@"Customizing Text"
                               subTitle:@"How to use NSAttributedString"
                                 vcName:@"CustomTextViewController"],
               
               [TableItem itemWithTitle:@"Links"
                               subTitle:@"Automatic and explicit Links"
                                 vcName:@"LinksViewController"],
               
               [TableItem  itemWithTitle:@"Images"
                                subTitle:@"How to display images using M80AttributedLabel"
                                  vcName:@"ImagesViewController"],
               
               [TableItem itemWithTitle:@"LongText"
                               subTitle:@"Performance for displaying long text"
                                 vcName:@"LongTextViewController"],
               
               [TableItem itemWithTitle:@"Attachment"
                               subTitle:@"Add UIView as attachment instead of UIImage"
                                 vcName:@"AttachmentViewController"],
               
               [TableItem itemWithTitle:@"LineBreakMode"
                               subTitle:@"Different line break modes"
                                 vcName:@"LineBreakModeViewController"],
               
               [TableItem itemWithTitle:@"TextAlignment"
                               subTitle:@"Different test alignments"
                                 vcName:@"TextAlignmentViewController"],
               
               [TableItem itemWithTitle:@"TableViewCell"
                               subTitle:@"AttributedLabel in tableviewcell"
                                 vcName:@"TextTableViewController"],
               
               ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test_demo_cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:@"test_demo_cell"];
    }
    TableItem *item = [_items objectAtIndex:[indexPath row]];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subTitle;
    return cell;
}



#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TableItem *item = [_items objectAtIndex:[indexPath row]];
    NSString *vcName= [item vcName];
    UIViewController *controller = [[NSClassFromString(vcName) alloc] init];
    controller.title = [item title];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
