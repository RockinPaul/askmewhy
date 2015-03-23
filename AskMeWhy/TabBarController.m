//
//  TabBar.m
//  AskMeWhy
//
//  Created by Pavel on 01.03.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarController.h"

@implementation TabBarController

- (void) viewDidLoad {
    [self assignTabColors];
}

- (void)assignTabColors {
    self.view.tintColor = [UIColor colorWithRed:(39.0/255) green:(174.0/255) blue:(96.0/255) alpha:1.0];
}

@end