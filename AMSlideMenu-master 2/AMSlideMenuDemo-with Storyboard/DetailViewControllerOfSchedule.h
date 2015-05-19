//
//  DetailViewController.h
//  GetTop10Albums
//
//  Created by Jacky Zou on 11/19/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewControllerOfSchedule : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *artwork;
@property (strong, nonatomic) IBOutlet UILabel *SongName;
@property (strong, nonatomic) IBOutlet UILabel *SongType;
@property (strong, nonatomic) IBOutlet UILabel *SongPrice;

@property (strong, nonatomic)  NSArray *DetailModal;
@property (strong, nonatomic)  NSArray *DetailModalForType;
@property (strong, nonatomic)  NSArray *DetailModalForPrice;
@property (strong, nonatomic)  NSArray *DetailModalForPicture;

@end

