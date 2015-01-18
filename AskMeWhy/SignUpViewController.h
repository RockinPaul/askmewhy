//
//  SignUpViewController.h
//  AskMeWhy
//
//  Created by Pavel on 18.01.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#ifndef AskMeWhy_SignUpViewController_h
#define AskMeWhy_SignUpViewController_h
#endif

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController

@property (nonatomic) IBOutlet UITextField *usernameTextField;
@property (nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)signUpButtonPressed:(UIButton *)sender;

@end


