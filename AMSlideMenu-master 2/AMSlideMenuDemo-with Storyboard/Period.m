//
//  Period.m
//  RPSchedule
//
//  Created by Ajeet Seenivasan on 4/16/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "Period.h"

@implementation Period

@synthesize periodName,periodNumber,startTime,endTime,roomNumber;

-(id)init
{
    self = [super init];
    if(self)
    {
        periodName = @"";
        periodNumber = @"";
        startTime = @"";
        endTime = @"";
        roomNumber= @"";
    }
    return self;
}

-(id)initWithPeriod:(NSString *)pname periodNumber:(NSString *)pnumb startTime:(NSString *)stime endTime:(NSString *)etime roomNumber:(NSString *)rnumb
{
    self = [super init];
    if(self)
    {
        periodName = pname;
        periodNumber = pnumb;
        startTime = stime;
        endTime = etime;
        roomNumber= rnumb;
    }
    return self;
}

@end
