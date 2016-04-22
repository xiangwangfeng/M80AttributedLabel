//
//  BasicAttributedLabelViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "BasicAttributedLabelViewController.h"
#import "M80AttributedLabel.h"

@interface BasicAttributedLabelViewController ()

@end

@implementation BasicAttributedLabelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    
    label.text      = @"Hello M80AttributedLabel";
    label.font      = [UIFont fontWithName:@"Zapfino" size:25];
    label.textColor = UIColorFromRGB(0xFF9F00);
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset= CGSizeMake(1, 1);
    label.shadowBlur = 1;
    
    label.frame     = CGRectInset(self.view.bounds,20,20);

    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
