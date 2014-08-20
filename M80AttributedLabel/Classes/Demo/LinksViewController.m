//
//  LinksViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 Netease. All rights reserved.
//

#import "LinksViewController.h"
#import "M80AttributedLabel.h"


@interface LinksViewController ()<M80AttributedLabelDelegate>

@end

@implementation LinksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //使用自定义的链接检测方法
    /*
    [M80AttributedLabel setCustomDetectMethod:^NSArray *(NSString *text) {
        NSMutableArray *links = [NSMutableArray array];
        return links;
    }];*/
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    //todo 这个变粗貌似除了改字体别无他法了？PO主帮忙看一下？
    NSString *text  = @"😌中文变粗了 The game which I current play is hearthstone,and its website is www.hearthstone.com.cnccc";   //使用新正则，识别出   www.hearthstone.com.cn 旧的正则 识别出的是   www.hearthstone.com.cnccc
    NSRange range   = [text rangeOfString:@"hearthstone"];
    label.text      = text;
    [label addCustomLink:[NSValue valueWithRange:range]
                forRange:range];
    label.delegate = self;
    
    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    
    [self.view addSubview:label];

}

- (void)m80AttributedLabel:(M80AttributedLabel *)label
             clickedOnLink:(id)linkData
{
    NSString *message = [NSString stringWithFormat:@"LinkData is %@:%@",[[linkData class] description],linkData];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"U click a link"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
    [alert show];
}


- (void)m80AttributedLabel:(M80AttributedLabel *)label longPressOnLink:(id)linkData
{
    NSString *message = [NSString stringWithFormat:@"LinkData is %@:%@",[[linkData class] description],linkData];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"U LongPress a link"
            message:message
            delegate:nil
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil, nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
