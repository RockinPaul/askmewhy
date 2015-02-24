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
    
    //[coreData deleteAllObjectsFromEntity:@"User"];
}

- (void)viewDidAppear:(BOOL)animated {
//    animated = NO;
//    CoreDataAccess *coreData = [CoreDataAccess sharedInstance];
//    [coreData addUser];
//    
//    if ([coreData coreDataHasEntriesForEntityName:@"User"]) {
//        [self presentViewController];
//    }
}

- (void)presentViewController {
    UIStoryboard *storyboard = self.storyboard;
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    // Configure the new view controller here.
    
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)signInButtonPressed:(UIButton *)sender {
    
    StateVariables *stateVars = [StateVariables sharedInstance];
    stateVars.selector = @selector(onResponseReceived);
    
    NSLog(@"%@", [self.usernameTextField text]);
    NSLog(@"%@", [self.passwordTextField text]);
    NSLog(@"Sign Up button pressed");

    NSString *validatorVariable = [self.usernameTextField text];
    
    if ([self NSStringIsValidEmail:validatorVariable]) {
        // User create
        [self isUser:validatorVariable theSelector:stateVars.selector];
    } else {
        NSLog(@"Invalid email!");
    }
}

- (void)onResponseReceived {
    StateVariables *stateVars = [StateVariables sharedInstance];
    NSLog(@"%i stateVar BOOL -----", stateVars.hasItems);
}

- (void)signUpButtonPressed:(UIButton *)sender {
    
    StateVariables *stateVars = [StateVariables sharedInstance];
    
    [self.signUpLabel setText:nil];
    [self.signUpButton setHidden:YES];
    [self.signInButton setTitle: @"Sign Up" forState: UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor colorWithRed:(39.0/255) green:(174.0/255) blue:(96.0/255) alpha:0.6 ]forState: UIControlStateNormal];
    [self.signInButton setBackgroundImage:[UIImage imageNamed:@"TextField"] forState:UIControlStateNormal];
    
    stateVars.signState = 1; // sign up
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
- (BOOL) isUser:(NSString *)email theSelector:(SEL)theSelector{
    
    StateVariables *stateVars = [StateVariables sharedInstance];
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"username" equalTo:email];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            stateVars.hasItems = [query getFirstObject] != nil;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        NSLog(@"%i stateVar BOOL", stateVars.hasItems);
        
        if (stateVars.hasItems) {
            if (stateVars.signState == 0) {
                NSLog(@"Ok, let's check password...");
                [query whereKey:@"password" equalTo:[[self passwordTextField] text]];
                if ([query getFirstObject] != nil) {
                    NSLog(@"You are alive");
                }
            } else {
                NSLog(@"User is already exists");
            }
        } else {
            if (stateVars.signState == 0) {
                NSLog(@"Email is does not registred");
            } else {
                PFObject *user = [PFObject objectWithClassName:@"User"];
                user[@"username"] = [self.usernameTextField text];
                user[@"password"] = [self.passwordTextField text];
                
                [user saveInBackground];
                
                NSLog(@"User created");
            }
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