//
//  Period.h
//  RPSchedule
//
//  Created by Ajeet Seenivasan on 4/16/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Period : NSObject

@property (strong, nonatomic)  NSString *periodName;
@property (strong, nonatomic)  NSString *periodNumber;
@property (strong, nonatomic)  NSString *startTime;
@property (strong, nonatomic)  NSString *endTime;
@property (strong, nonatomic)  NSString *roomNumber;

-(id)init;
-(id)initWithPeriod:(NSString*)pname periodNumber:(NSString*)pnumb startTime:(NSString*)stime endTime:(NSString*)etime roomNumber:(NSString*)rnumb;

@end
