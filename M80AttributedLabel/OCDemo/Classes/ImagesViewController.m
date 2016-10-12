//
//  ImagesViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "ImagesViewController.h"
#import "M80AttributedLabel.h"

@interface ImagesViewController ()

@end

@implementation ImagesViewController

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
    label.lineSpacing = 5.0;
    
    [label appendImage:[UIImage imageNamed:@"avatar"
                        ] maxSize:CGSizeMake(40, 40)
                margin:UIEdgeInsetsZero
             alignment:M80ImageAlignmentBottom];
    
    NSString *text  = @"say:\n有人问一位登山家为什么要去登山——谁都知道登山这件事既危险，又没什么实际的好处。[haha][haha][haha][haha]他回答道：“因为那座山峰在那里。”我喜欢这个答案，因为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。[haha][haha][haha]它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。[haha][haha][haha]用热力学的角度来看，这是个反熵的现象，所发趋害避利肯定反熵。";
    NSArray *components = [text componentsSeparatedByString:@"[haha]"];
    NSUInteger count = [components count];
    for (NSUInteger i = 0; i < count; i++)
    {
        [label appendText:[components objectAtIndex:i]];
        if (i != count - 1)
        {
            [label appendImage:[UIImage imageNamed:@"haha"]
                       maxSize:CGSizeMake(15, 15)
                        margin:UIEdgeInsetsZero
                     alignment:M80ImageAlignmentCenter];
        }
    }
    
    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    
    [self.view addSubview:label];
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
