//
//  HomeViewController.m
//  
//
//  Created by Matthew Bush on 9/21/14.
//
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "TestUser.h"
#import "ProfileViewViewController.h"
#import "MatchViewController.h"

@interface HomeViewController () <MatchViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLineLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) PFObject *photo;
@property (strong, nonatomic) NSMutableArray *activites;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [TestUser saveTestUserToParse];
    
    self.likeButton.enabled = NO;
    self.dislikeButton.enabled = NO;
    self.infoButton.enabled = NO;
    
    self.currentPhotoIndex = 0;
    
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey notEqualTo:[PFUser currentUser]];
    [query includeKey:kPhotoUserKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.photos = objects;
            [self queryForCurrentPhotosIndex];
        } else  {
            NSLog(@"Error fetching photos");
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"homeToProfileSegue"]) {
        ProfileViewViewController *profileVC = segue.destinationViewController;
        profileVC.photo = self.photo;
    }
    else if ([segue.identifier isEqualToString:@"homeToMatchSegue"])    {
        MatchViewController *matchVC = segue.destinationViewController;
        matchVC.matchedUserImage = self.photoImageView.image;
        matchVC.delegate = self;
    }
}

#pragma mark - IBActions

- (IBAction)chatBarButtonItemPressed:(UIBarButtonItem *)sender {

}

- (IBAction)settingsBarButtonItemPressed:(UIBarButtonItem *)sender {

}

- (IBAction)likeButtonPressed:(UIButton *)sender {
    [self checkLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender {
    [self checkDislike];
}

- (IBAction)infoButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
    
}

#pragma mark - Helper Methods

- (void)queryForCurrentPhotosIndex
{
    if ([self.photos count] > 0) {
        self.photo = self.photos[self.currentPhotoIndex];
        PFFile *file = self.photo[kPhotoPictureKey];[file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.photoImageView.image = image;
                [self updateView];
            } else  {
                NSLog(@"Error getting photo file");
            }
        }];
        
        PFQuery *queryForLike = [PFQuery queryWithClassName:kActivityClassKey];
        [queryForLike whereKey:kActivityTypeKey equalTo:kActivityTypeLikeKey];
        [queryForLike whereKey:kActivityPhotoKey equalTo:self.photo];
        [queryForLike whereKey:kActivityFromUserKey equalTo:[PFUser currentUser]];
        
        PFQuery *queryForDislike = [PFQuery queryWithClassName:kActivityClassKey];
        [queryForDislike whereKey:kActivityTypeKey equalTo:kActivityTypeDislikeKey];
        [queryForDislike whereKey:kActivityPhotoKey equalTo:self.photo];
        [queryForDislike whereKey:kActivityFromUserKey equalTo:[PFUser currentUser]];
        
        PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
        
        [likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.activites = [objects mutableCopy];
                if ([self.activites count] == 0) {
                    self.isLikedByCurrentUser = NO;
                    self.isDislikedByCurrentUser = NO;
                } else {
                    PFObject *activity = self.activites[0];
                    if ([activity[kActivityTypeKey] isEqualToString:kActivityTypeLikeKey]) {
                        self.isLikedByCurrentUser = YES;
                        self.isDislikedByCurrentUser = NO;
                    }
                    else if ([activity[kActivityTypeKey] isEqualToString:kActivityTypeDislikeKey]) {
                        self.isLikedByCurrentUser = NO;
                        self.isDislikedByCurrentUser = YES;
                    }
                    else    {
                        // Some other activity
                    }
                }
                self.likeButton.enabled = YES;
                self.dislikeButton.enabled = YES;
                self.infoButton.enabled = YES;
            }
        }];
        
    };
}

- (void)updateView
{
    self.firstNameLabel.text = self.photo[kPhotoUserKey][kUserProfileKey][kUserProfileFirstNameKey];
    self.ageLabel = [NSString stringWithFormat:@"%@", self.photo[kPhotoUserKey][kUserProfileKey][kUserProfileAgeKey]];
    self.tagLineLabel.text = self.photo[kPhotoUserKey][kUserTagLineKey];
}

