//
//  MatchViewController.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/27/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "MatchViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface MatchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *matchedUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentUserImageView;
@property (weak, nonatomic) IBOutlet UIButton *viewChatsButton;
@property (weak, nonatomic) IBOutlet UIButton *keepSearchingButton;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.currentUserImageView.image = [UIImage imageWithData:data];
                self.matchedUserImageView.image = self.matchedUserImage;
            }];
        }
    }];
}

#pragma mark - IBActions

- (IBAction)viewChatsButtonPressed:(UIButton *)sender {
    [self.delegate presentMatchesViewController];
}

- (IBAction)keepSearchingButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
