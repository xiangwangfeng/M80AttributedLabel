//
//  LongTextViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 Netease. All rights reserved.
//

#import "LongTextViewController.h"
#import "M80AttributedLabel.h"



@interface LongTextViewController ()

@end

@implementation LongTextViewController

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
    
    self.title = @"Long Text";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.text = content;

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];
    
    CGSize labelSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 40, CGFLOAT_MAX)];
    [label setFrame:CGRectMake(20, 0, labelSize.width, labelSize.height)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), labelSize.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
