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

- (void)signInButtonPressed:(UIButton *)sender {
    
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
    
    if ([[[self.signInButton titleLabel] text] isEqualToString: @"Sign In"]) {
        [self isUser:[self.usernameTextField text]];
    }
}

- (void)signUpButtonPressed:(UIButton *)sender {
    
    [self.signUpLabel setText:nil];
    [self.signUpButton setHidden:YES];
    [self.signInButton setTitle: @"Sign Up" forState: UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor colorWithRed:(39.0/255) green:(174.0/255) blue:(96.0/255) alpha:0.6 ]forState: UIControlStateNormal];
    [self.signInButton setBackgroundImage:[UIImage imageNamed:@"TextField"] forState:UIControlStateNormal];
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

// Search for user
- (BOOL) isUser:(NSString *)email {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"username" equalTo:[self.usernameTextField text]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    return NO;
}

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

// Dismiss on tap (have some questions)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField endEditing:YES];
    [self.passwordTextField endEditing:YES];
}
// ==================================================================================================================

@end