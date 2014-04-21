//
//  ChatViewController.m
//  M80AttributedLabel
//
//  Created by amao on 4/21/14.
//  Copyright (c) 2014 Netease. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"

@interface CachedLabelInfo : NSObject
@property (strong,nonatomic)    M80AttributedLabel *cachedLabel;
@property (assign,nonatomic)    CGSize cachedSize;
@end

@implementation CachedLabelInfo
@end


@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIView *chatInputView;
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (strong, nonatomic) NSMutableArray *chatItems;
@property (strong, nonatomic) NSCache *cachedLabels;
@end


@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _chatItems = [NSMutableArray array];
        _cachedLabels = [[NSCache alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGRect rectKeyboard;
	[[[aNotification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rectKeyboard];
    CGFloat keyboardHeight = rectKeyboard.size.height;
    CGRect frame = _chatInputView.frame;
    frame.origin.y = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(frame) - keyboardHeight;
    [_chatInputView setFrame:frame];
    
    _chatTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    CGRect frame = _chatInputView.frame;
    frame.origin.y = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(frame);
    [_chatInputView setFrame:frame];
    
    _chatTableView.contentInset = UIEdgeInsetsZero;
}

- (IBAction)onSendButtonPressed:(id)sender {
    NSString *text = _chatTextView.text;
    if ([text length])
    {
        [_chatItems addObject:text];
        _chatTextView.text = nil;
        
        NSArray *indexPaths = @[[NSIndexPath indexPathForRow:[_chatItems count] - 1
                                                   inSection:0]];
        
        
        [_chatTableView beginUpdates];
        [_chatTableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [_chatTableView endUpdates];
        
        [_chatTextView resignFirstResponder];
    }
}

- (CachedLabelInfo *)getCachedInfo:(NSIndexPath *)indexpath
{
    CachedLabelInfo *info = [_cachedLabels objectForKey:indexpath];
    if (info == nil)
    {
        NSString *text = [_chatItems objectAtIndex:[indexpath row]];
        M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
        [label setText:text];
        
        info = [[CachedLabelInfo alloc]init];
        info.cachedLabel = label;
        
        [_cachedLabels setObject:info
                          forKey:indexpath];

    }
    return info;
}

- (M80AttributedLabel *)labelFor: (NSIndexPath *)indexpath
{
    CachedLabelInfo *info = [self getCachedInfo:indexpath];
    return info.cachedLabel;
}

- (CGSize)labelSizeFor: (NSIndexPath *)indexpath
{
    CachedLabelInfo *info = [self getCachedInfo:indexpath];
    if (CGSizeEqualToSize(info.cachedSize, CGSizeZero))
    {
        info.cachedSize = [info.cachedLabel sizeThatFits:CGSizeMake(320, CGFLOAT_MAX)];
    }
    return info.cachedSize;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_chatItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  [self labelSizeFor:indexPath];
    M80AttributedLabel *label = [self labelFor:indexPath];
    [label setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    return size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chat_cell_identifier"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCell"
                                             owner:nil
                                            options:nil] lastObject];
    }
    [cell.attributedLabel removeFromSuperview];
    cell.attributedLabel = [self labelFor:indexPath];
    [cell addSubview:cell.attributedLabel];
    cell.attributedLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
