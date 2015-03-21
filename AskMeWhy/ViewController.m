//
//  ViewController.m
//  AskMeWhy
//
//  Created by Pavel on 18.01.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFObject *user = [PFObject objectWithClassName:@"User"];
    StateVariables *stateVars = [StateVariables sharedInstance];
    stateVars.user = user;
    
}

- (void)viewDidAppear:(BOOL)animated {
    CoreDataAccess *coreData = [CoreDataAccess sharedInstance];
    
    //[coreData deleteAllObjectsFromEntity:@"User"];
    //[coreData addUser];
    if (![coreData coreDataHasEntriesForEntityName:@"User"]) {
        [self presentViewController];
    }
}

- (void)presentViewController {
    UIStoryboard *storyboard = self.storyboard;
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) questionsButtonPressed:(UIButton *)sender {
    NSLog(@"Questions button pressed");
}

- (void) askButtonPressed:(UIButton *)sender {
    NSString *content = [self.askContent text];
    
    if ((![content length] == 0) && (![content isEqualToString:@"Write something..."])){
        [self sendQuestion:content];
    }
    
    NSLog(@"%@", content);
    NSLog(@"Ask button pressed");
}

// Create new question in Parse
- (void) sendQuestion:(NSString *)content {
    PFObject *question = [PFObject objectWithClassName:@"Question"];
    StateVariables *stateVars = [StateVariables sharedInstance];
    question[@"content"] = content;
    question[@"parent"] = stateVars.user;
    [question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.askContent setText:@"Write something..."];
    }];
}


// Move up the screen
//Declare a delegate, assign your textField to the delegate and then include these methods

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    if ([[textView text] isEqualToString:@"Write something..."]) {
        [textView setText:nil];
    }
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
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
    [self.askContent endEditing:YES];
}
// ==================================================================================================================

@end
