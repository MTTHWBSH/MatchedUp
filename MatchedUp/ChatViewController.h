//
//  ChatViewController.h
//  MatchedUp
//
//  Created by Matthew Bush on 9/27/14.
//  Copyright (c) 2014 Matt Bush. All rights reserved.
//

#import "JSMessagesViewController.h"
#import <Parse/Parse.h>

@interface ChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatRoom;

@end
