//
//  CoreDataAccess.h
//  AskMeWhy
//
//  Created by Pavel on 24.02.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#ifndef AskMeWhy_CoreDataAccess_h
#define AskMeWhy_CoreDataAccess_h

#endif

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CoreDataAccess : NSObject

@property (nonatomic, strong) CoreDataAccess *coreData;
+ (CoreDataAccess *) sharedInstance;

- (void) addUser;
- (NSString *) getObjectId;
- (void) printEntityContent: (NSString *) entityName forKey:(NSString *) keyName;
- (void) searchItemFromEntity:(NSString *) entity ForName:(NSString *) name;
- (BOOL) coreDataHasEntriesForEntityName:(NSString *) entityName;
- (void) deleteAllObjectsFromEntity: (NSString *) entityName;

@end
