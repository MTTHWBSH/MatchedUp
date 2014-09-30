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

@interface EditProfileViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    
    self.tagLineTextView.delegate = self;
    
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

#pragma mark - TextView Delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.tagLineTextView resignFirstResponder];
        [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kUserTagLineKey];
        [[PFUser currentUser] saveInBackground];
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    else    {
        return YES;
    }
}

@end
