//
//  StackViewController.m
//  Barks
//
//  Created by LeeSungJu on 2015. 7. 15..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJStackViewController.h"

#define ORIGINX_SPACE 50

@implementation SJStackViewController
{
    NSMutableArray * stackArray;
    BOOL isAnmaition;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        stackArray = [NSMutableArray new];
        isAnmaition = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [self.view addGestureRecognizer:panGesture];
}

- (UIViewController*)getCurrentViewController
{
    if ([stackArray count] > 0) {
        return nil;
    }else{
        return [stackArray lastObject];
    }
    
}

- (void)addRootViewController:(UIViewController*)viewController
{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    [stackArray addObject:viewController];
    int count = (int)[stackArray count];
    CGRect viewFrame = viewController.view.frame;
    viewController.view.frame = CGRectMake(self.view.frame.size.width, viewFrame.origin.y, viewFrame.size.width - (count * ORIGINX_SPACE), viewFrame.size.height);
    [self.view addSubview:viewController.view];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(viewController.view.frame.origin.x - (count * ORIGINX_SPACE), 0, (count * ORIGINX_SPACE), viewController.view.frame.size.height)];
    [touchView setBackgroundColor:[UIColor clearColor]];
    [touchView addGestureRecognizer:tapGesture];
    [self.view addSubview:touchView];
    
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{
                                  [viewController.view setFrame:CGRectMake(viewFrame.origin.x + (count * ORIGINX_SPACE), 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
                                  [touchView setFrame:CGRectMake(viewController.view.frame.origin.x - (count * ORIGINX_SPACE), 0, (count * ORIGINX_SPACE), viewController.view.frame.size.height)];
                              } completion:^(BOOL finished) {
                              }];
    
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    UIViewController * viewCon = [stackArray lastObject];
    [UIView animateKeyframesWithDuration:0.2
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{
                                  [viewCon.view setFrame:CGRectMake(self.view.frame.size.width, 0, viewCon.view.frame.size.width, viewCon.view.frame.size.height)];
                              } completion:^(BOOL finished) {
                                  [self removeView:viewCon];
                              }];
}

- (void)removeView:(UIViewController*)viewCon
{
    [viewCon.view removeFromSuperview];
    viewCon.view = nil;
    [viewCon removeFromParentViewController];
    viewCon = nil;
    [stackArray removeLastObject];
}

- (void)handleSwipe:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint translation = [panGesture translationInView:self.view];
    CGPoint touchLoaction = [panGesture locationInView:self.view];
//    NSLog(@"touchLoaction %f : %f",touchLoaction.x, touchLoaction.y);
//    NSLog(@"translation %f : %f",translation.x, translation.y);
    
    if(touchLoaction.x > ([stackArray count] * ORIGINX_SPACE) && [stackArray count] > 0 && translation.x > 0){
        UIViewController * viewCon = [stackArray lastObject];
        NSLog(@"%f",viewCon.view.frame.origin.x + translation.x);
        [viewCon.view setFrame:CGRectMake(([stackArray count] * ORIGINX_SPACE)+ translation.x, viewCon.view.frame.origin.y, viewCon.view.frame.size.width, viewCon.view.frame.size.height)];
        if(panGesture.state == UIGestureRecognizerStateEnded){
            if(([stackArray count] * ORIGINX_SPACE) + translation.x > self.view.frame.size.width/3){
                [self dismissViewControllerAnimated:YES];
            }else{
                [viewCon.view setFrame:CGRectMake(([stackArray count] * ORIGINX_SPACE), viewCon.view.frame.origin.y, viewCon.view.frame.size.width, viewCon.view.frame.size.height)];
            }
        }
    }
}

- (void)tapEvent:(UITapGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:YES];
    [gesture.view removeFromSuperview];
}


@end
