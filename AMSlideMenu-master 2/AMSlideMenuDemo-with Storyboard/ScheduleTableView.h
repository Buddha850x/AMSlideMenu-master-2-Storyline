//
//  ScheduleTableView.h
//  AMSlideMenu
//
//  Created by Jacky Zou on 11/12/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableView:UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *cells;


@property (strong, nonatomic) IBOutlet UILabel *YearMonth;
@property (strong, nonatomic) IBOutlet UILabel *DayLabel;

@end
