//
//  MatchViewController.h
//  MatchedUp
//
//  Created by Matthew Bush on 9/27/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatchViewControllerDelegate <NSObject>

- (void)presentMatchesViewController;

@end
@interface MatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak) id <MatchViewControllerDelegate> delegate;

@end
