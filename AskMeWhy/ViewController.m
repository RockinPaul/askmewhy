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
    
    [self sendQuestion:content];
    
    NSLog(@"%@", content);
    NSLog(@"Ask button pressed");
}

// Create new question in Parse
- (void) sendQuestion:(NSString *)content {
    PFObject *question = [PFObject objectWithClassName:@"Question"];
    question[@"content"] = content;
    question[@"parent"] = @"Parent";
    [question saveInBackground];
}

@end
