
//
//  StoreCoreSchedule.m
//  RPSchedule
//
//  Created by Jacky Zou on 4/22/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "StoreCoreSchedule.h"

#import "Period.h"

@implementation StoreCoreSchedule

@synthesize periods;

-(id)initWithPeriods:(NSMutableArray *)p
{
    self = [super init];
    if(self)
    {
        periods = p;
    }
    return self;
}

@end
