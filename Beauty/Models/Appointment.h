//
//  Appointment.h
//  Beauty
//
//  Created by Anastasia Romanova on 27/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Appointment : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *time;

- (instancetype) initWithDate:(NSDate *)date andTime:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
