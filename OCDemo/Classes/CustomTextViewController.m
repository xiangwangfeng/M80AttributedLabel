//
//  CustomTextViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "CustomTextViewController.h"
#import "M80AttributedLabel.h"

@interface CustomTextViewController ()

@end

@implementation CustomTextViewController

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
    
    self.title = @"Custom Text";
    
    NSArray *fonts = @[[UIFont systemFontOfSize:12],[UIFont systemFontOfSize:13],[UIFont systemFontOfSize:17],[UIFont systemFontOfSize:25]];
    NSArray *colors= @[M80RGB(0x000000),M80RGB(0x0000FF),M80RGB(0x00FF00),M80RGB(0xFF0000)];
    
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    NSString *plainText = @"The release of iOS 7 brings a lot of new tools to the table for developers.";
    NSArray *components = [plainText componentsSeparatedByString:@" "];
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        NSInteger index = arc4random() % 4;
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        
        [label appendAttributedText:attributedText];
        [label appendText:@" "];
    }
    label.frame     = CGRectInset(self.view.bounds,20,20);
    
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
