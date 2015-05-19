//
//  TableCell.h
//  AMSlideMenu
//
//  Created by Jacky Zou on 11/6/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ClassLabel;
@property (strong, nonatomic) IBOutlet UILabel *RoomLabel;


@end