- (void)setupNextPhoto
{
    if (self.currentPhotoIndex + 1 < self.photos.count) {
        self.currentPhotoIndex ++;
        [self queryForCurrentPhotosIndex];
    } else  {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No more users to view" message:@"Check back later for more users" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)saveLike
{
    PFObject *likeActivity = [PFObject objectWithClassName:kActivityClassKey];
    [likeActivity setObject:kActivityTypeLikeKey forKey:kActivityTypeKey];
    [likeActivity setObject:[PFUser currentUser] forKey:kActivityFromUserKey];
    [likeActivity setObject:[self.photo objectForKey:kPhotoUserKey] forKey:kActivityToUserKey];
    [likeActivity setObject:self.photo forKey:kActivityPhotoKey];
    [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = YES;
        self.isDislikedByCurrentUser = NO;
        [self.activites addObject:likeActivity];
        [self checkForPhotoUserLikes];
        [self setupNextPhoto];
    }];
}

- (void)saveDislike
{
    PFObject *dislikeActivity = [PFObject objectWithClassName:kActivityClassKey];
    [dislikeActivity setObject:kActivityTypeDislikeKey forKey:kActivityTypeKey];
    [dislikeActivity setObject:[PFUser currentUser] forKey:kActivityFromUserKey];
    [dislikeActivity setObject:[self.photo objectForKey:kPhotoUserKey] forKey:kActivityToUserKey];
    [dislikeActivity setObject:self.photo forKey:kActivityPhotoKey];
    [dislikeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = NO;
        self.isDislikedByCurrentUser = YES;
        [self.activites addObject:dislikeActivity];
        [self setupNextPhoto];
    }];
}

- (void)checkLike
{
    if (self.isLikedByCurrentUser) {
        [self setupNextPhoto];
        return;
    }
    else if (self.isDislikedByCurrentUser)  {
        for (PFObject *activity in self.activites)  {
            [activity deleteInBackground];
        }
        [self.activites removeLastObject];
        [self saveLike];
    }
    else    {
        [self saveLike];
    }
}

- (void)checkDislike
{
    if (self.isDislikedByCurrentUser) {
        [self setupNextPhoto];
        return;
    }
    else if (self.isLikedByCurrentUser)  {
        for (PFObject *activity in self.activites)  {
            [activity deleteInBackground];
        }
        [self.activites removeLastObject];
        [self saveDislike];
    }
    else    {
        [self saveDislike];
    }
}

- (void)checkForPhotoUserLikes
{
    PFQuery *query = [PFQuery queryWithClassName:kActivityClassKey];
    [query whereKey:kActivityFromUserKey containedIn:self.photo[kPhotoUserKey]];
    [query whereKey:kActivityToUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kActivityTypeKey equalTo:kActivityTypeLikeKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            //create chatroom
            [self createChatRoom];
        }
    }];
}

- (void)createChatRoom
{
    // query for conversations
    PFQuery *queryForChatRoom = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoom whereKey:@"user1" equalTo:[PFUser currentUser]];
    [queryForChatRoom whereKey:@"user2" equalTo:self.photo[kPhotoUserKey]];
    
    // query for inverse conversations
    PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoomInverse whereKey:@"user1" equalTo:self.photo[kPhotoUserKey]];
    [queryForChatRoomInverse whereKey:@"user2" equalTo:[PFUser currentUser]];
    
    // combine queries
    PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
    
    // create chatroom object with both users
    [combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            PFObject *chatroom = [PFObject objectWithClassName:@"ChatRoom"];
            [chatroom setObject:[PFUser currentUser] forKey:@"user1"];
            [chatroom setObject:self.photo[kPhotoUserKey] forKey:@"user2"];
            [chatroom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self performSegueWithIdentifier:@"homeToMatchSegue" sender:nil];
            }];
        }
    }];
}

#pragma mark - MatchViewController Delegate

- (void)presentMatchesViewController
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
    }];
}

@end
