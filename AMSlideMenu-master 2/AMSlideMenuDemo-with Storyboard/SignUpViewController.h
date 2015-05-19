//
//  SignUpViewController.h
//  AMSlideMenu
//
//  Created by Jacky Zou on 3/2/15.
//  Copyright (c) 2015 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *studentID;

- (IBAction)SignUpButton:(id)sender;
- (IBAction)ExitButton:(id)sender;

@end
