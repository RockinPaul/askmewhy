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

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) id currentResponder; // current responder

@property (nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) IBOutlet UITextField *usernameTextField;
@property (nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) IBOutlet UIButton *signInButton;
@property (nonatomic) IBOutlet UILabel *signUpLabel;
@property (nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction) signInButtonPressed:(UIButton *)sender;
- (IBAction) signUpButtonPressed:(UIButton *)sender;

- (BOOL) NSStringIsValidEmail:(NSString *)checkString;
- (BOOL) isUser:(NSString *)email;

@end


