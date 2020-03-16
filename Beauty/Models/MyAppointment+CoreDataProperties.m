//
//  MyAppointment+CoreDataProperties.m
//  Beauty
//
//  Created by Anastasia Romanova on 26/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//
//

#import "MyAppointment+CoreDataProperties.h"

@implementation MyAppointment (CoreDataProperties)

+ (NSFetchRequest<MyAppointment *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MyAppointment"];
}

@dynamic date;
@dynamic time;

@end
