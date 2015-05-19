//
//  SecondStepVerificationViewController.m
//  RPSchedule
//
//  Created by Jacky Zou on 5/13/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "SecondStepVerificationViewController.h"

@interface SecondStepVerificationViewController ()

@end

@implementation SecondStepVerificationViewController

@synthesize theCode;

//BOOL shouldLogin1 = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([self.theCode.text isEqual: @"abc12345"])
    {
   //     shouldLogin1=true;
        [self performSegueWithIdentifier:@"successVerfify" sender:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
