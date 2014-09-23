//
//  EditProfileViewController.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/22/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {


    
}

@end
