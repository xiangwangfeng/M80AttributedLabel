//
//  ViewController.m
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "M80AttributedLabel.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet M80AttributedLabel *attributedLabel;
- (IBAction)onRefreshButtonPressed:(id)sender;
- (IBAction)onResetButtonPressed:(id)sender;
- (void)resetLabelContent;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetLabelContent];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onRefreshButtonPressed:(id)sender
{
    [_attributedLabel setNeedsDisplay];
}

- (IBAction)onResetButtonPressed:(id)sender
{
    [self resetLabelContent];
}

- (void)resetLabelContent
{
    [_attributedLabel setText:nil];
    for (NSInteger i = 0; i < 100; i++)
    {
        int index = arc4random();
        switch (index % 5) {
            case 0:
                [_attributedLabel appendText:[NSString stringWithFormat:@"%d",i]];
                break;
            case 1:
                [_attributedLabel appendText:@" http://www.163.com "];
                break;
            case 2:
                [_attributedLabel appendImage:[UIImage imageNamed:@"emoji_0"]
                                      maxSize:CGSizeMake(15, 15)];
                break;
            case 3:
            {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"red"];
                [string setTextColor:[UIColor redColor]];
                [string setFont:[UIFont systemFontOfSize:15]];
                [_attributedLabel appendAttributedText:string];
            }
                break;
            case 4:
            {
                UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];

                [button setBounds:CGRectMake(0, 0, 80, 20)];
                [button setTitle:@"Test Button" forState:UIControlStateNormal];
                [_attributedLabel appendView:button];
            }
                break;
            default:
                break;
        }
    }
    CGSize size = [_attributedLabel sizeThatFits:CGSizeMake(300, 10000)];
    CGPoint center = _attributedLabel.center;
    [_attributedLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    _attributedLabel.center = center;

}
@end
