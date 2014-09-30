//
//  ProfileViewViewController.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/22/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "ProfileViewViewController.h"

@interface ProfileViewViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLineLabel;

@end

@implementation ProfileViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFFile *pictureFile = self.photo[kPhotoPictureKey];
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
    }];
    
    PFUser *user = self.photo[kPhotoUserKey];
    self.locationLabel.text = user[kUserProfileKey][kUserProfileLocationKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kUserProfileKey][kUserProfileAgeKey]];
    
    if (user[kUserProfileKey][kUserProfileRelationshipStatusKey] == nil) {
        self.statusLabel.text = @"single";
    }
    else    {
        self.statusLabel.text = user[kUserProfileKey][kUserProfileRelationshipStatusKey];
    }
    self.tagLineLabel.text = user[kUserTagLineKey];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    self.title = user[kUserProfileKey][kUserProfileFirstNameKey];
}

#pragma mark - IBActions

- (IBAction)likeButtonPressed:(UIButton *)sender {
    [self.delegate didPressLike];
}

- (IBAction)dislikeButtonPressed:(id)sender {
    [self.delegate didPressDislike];
}

@end
