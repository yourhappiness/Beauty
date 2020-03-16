//
//  LocationService.m
//  Beauty
//
//  Created by Anastasia Romanova on 19/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationService() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation LocationService

-(instancetype) init {
  self = [super init];
  if (self) {
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    [self.locationManager requestWhenInUseAuthorization];
  }
  return self;
}

-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
    [self.locationManager startUpdatingLocation];
  } else if (status != kCLAuthorizationStatusNotDetermined) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка!" message:@"Не удалось определить текущее местоположение" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
  }
}

- (void)locationFromAddress:(NSString*)address withCompletion:(void(^)(CLLocation *location))completion {
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    if ([placemarks count] > 0) {
      for (MKPlacemark *place in placemarks) {
        completion(place.location);
      }
    } else {
      NSLog(@"%@", error.description);
    }
  }];
}


-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
  CLLocation *location = [locations firstObject];
  if (location) {
    NSLog(@"%@", location);
  }
}

@end
