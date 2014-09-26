//
//  Constants.m
//  MatchedUp
//
//  Created by Matthew Bush on 9/20/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - User Class

NSString *const kUserTagLineKey                     = @"tagLine";

NSString *const kUserProfileKey                     = @"profile";
NSString *const kUserProfileNameKey                 = @"name";
NSString *const kUserProfileFirstNameKey            = @"firstName";
NSString *const kUserProfileLocationKey             = @"location";
NSString *const kUserProfileGenderKey               = @"gender";
NSString *const kUserProfileBirthdayKey             = @"birthday";
NSString *const kUserProfileInterestedInKey         = @"interestedIn";
NSString *const kUserProfilePictureURL              = @"pictureURL";
NSString *const kUserProfileRelationshipStatusKey   = @"relationshipStatus";
NSString *const kUserProfileAgeKey                  = @"age";


#pragma mark - Photo Class

NSString *const kPhotoClassKey                      = @"Photo";
NSString *const kPhotoUserKey                       = @"user";
NSString *const kPhotoPictureKey                    = @"image";

#pragma mark - Activity Class

NSString *const kActivityClassKey                   = @"Activity";
NSString *const kActivityTypeKey                    = @"Type";
NSString *const kActivityFromUserKey                = @"fromUser";
NSString *const kActivityToUserKey                  = @"toUser";
NSString *const kActivityPhotoKey                   = @"photo";
NSString *const kActivityTypeLikeKey                = @"like";
NSString *const kActivityTypeDislikeKey             = @"dislike";

#pragma mark - Settings

NSString *const kMenEnabledKey                      = @"men";
NSString *const kWomenEnabledKey                    = @"women";
NSString *const kSingleEnabledKey                   = @"Single";
NSString *const kAgeMaxKey                          = @"age";

@end
