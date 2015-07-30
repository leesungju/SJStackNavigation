//
//  BASubViewController.m
//  Barks
//
//  Created by LeeSungJu on 2015. 7. 15..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJSubViewController.h"
#import "AppDelegate.h"
#import "SJSub2ViewController.h"

@implementation SJSubViewController
- (instancetype)init
{
    self = [super init];
    if(self){
        [self.view setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton * imgButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 26, 26)];
    [imgButton setBackgroundColor:[UIColor orangeColor]];
    [imgButton addTarget:self action:@selector(imgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgButton];
}

- (void)imgButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.stackView pushViewController:[SJSub2ViewController new] animated:YES];
}
@end
