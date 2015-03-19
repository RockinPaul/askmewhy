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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 6;
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
        [cell setBackgroundColor:[UIColor greenColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundView:bgView];
        [cell setIndentationWidth:0.0];
        
        // create a custom label:                                        x    y   width  height
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0, 300.0, 30.0)];
        [nameLabel setTag:1];
        [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
        [nameLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [nameLabel setText:@"Ololo"];
        // custom views should be added as subviews of the cell's contentView:
        [cell.contentView addSubview:nameLabel];
    }
    
//    // Configure the cell:
//    ((UIImageView *)cell.backgroundView).image = [UIImage imageNamed:@"awardbg.png"];
//    [(UILabel *)[cell.contentView viewWithTag:1] setText:[data1 objectAtIndex:indexPath.row]];
//    
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
    return 0.0;
}

@end