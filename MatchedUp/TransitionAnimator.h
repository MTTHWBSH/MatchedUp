//
//  TransitionAnimator.h
//  MatchedUp
//
//  Created by Matthew Bush on 9/29/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

@end
