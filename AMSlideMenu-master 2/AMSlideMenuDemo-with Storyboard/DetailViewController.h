//
//  DetailViewController.h
//  AMSlideMenu
//
//  Created by Jacky Zou on 11/10/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *ClassTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *DescripptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;

@property (strong, nonatomic)  NSArray *DetailModal;
@end