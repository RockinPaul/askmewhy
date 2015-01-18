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
    NSString *text = [self.askContent text];
    NSLog(@"%@", text);
    NSLog(@"Ask button pressed");
}
@end
