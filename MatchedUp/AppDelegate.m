//
//  AppDelegate.m
//  MatchedUp
//
//  Created by Matt Bush on 9/16/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Parse setApplicationId:@"3XRZzSTFgs2msmiLoH9PqI83Y40hpO5dBBdSiYoi"
                  clientKey:@"m21nETsk4clUiopZUnKg4yDdzRzeD2Jtdj6LncYv"];
    [PFFacebookUtils initializeFacebook];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:12/255.0 green:158/255.0 blue: 255/255.0 alpha:1.0], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0]}];
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // attempt to extract a token from the url
    return [PFFacebookUtils handleOpenURL:url];
}

@end
