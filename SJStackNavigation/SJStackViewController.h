//
//  StackViewController.h
//  Barks
//
//  Created by LeeSungJu on 2015. 7. 15..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJStackViewController : UIViewController
@property (nonatomic, assign) BOOL isNotSwipe;
@property (nonatomic, strong) UIViewController * rootViewController;
- (UIViewController*)getCurrentViewController;
- (void)addRootViewController:(UIViewController*)viewController;
- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated;
- (void)dismissViewControllerAnimated:(BOOL)animated;
@end
