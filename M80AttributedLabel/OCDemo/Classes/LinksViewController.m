//
//  LinksViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
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
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    NSString *text  = @"The game which I current play is hearthstone,and its website is www.hearthstone.com.cn";
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
    NSString *message = [NSString stringWithFormat:@"link data is %@:%@",[[linkData class] description],linkData];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"you click a link"
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [controller addAction:action];
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch view controller");
}
@end
