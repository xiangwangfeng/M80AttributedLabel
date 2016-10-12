//
//  AttachmentViewController.m
//  M80AttributedLabel
//
//  Created by amao on 5/21/14.
//  Copyright (c) 2014 www.xiangwangfeng.com. All rights reserved.
//

#import "AttachmentViewController.h"
#import "M80AttributedLabel.h"

@interface AttachmentViewController ()
@end

@implementation AttachmentViewController

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
    
    for (NSInteger i = 0; i < 3; i++)
    {
        [label appendText:@"Click the icon to fire event"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setBounds:CGRectMake(0, 0, 30, 30)];
        [button setTag:i];
        [label appendView:button];
        
        [label appendText:@"\n\n\n"];
    }
    

    
    label.frame     = CGRectInset(self.view.bounds,20,20);
    [self.view addSubview:label];

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)buttonClicked:(id)sender
{
    NSString *message = [NSString stringWithFormat:@"button tag is %zd",[(UIButton *)sender tag]];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"you click a button"
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



@end
