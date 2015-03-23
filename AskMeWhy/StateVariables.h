//
//  StateVariables.h
//  AskMeWhy
//
//  Created by Pavel on 18.02.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#ifndef AskMeWhy_StateVariables_h
#define AskMeWhy_StateVariables_h

#endif

#import <Parse/Parse.h>

@interface StateVariables : NSObject

@property (nonatomic, readwrite) int signState; // 0 - sign in, 1 - sign up
@property (nonatomic) SEL selector; // for fucking callback!
@property (nonatomic) BOOL hasItems; // YES = Parse database has searching item, NO - ... you'll guess it
@property (nonatomic) long rowNo; // number of cell in tableView

// Parse one-to-many features
@property (nonatomic) NSString *email; // for CoreData in one-to-many Parse relationship
@property (nonatomic) NSString *objectId;
@property (nonatomic) PFObject *user; // for one-to-many relationship

+ (StateVariables *)sharedInstance;

@end
