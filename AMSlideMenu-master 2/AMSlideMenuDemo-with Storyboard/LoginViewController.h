//
//  LoginViewController.h
//  AMSlideMenu
//
//  Created by Jacky Zou on 2/27/15.
//  Copyright (c) 2015 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ScheduleTable1ViewController.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)Login:(id)sender;
- (IBAction)signUp:(id)sender;
- (IBAction)Pop:(id)sender;


@property (strong, nonatomic) ScheduleTable1ViewController *scheduleView;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end
