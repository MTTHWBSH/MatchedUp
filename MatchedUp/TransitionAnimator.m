//
//  TransitionAnimator.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/29/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext

{
    
    return 0.25f;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext

{
    
    // Grab the from and to view controllers from the context
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect endFrame = fromViewController.view.bounds;
    
    if (self.presenting) {
        
        fromViewController.view.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:fromViewController.view];
        
        [transitionContext.containerView addSubview:toViewController.view];
        
        CGRect startFrame = endFrame;
        
        toViewController.view.alpha = 0.0;
        
        toViewController.view.frame = startFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            
            toViewController.view.frame = endFrame;
            
            toViewController.view.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    
    else {
        
        toViewController.view.userInteractionEnabled = YES;
        
        [transitionContext.containerView addSubview:toViewController.view];
        
        [transitionContext.containerView addSubview:fromViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            
            fromViewController.view.frame = endFrame;
            
            fromViewController.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    
}

@end
