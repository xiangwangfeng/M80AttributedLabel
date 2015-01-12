//
//  TextAlignmentViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "TextAlignmentViewController.h"
#import "M80AttributedLabel.h"

@interface TextAlignmentViewController ()

@end

@implementation TextAlignmentViewController

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
    
    /*
    kCTTextAlignmentLeft = 0,
    kCTTextAlignmentRight = 1,
    kCTTextAlignmentCenter = 2,
    kCTTextAlignmentJustified = 3,
    kCTTextAlignmentNatural = 4,*/
    
    
    NSString *text = @"Hello M80AttributedLabel";

    for (NSUInteger i = kCTTextAlignmentLeft;
         i <= kCTTextAlignmentNatural;i++)
    {
        M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
        label.text = text;
        [label setTextAlignment:i];
        [label setFrame:CGRectMake(20, 20 + i * 60, 280, 25)];
        
        [label.layer setBorderColor:[UIColor orangeColor].CGColor];
        [label.layer setBorderWidth:1];
        
        [self.view addSubview:label];
        
        
    }

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
