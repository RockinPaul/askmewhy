//
//  TableViewController.h
//  AskMeWhy
//
//  Created by Pavel on 15.03.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#ifndef AskMeWhy_TableViewController_h
#define AskMeWhy_TableViewController_h

#endif

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "StateVariables.h"

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *questionsDictionary;

@end