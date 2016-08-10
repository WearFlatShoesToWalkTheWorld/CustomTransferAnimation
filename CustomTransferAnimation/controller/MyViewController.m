//
//  MyViewController.m
//  testAnimation
//
//  Created by cheaterhu on 16/4/22.
//  Copyright © 2016年 hcd. All rights reserved.
//

#import "MyViewController.h"
#import "TransitionDelegate.h"
#import "Animator.h"

@interface MyViewController ()<UINavigationControllerDelegate>
@property (strong, nonatomic) TransitionDelegate * transition;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentTransition;
@end

@implementation MyViewController

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //present 方式使用
    self.transitioningDelegate = self.transition;
    
    self.view.backgroundColor = [UIColor redColor];
    
    //dismiss
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.backgroundColor = [UIColor cyanColor];
    [dismissBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [dismissBtn setTitle:@"点我dismiss" forState:UIControlStateNormal];
    
    dismissBtn.frame = CGRectMake(0, 0, 120, 30);
    dismissBtn.center = self.view.center;
    
    [self.view addSubview:dismissBtn];
    
    //pop
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.backgroundColor = [UIColor cyanColor];
    [popBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [popBtn setTitle:@"点我pop" forState:UIControlStateNormal];
    
    popBtn.frame = CGRectMake(0, 0, 120, 30);
    popBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    
    [self.view addSubview:popBtn];
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:pan];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.delegate = self;
    
}

- (void)pan:(UIScreenEdgePanGestureRecognizer *)sender
{
    CGFloat progress = [sender translationInView:self.view].x / self.view.frame.size.width;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        [self.percentTransition updateInteractiveTransition:progress];
    }else if (sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateEnded){
        if (progress > 0.5) {
            [self.percentTransition finishInteractiveTransition];
        }else{
            [self.percentTransition cancelInteractiveTransition];
        }
        
        self.percentTransition = nil;
        
        [sender setTranslation:CGPointZero inView:self.view];
    }
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    if(operation == UINavigationControllerOperationPush){
        Animator *animator = [[Animator alloc] init];
        animator.animationType = AnimationTypePresent;
        return animator;
    }else if(operation == UINavigationControllerOperationPop){
        Animator *animator = [[Animator alloc] init];
        animator.animationType = AnimationTypeDismiss;
        return animator;
    }
    return nil;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    if(((Animator *)animationController).animationType == AnimationTypeDismiss){
        return self.percentTransition;
    }
    return  nil;
}

- (void)dismiss:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pop:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (TransitionDelegate *)transition
{
    if (!_transition) {
        _transition = [[TransitionDelegate alloc]init];
    }
    return _transition;
}

@end
