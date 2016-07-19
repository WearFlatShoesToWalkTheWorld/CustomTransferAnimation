//
//  Animator.m
//  testAnimation
//
//  Created by cheaterhu on 16/4/22.
//  Copyright © 2016年 hcd. All rights reserved.
//

#import "Animator.h"

@interface Animator ()
@property (strong, nonatomic) CABasicAnimation *revealAnimation;
@property (strong, nonatomic) CAShapeLayer    *shapeLayer;
@property (strong, nonatomic) id<UIViewControllerContextTransitioning>transitionContext;
@property (strong, nonatomic) UIViewController *fromVC;
@end
@implementation Animator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return  0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container  = transitionContext.containerView;
    
    self.transitionContext = transitionContext;
    //为了兼容iOS7
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromVC = fromVC;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    CGPoint startPoint = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y);
    
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithArcCenter:startPoint radius:1.0 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *toPath = [UIBezierPath bezierPathWithArcCenter:startPoint radius:sqrt([UIScreen mainScreen].bounds.size.width *[UIScreen mainScreen].bounds.size.width + [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].bounds.size.height) * 0.5 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    
    if (self.animationType == AnimationTypePresent) {
        [container addSubview:toVC.view];
        

        self.revealAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        
        self.shapeLayer.path = toPath.CGPath;
        
        self.revealAnimation.fromValue = (__bridge id )(fromPath.CGPath);
        self.revealAnimation.toValue = (__bridge id )(toPath.CGPath);
        
        self.revealAnimation.duration = [self transitionDuration:transitionContext];
        
        self.revealAnimation.delegate = self;
        
        [self.shapeLayer addAnimation:self.revealAnimation forKey:@"animation"];
        
        toVC.view.layer.mask = self.shapeLayer;
    
    }else if(self.animationType == AnimationTypeDismiss){
        
//        [container insertSubview:toVC.view belowSubview:fromVC.view];
//
//        self.revealAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//        
//        
//        self.shapeLayer.path = fromPath.CGPath;
//        
//        self.revealAnimation.fromValue = (__bridge id )(toPath.CGPath);
//        self.revealAnimation.toValue = (__bridge id )(fromPath.CGPath);
//        
//        self.revealAnimation.duration = [self transitionDuration:transitionContext];
//        
//        self.revealAnimation.delegate = self;
//        
//        [self.shapeLayer addAnimation:self.revealAnimation forKey:@"animation"];
//        
//        fromVC.view.layer.mask = self.shapeLayer;
        
        [container addSubview:toVC.view];
        
        toVC.view.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y - [UIApplication sharedApplication].keyWindow.bounds.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.frame = container.bounds;
        } completion:^(BOOL finished) {
//            [fromVC.view removeFromSuperview]; /![transitionContext transitionWasCancelled]
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer  = [CAShapeLayer layer];
    }
    return _shapeLayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        self.fromVC.view.layer.mask = nil;
        [self.fromVC.view removeFromSuperview];
        [self.transitionContext completeTransition:flag];
        self.revealAnimation = nil;
        self.shapeLayer = nil;
    }else{
        NSLog(@"=======================");
    }
}



@end