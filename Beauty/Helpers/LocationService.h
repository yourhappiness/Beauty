//
//  LocationService.h
//  Beauty
//
//  Created by Anastasia Romanova on 19/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject

- (void)locationFromAddress:(NSString*)address withCompletion:(void(^)(CLLocation *location))completion;

@end

NS_ASSUME_NONNULL_END
