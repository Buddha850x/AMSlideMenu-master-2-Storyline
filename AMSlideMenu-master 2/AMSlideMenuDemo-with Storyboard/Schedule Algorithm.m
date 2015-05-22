//
//  Schedule Algorithm.m
//  RPSchedule
//
//  Created by Abdallah Abdel-Raouf on 5/19/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "Schedule Algorithm.h"

@implementation Schedule_Algorithm

@synthesize longBand;

-(void)getYesterdayLast:(NSInteger)i
{
    longBand = i;
}

-(void)getnerateTodaySched
{
    NSMutableArray *sched = [[NSMutableArray alloc] init];
    NSInteger a;
    
    a = ((longBand+1)%7);
    [sched addObject:a];
    
    
    
}

@end
