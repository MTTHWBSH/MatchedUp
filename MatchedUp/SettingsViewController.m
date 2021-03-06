//
//  SettingsViewController.m
//  
//
//  Created by Matthew Bush on 9/21/14.
//
//

#import "SettingsViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UISwitch *menSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *womenSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *singleSwitch;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kAgeMaxKey];
    self.menSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kMenEnabledKey];
    self.womenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kWomenEnabledKey];
    self.singleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kSingleEnabledKey];
    
    [self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.menSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.womenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.singleSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)logoutButtonPressed:(UIButton *)sender {

    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)editProfileButtonPressed:(UIButton *)sender {

}

#pragma mark - Helper

- (void)valueChanged:(id)sender
{
    if (sender == self.ageSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:(int)self.ageSlider.value forKey:kAgeMaxKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
    }
    else if  (sender == self.menSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.menSwitch.isOn forKey:kMenEnabledKey];
    }
    else if (sender == self.womenSwitch)    {
        [[NSUserDefaults standardUserDefaults] setBool:self.womenSwitch.isOn forKey:kWomenEnabledKey];
    }
    else if (sender == self.singleSwitch)   {
        [[NSUserDefaults standardUserDefaults] setBool:self.singleSwitch.isOn forKey:kSingleEnabledKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
