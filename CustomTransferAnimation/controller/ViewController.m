//
//  ViewController.m
//  testAnimation
//
//  Created by cheaterhu on 16/4/22.
//  Copyright © 2016年 hcd. All rights reserved.
//

#import "ViewController.h"

#import "MyViewController.h"
#import "Animator.h"


@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)present:(UIButton *)sender {
    [self presentViewController:[[MyViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)push:(UIButton *)sender {
    [self.navigationController pushViewController:[[MyViewController alloc] init] animated:YES];
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
@end
