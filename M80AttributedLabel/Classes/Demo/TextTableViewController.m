//
//  TextTableViewController.m
//  M80AttributedLabel
//
//  Created by amao on 7/10/14.
//  Copyright (c) 2014 Netease. All rights reserved.
//

#import "TextTableViewController.h"
#import "M80AttributedLabel.h"

static dispatch_queue_t shared_queue()
{
    static dispatch_queue_t queue = NULL;
    if (queue == NULL)
    {
        queue = dispatch_queue_create("data_source_queue", 0);
    }
    return queue;
}



@interface Messsage : NSObject
@property (nonatomic,strong)    NSString    *messageID;
@property (nonatomic,strong)    NSString    *text;
@end

@implementation Messsage
+ (Messsage *)message
{
    Messsage *message = [[Messsage alloc]init];
    message.messageID = [[NSUUID UUID] UUIDString];
    message.text      = [Messsage ramdomText];
    return message;
}

+ (NSString *)ramdomText
{
    static NSArray *messages = nil;

    if (messages == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test"
                                                         ofType:@"txt"];
        NSString *content = [[NSString alloc] initWithContentsOfFile:path
                                                            encoding:NSUTF8StringEncoding
                                                               error:nil];
        NSArray *contentLines = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

        
        NSMutableArray *tempMessages = [NSMutableArray array];
        for (NSInteger i = 0; i < 100; i++)
        {
            NSMutableString *str = [[NSMutableString alloc]init];
            [str appendString:@"M80 says:[haha] [haha] Your magic is Mine.[haha] [haha]"];
            NSInteger line = random() % [contentLines count];
            for (NSInteger j = 0; j < random() % 3; j++)
            {
                [str appendString:[contentLines objectAtIndex:line]];
            }
            [tempMessages addObject:str];
            messages = tempMessages;
        }
    }
    NSInteger count = arc4random() % 100;
    return [messages objectAtIndex:count];
}
@end


@interface TextTableViewController ()
@property (nonatomic,strong)    UIRefreshControl        *refreshControl;
@property (nonatomic,strong)    NSMutableArray          *messages;
@property (nonatomic,strong)    NSMutableDictionary     *cellHeights;
@property (nonatomic,strong)    NSCache                 *cachedLabels;
@end

@implementation TextTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(onRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    _messages = [NSMutableArray array];
    _cellHeights = [NSMutableDictionary dictionary];
    _cachedLabels = [[NSCache alloc]init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Reload"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(onReload:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onRefresh:(id)sender
{
    dispatch_async(shared_queue(), ^{
        NSMutableArray *messages = [NSMutableArray array];
        for (NSInteger i = 0; i < 200; i++) //提高加载数量，可迫使Cache内Label回收
        {
            Messsage *message = [Messsage message];
            [messages addObject:message];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_messages insertObjects:messages
                           atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [messages count])]];
            [self.refreshControl endRefreshing];
            NSLog(@"begin reload");
            [self.tableView reloadData];
            NSLog(@"end reload %ld",[_messages count]);
        });
    });
}

- (void)onReload:(id)sender
{
    NSLog(@"begin reload");
    [self.tableView reloadData];
    NSLog(@"end reload %ld",[_messages count]);
}

#pragma mark - Table view Helper
- (CGFloat)cellHeight:(Messsage *)message
{
    NSString *messageID = message.messageID;
    CGFloat height = [[_cellHeights objectForKey:messageID] floatValue];
    if (height == 0)
    {
        M80AttributedLabel *label = [self labelForMessage:message];
        CGSize size = label.bounds.size;
        
        height = size.height + 20 + 20;
        [_cellHeights setObject:@(height)
                         forKey:messageID];
        
        [_cachedLabels setObject:label
                          forKey:messageID];
    }
    return height;
}


- (M80AttributedLabel *)labelForMessage:(Messsage *)message
{
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    [self updateLabel:label
                 text:message.text];
    CGSize size = [label sizeThatFits:CGSizeMake(270, CGFLOAT_MAX)];
    [label setBounds:CGRectMake(0, 0, size.width, size.height)];
    return label;
}


- (void)updateLabel:(M80AttributedLabel *)label
               text:(NSString *)text
{
    [label setText:@""];
    
    NSArray *components = [text componentsSeparatedByString:@"[haha]"];
    NSUInteger count = [components count];
    for (NSUInteger i = 0; i < count; i++)
    {
        [label appendText:[components objectAtIndex:i]];
        if (i != count - 1)
        {
            [label appendImage:[UIImage imageNamed:@"haha"]
                       maxSize:CGSizeMake(13, 13)
                        margin:UIEdgeInsetsZero
                     alignment:M80ImageAlignmentCenter];
        }
    }
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messsage *message = [_messages objectAtIndex:[indexPath row]];
    NSString *messageID = message.messageID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message_cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:@"message_cell"];
    }
    
    const NSInteger tag = 10;
    M80AttributedLabel *label = (M80AttributedLabel *)[cell viewWithTag:tag];
    if (label)
    {
        [label removeFromSuperview];
    }
    
    
    label = [_cachedLabels objectForKey:messageID];
    if (label == nil)
    {
        label = [self labelForMessage:message];
        [_cachedLabels setObject:label
                          forKey:messageID];
    }
    

    [cell addSubview:label];
    [label setTag:tag];
    CGRect frame = CGRectMake(25, 20, label.bounds.size.width, label.bounds.size.height);
    [label setFrame:frame];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messsage *message = [_messages objectAtIndex:[indexPath row]];
    return [self cellHeight:message];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messsage *message = [_messages objectAtIndex:[indexPath row]];
    UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"What U Select"
                                                  message:message.text
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil, nil];
    [alert show];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
