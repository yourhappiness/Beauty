//
//  Appointment.m
//  Beauty
//
//  Created by Anastasia Romanova on 27/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "Appointment.h"

@implementation Appointment

- (instancetype) initWithDate:(NSDate *)date andTime:(NSString *)time {
  self = [super init];
  if (self) {
    self.date = date;
    self.time = time;
  }
  return self;
}

@end
