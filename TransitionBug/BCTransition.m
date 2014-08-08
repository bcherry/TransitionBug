//
//  BCTransition.m
//  TransitionBug
//
//  Created by Ben Cherry on 8/8/14.
//  Copyright (c) 2014 Ben Cherry. All rights reserved.
//

#import "BCTransition.h"

@interface BCTransition ()

@property (nonatomic, assign) BOOL presenting;

@end

@implementation BCTransition

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presenting = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *fromView = [transitionContext respondsToSelector:@selector(viewForKey:)] ? [transitionContext viewForKey:UITransitionContextFromViewKey] : fromViewController.view;
    UIView *toView = [transitionContext respondsToSelector:@selector(viewForKey:)] ? [transitionContext viewForKey:UITransitionContextToViewKey] : toViewController.view;

    if (self.presenting) {
        [transitionContext.containerView addSubview:toView];
        [transitionContext.containerView addSubview:fromView];

        [toViewController beginAppearanceTransition:YES animated:YES];
        [fromViewController beginAppearanceTransition:NO animated:YES];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
            CGRect frame = fromView.frame;
            frame.origin.x = -frame.size.width;
            fromView.frame = frame;
        } completion:^(BOOL finished) {
            [toViewController endAppearanceTransition];
            [fromViewController endAppearanceTransition];
            [transitionContext completeTransition:finished];
        }];
    } else {
        [transitionContext.containerView addSubview:fromView];
        [transitionContext.containerView addSubview:toView];

        [toViewController beginAppearanceTransition:YES animated:YES];
        [fromViewController beginAppearanceTransition:NO animated:YES];
        CGRect frame = toView.frame;
        frame.origin.x = -frame.size.width;
        toView.frame = frame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
            CGRect frame = toView.frame;
            frame.origin.x = 0;
            toView.frame = frame;
        } completion:^(BOOL finished) {
            [toViewController endAppearanceTransition];
            [fromViewController endAppearanceTransition];
            [transitionContext completeTransition:finished];
        }];
    }
}


@end
