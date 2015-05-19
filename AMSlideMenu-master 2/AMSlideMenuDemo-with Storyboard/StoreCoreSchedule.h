//
//  StoreCoreSchedule.h
//  RPSchedule
//
//  Created by Jacky Zou on 4/22/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreCoreSchedule : NSObject

-(id)initWithPeriods:(NSMutableArray*)p;

@property (strong,nonatomic) NSMutableArray *periods;

@end
