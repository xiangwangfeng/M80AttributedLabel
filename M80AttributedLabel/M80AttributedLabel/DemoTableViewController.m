//
//  DemoTableViewController.m
//  M80AttributedLabel
//
//  Created by amao on 4/21/14.
//  Copyright (c) 2014 Netease. All rights reserved.
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
    
    _items = @[[TableItem itemWithTitle:@"Basic"
                               subTitle:@"How to create a simple M80AttributedLabel"
                                 vcName:@"BasicAttributedLabelViewController"]
               
               
               ];
    
    /*
    _items = @[[TableItem itemWithTitle:@"TextView"
                                 vcName:@"ViewController"],
               [TableItem itemWithTitle:@"ChatView"
                                 vcName:@"ChatViewController"]];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TableItem *item = [_items objectAtIndex:[indexPath row]];
    NSString *vcName= [item vcName];
    UIViewController *controller = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
