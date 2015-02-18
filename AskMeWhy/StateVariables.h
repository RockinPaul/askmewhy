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

@interface StateVariables : NSObject

@property (nonatomic, readwrite) int signState; // 0 - sign in, 1 - sign up

+ (StateVariables *)sharedInstance;

@end
