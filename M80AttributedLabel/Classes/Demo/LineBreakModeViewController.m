//
//  LineBreakModeViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "LineBreakModeViewController.h"
#import "M80AttributedLabel.h"

@interface LineBreakModeViewController ()

@end

@implementation LineBreakModeViewController

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
    kCTLineBreakByWordWrapping = 0,
    kCTLineBreakByCharWrapping = 1,
    kCTLineBreakByClipping = 2,
    kCTLineBreakByTruncatingHead = 3,
    kCTLineBreakByTruncatingTail = 4,
    kCTLineBreakByTruncatingMiddle = 5*/
    
    NSString *textMoreThanTwoLines = @"有关美国的一切，可以用一句话来描述：“Americans business is business”，这句话的意思就是说，那个国家永远是在经商热中，而且永远是一千度的白热。所以你要是看了前文之后以为那里有某种气氛会有助于人立志写作就错了。连我哥哥到了那里都后悔了，觉得不该学逻辑，应当学商科或者计算机。虽然他依旧未证出的逻辑定理，但是看到有钱人豪华的住房，也免不了唠叨几句他对妻儿的责任。";
    
    for (NSUInteger i = kCTLineBreakByWordWrapping;
         i <= kCTLineBreakByTruncatingMiddle;i++)
    {
        M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
        label.text = textMoreThanTwoLines;
        [label setLineBreakMode:i];
        [label setNumberOfLines:2];
        [label setFrame:CGRectMake(20, 20 + i * 60, 280, 40)];
        
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
