//
//  SignUpViewController.m
//  AskMeWhy
//
//  Created by Pavel on 18.01.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

-(void)signUpButtonPressed:(UIButton *)sender {
    
    NSLog(@"%@", [self.usernameTextField text]);
    NSLog(@"%@", [self.passwordTextField text]);
    NSLog(@"Sign Up button pressed");

    // User create
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"username"] = [self.usernameTextField text];
    user[@"password"] = [self.passwordTextField text];
    [user saveInBackground];
}

@end