//
//  MyAppointment+CoreDataProperties.h
//  Beauty
//
//  Created by Anastasia Romanova on 26/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//
//

#import "MyAppointment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyAppointment (CoreDataProperties)

+ (NSFetchRequest<MyAppointment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
