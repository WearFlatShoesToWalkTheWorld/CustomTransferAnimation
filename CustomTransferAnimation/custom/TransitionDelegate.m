//
//  TransitionDelegate.m
//  testAnimation
//
//  Created by cheaterhu on 16/4/22.
//  Copyright © 2016年 hcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionDelegate.h"
#import "Animator.h"

@implementation TransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    Animator *animation = [[Animator alloc] init];
    animation.animationType = AnimationTypePresent;
    
    return animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    Animator *animation = [[Animator alloc] init];
    animation.animationType = AnimationTypeDismiss;
    
    return animation;
}
@end
