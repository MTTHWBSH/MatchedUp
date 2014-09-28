//
//  EditProfileViewController.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/22/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
        }
    }];
    
    self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kUserTagLineKey];
}

#pragma mark - IBActions

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {

    [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kUserTagLineKey];
    [[PFUser currentUser] saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
