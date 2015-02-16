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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)signUpButtonPressed:(UIButton *)sender {
    
    NSLog(@"%@", [self.usernameTextField text]);
    NSLog(@"%@", [self.passwordTextField text]);
    NSLog(@"Sign Up button pressed");

    NSString *validatorVariable = [self.usernameTextField text];
    
    if ([self NSStringIsValidEmail:validatorVariable]) {
        // User create
        PFObject *user = [PFObject objectWithClassName:@"User"];
        user[@"username"] = [self.usernameTextField text];
        user[@"password"] = [self.passwordTextField text];
    
        [user saveInBackground];
        
        NSLog(@"Success!");
    } else {
        NSLog(@"Invalid email!");
    }
    // Do segue
    //[self performSegueWithIdentifier: @"showMain" sender: self];
}

// Email validation
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
// ==================================================================================================================

// Dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // done button was pressed - dismiss keyboard
    [textField resignFirstResponder];
    return YES;
}
// ==================================================================================================================

// Clear and turn back default text in text fields
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setText:@""];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (![textField hasText]) {
        if ([[textField restorationIdentifier]  isEqual: @"user"]) {
            [textField setText: @"Username"];
        }
        if ([[textField restorationIdentifier]  isEqual: @"pass"]) {
            [textField setText: @"Password"];
        }
    }
}

// ==================================================================================================================

// Move up the screen
//Declare a delegate, assign your textField to the delegate and then include these methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
}

// ==================================================================================================================

@end