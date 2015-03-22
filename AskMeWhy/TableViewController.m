//
//  TableViewController.m
//  AskMeWhy
//
//  Created by Pavel on 15.03.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewController.h"

@implementation TableViewController

- (void) viewDidLoad {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.tableView setSeparatorColor:[UIColor colorWithRed:126.0/255.0 green:211.0/255.0 blue:33.0/255.0 alpha:100.0]];
    
    [self getTableInfo];

}

- (void) getTableInfo {
    
    StateVariables *stateVars = [StateVariables sharedInstance];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    [query whereKey:@"parent" equalTo: stateVars.user];
    
    self.questionsArray = [[NSMutableArray alloc] init];
    self.dateArray = [[NSMutableArray alloc] init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            stateVars.hasItems = [query getFirstObject] != nil;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        NSDate *date;
        NSString *question;
        
        for (PFObject *obj in objects) {
            
            date = [obj valueForKey:@"createdAt"];
            question = [obj valueForKey:@"content"];
            
            
            [self.questionsArray addObject:question];
            [self.dateArray addObject:date];
        }
        NSLog(@"%@", [self.questionsArray description]);
        NSLog(@"%@", [self.dateArray description]);
        
        [self.tableView reloadData]; // for loading new data from arrays
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    } DEPRECATED
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"%lu", (unsigned long)[self.questionsArray count]);
    return [self.questionsArray count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.questionTextView setText: [self.questionsArray objectAtIndex:indexPath.row]];
    [self.answerTextView setText: @"Поле сдается"];
    
    NSLog(@"%ld", (long)indexPath.row);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // allocate the cell:
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        
        // create a background image for the cell:
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundView:bgView];
        [cell setIndentationWidth:0.0];
        
        // create a custom label:                                        x    y   width  height
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0, 4.0, 300.0, 30.0)];
        [nameLabel setTag:1];
        [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
        [nameLabel setTextColor:[UIColor colorWithRed:(100.0/255) green:(100.0/255) blue:(100.0/255) alpha:1.0]];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        
        // Date
        NSDate* date = [self.dateArray objectAtIndex:indexPath.row];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        
        NSString *stringFromDate = [formatter stringFromDate:date];
        [nameLabel setText:stringFromDate];
        // =========================================
        
        UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 9.0, 150.0, 80.0)];
        [questionLabel setTag:2];
        [questionLabel setBackgroundColor:[UIColor clearColor]];
        [questionLabel setFont:[UIFont fontWithName:@"Avenir" size: 12.0]];
        [questionLabel setTextColor:[UIColor colorWithRed:(100.0/255) green:(100.0/255) blue:(100.0/255) alpha:100.0]];
        [questionLabel setNumberOfLines: 2];
        
        NSString *cellValue = [self.questionsArray objectAtIndex:indexPath.row];
        [questionLabel setText: cellValue];
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(330.0, 25.0, 50.0, 30.0)];
        [countLabel setTag:3];
        [countLabel setBackgroundColor:[UIColor clearColor]];
        [countLabel setFont: [UIFont boldSystemFontOfSize:18.0]];
        [countLabel setTextColor:[UIColor colorWithRed:(39.0/255) green:(174.0/255) blue:(96.0/255) alpha:1.0]];
        
        // Count mock
        int i = 1;
        NSMutableString *countString = [NSMutableString stringWithString:@"+"];
        [countString appendString:[NSString stringWithFormat:@"%i", i]];
        [countLabel setText:countString];
        
        // custom views should be added as subviews of the cell's contentView:
        [cell.contentView addSubview:nameLabel];
        [cell.contentView addSubview:questionLabel];
        [cell.contentView addSubview:countLabel];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: indexPath {
    return 80.0;
}


// =============== Header and footer ====================
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 56.0; //49.0 for iOS 8
}

@end