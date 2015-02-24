//
//  CoreDataAccess.m
//  AskMeWhy
//
//  Created by Pavel on 24.02.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataAccess.h"

@implementation CoreDataAccess

static  CoreDataAccess *coreData = nil;

- (void) addUser {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSManagedObject *newUser = [[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    [newUser setValue: @YES forKey:@"exists"];
    
    NSError *error;
    [context save:&error];
    NSLog(@"User added!");
}

- (BOOL) coreDataHasEntriesForEntityName:(NSString *)entityName {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    if(entity)
    {
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Fetch error: %@", error);
            abort();
        }
        if ([results count] == 0) {
            NSLog(@"NO!");
            return NO;
        }
        NSLog(@"Yeah!");
        return YES;
    }
    return NO;
}

- (void) deleteAllObjectsFromEntity: (NSString *) entityName {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *allObjects = [[NSFetchRequest alloc] init];
    [allObjects setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [allObjects setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:allObjects error:&error];
    //error handling goes here
    for (NSManagedObject *obj in objects) {
        [context deleteObject:obj];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    //more error handling here
    
    NSLog(@"All enteries are deleted!");
}

+(CoreDataAccess *) sharedInstance {
    static dispatch_once_t pred;
    static CoreDataAccess *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[CoreDataAccess alloc] init];
    });
    return sharedInstance;
}

- (void)dealloc {
    // implement -dealloc & remove abort() when refactoring for
    // non-singleton use.
    abort();
}

@end
