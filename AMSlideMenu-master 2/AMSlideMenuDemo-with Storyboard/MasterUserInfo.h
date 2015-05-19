//
//  MasterUserInfo.h
//  RPSchedule
//
//  Created by Jacky Zou on 4/22/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasterUserInfo : NSObject

@property (strong, nonatomic)  NSString *username;
@property (strong, nonatomic)  NSString *password;
@property (strong, nonatomic)  NSString *studentID;
@property (strong, nonatomic)  NSString *studentFullName;

-(id)init;

-(id)initPopulateUserInfo:(NSString*)uname password:(NSString*)pswd studentID:(NSString*)stuID studentFullName:(NSString*)stuFullName;

@end
