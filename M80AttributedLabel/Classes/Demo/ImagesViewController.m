//
//  ImagesViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 Netease. All rights reserved.
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
    
    NSString *text  = @"Your[haha] Magic[haha] is Mine~~~~~";
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
