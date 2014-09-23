//
//  Constants.h
//  MatchedUp
//
//  Created by Matthew Bush on 9/20/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - User Class

extern NSString *const kUserTagLineKey;

extern NSString *const kUserProfileKey;
extern NSString *const kUserProfileNameKey;
extern NSString *const kUserProfileFirstNameKey;
extern NSString *const kUserProfileLocationKey;
extern NSString *const kUserProfileGenderKey;
extern NSString *const kUserProfileBirthdayKey;
extern NSString *const kUserProfileInterestedInKey;
extern NSString *const kUserProfilePictureURL;
extern NSString *const kUserProfileRelationshipStatusKey;
extern NSString *const kUserProfileAgeKey;


#pragma mark - Photo Class

extern NSString *const kPhotoClassKey;
extern NSString *const kPhotoUserKey;
extern NSString *const kPhotoPictureKey;

#pragma mark - Activity Class

extern NSString *const kActivityClassKey;
extern NSString *const kActivityTypeKey;
extern NSString *const kActivityFromUserKey;
extern NSString *const kActivityToUserKey;
extern NSString *const kActivityPhotoKey;
extern NSString *const kActivityTypeLikeKey;
extern NSString *const kActivityTypeDislikeKey;

@end
