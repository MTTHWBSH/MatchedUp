//
//  ProfileViewViewController.h
//  MatchedUp
//
//  Created by Matthew Bush on 9/22/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Constants.h"

@protocol ProfileViewControllerDelegate <NSObject>

- (void)didPressLike;
- (void)didPressDislike;

@end

@interface ProfileViewViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;
@property (weak, nonatomic) id <ProfileViewControllerDelegate> delegate;

@end
