//
//  Animator.h
//  testAnimation
//
//  Created by cheaterhu on 16/4/22.
//  Copyright © 2016年 hcd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType){
    AnimationTypePresent = 0, //push
    AnimationTypeDismiss,    //pop
};

@interface Animator : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic)AnimationType animationType;

@end
