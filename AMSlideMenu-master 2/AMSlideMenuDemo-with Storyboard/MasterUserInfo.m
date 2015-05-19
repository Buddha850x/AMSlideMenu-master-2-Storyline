//
//  MasterUserInfo.m
//  RPSchedule
//
//  Created by Jacky Zou on 4/22/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "MasterUserInfo.h"

@implementation MasterUserInfo
@synthesize username,password,studentFullName,studentID;
-(id)init
{
    self = [super init];
    if(self)
    {
        username = @"";
        password = @"";
        studentFullName = @"";
        studentID = @"";

    }
    return self;
}

-(id)initPopulateUserInfo:(NSString *) uname password:(NSString *)pswd studentID:(NSString *)stuID studentFullName:(NSString *)stuFullName{
    self = [super init];
    if(self)
    {
        username = uname;
        password = pswd;
        studentFullName = stuID;
        studentID = stuFullName;
      
    }
    return self;
}





@end
