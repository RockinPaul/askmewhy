//
//  StateVariables.m
//  AskMeWhy
//
//  Created by Pavel on 19.02.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StateVariables.h"

@implementation StateVariables

+ (StateVariables *)sharedInstance {
    static dispatch_once_t onceToken;
    static StateVariables *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[StateVariables alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.signState = 0;
    }
    return self;
}

@end