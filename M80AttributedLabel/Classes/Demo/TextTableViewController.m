//
//  TextTableViewController.m
//  M80AttributedLabel
//
//  Created by amao on 7/10/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "TextTableViewController.h"
#import "M80AttributedLabel.h"
#import "AutoLayoutTableViewCell.h"

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
@property (nonatomic,assign)    BOOL        autoLayout;
@end

@implementation Messsage
+ (Messsage *)message
{
    Messsage *message = [[Messsage alloc]init];
    message.messageID = [[NSUUID UUID] UUIDString];
    message.text      = [Messsage ramdomText];
    message.autoLayout= arc4random() % 2 == 0;
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
        for (NSInteger i = 0; i < 200; i++)
        {
            Messsage *message = [Messsage message];
            [messages addObject:message];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_messages insertObjects:messages
                           atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [messages count])]];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    });
}

- (void)onReload:(id)sender
{
    NSLog(@"begin reload");
    [self.tableView reloadData];
    NSLog(@"end reload %lu",(unsigned long)[_messages count]);
}

#pragma mark - Table view Helper
- (CGFloat)cellHeight:(Messsage *)message
{
    NSString *messageID = message.messageID;
    CGFloat height = [[_cellHeights objectForKey:messageID] floatValue];
    if (height == 0)
    {
        if (message.autoLayout)
        {
            AutoLayoutTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutTableViewCell"
                                                                          owner:nil
                                                                         options:nil] lastObject];
            [self updateLabel:cell.autoLayoutLabel
                         text:message.text];
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            height = size.height + 1;
        }
        else
        {
            M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
            [self updateLabel:label
                         text:message.text];
            CGSize size = [label sizeThatFits:CGSizeMake(270, CGFLOAT_MAX)];
            height = size.height + 20 + 20;
        }
        [_cellHeights setObject:@(height)
                         forKey:messageID];
    }
    return height;
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

static const NSInteger labelTag = 10;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messsage *message = [_messages objectAtIndex:[indexPath row]];
    if (message.autoLayout)
    {
        AutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auto_message_cell"];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutTableViewCell"
                                                  owner:nil
                                                options:nil] lastObject];
        }
        [self updateLabel:cell.autoLayoutLabel
                     text:message.text];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message_cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:@"message_cell"];
            M80AttributedLabel *label = [[M80AttributedLabel alloc] initWithFrame:CGRectZero];
            [cell.contentView addSubview:label];
            [label setTag:labelTag];
        }
        M80AttributedLabel *label = (M80AttributedLabel *)[cell viewWithTag:labelTag];
        [self updateLabel:label
                     text:message.text];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messsage *message = [_messages objectAtIndex:[indexPath row]];
    if (!message.autoLayout)
    {
        M80AttributedLabel *label = (M80AttributedLabel *)[cell viewWithTag:labelTag];
        [label setFrame:CGRectMake(25, 20, cell.bounds.size.width - 25 * 2, cell.bounds.size.height - 20 * 2)];
    }
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



@end
