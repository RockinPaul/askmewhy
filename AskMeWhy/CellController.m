//
//  CellController.m
//  AskMeWhy
//
//  Created by Pavel on 15.03.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellController.h"

@implementation CellController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)editButtonClicked:(id)sender
{
    _textField.userInteractionEnabled = YES;
    _editButton.hidden = YES;
    _deleteButton.hidden = YES;
    _acceptButton.hidden = NO;
    _cancelButton.hidden = NO;
}

- (IBAction)cancelButtonClicked:(id)sender
{
    _textField.userInteractionEnabled = NO;
    _editButton.hidden = NO;
    _deleteButton.hidden = NO;
    _acceptButton.hidden = YES;
    _cancelButton.hidden = YES;
}

- (IBAction)acceptButtonClicked:(id)sender
{
    _textField.userInteractionEnabled = NO;
    _editButton.hidden = NO;
    _deleteButton.hidden = NO;
    _acceptButton.hidden = YES;
    _cancelButton.hidden = YES;
    
    if([_delegate respondsToSelector:@selector(cellTextEditionAccepted)])
    {
        [_delegate performSelector:@selector(cellTextEditionAccepted)];
    }
}

@end
