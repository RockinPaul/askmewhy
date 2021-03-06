//
//  ViewController.h
//  AskMeWhy
//
//  Created by Pavel on 18.01.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) IBOutlet UIButton *questionsButton;
@property (nonatomic) IBOutlet UIButton *askButton;
@property (nonatomic) IBOutlet UITextView *askContent;

- (IBAction)questionsButtonPressed:(UIButton *)sender;
- (IBAction)askButtonPressed:(UIButton *)sender;

@end

