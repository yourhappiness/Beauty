//
//  NotificationCenter.m
//  Beauty
//
//  Created by Anastasia Romanova on 28/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "NotificationCenter.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@interface NotificationCenter() <UNUserNotificationCenterDelegate>

@end

@implementation NotificationCenter

+ (instancetype)sharedInstance {
  static NotificationCenter *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[NotificationCenter alloc]init];
  });
  
  return instance;
}

- (void)registerService {
  if (@available(iOS 10.0, *)) {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError *_Nullable error) {
      if (!error) {
        NSLog(@"request authorization succeeded!");
      }
    }];
  } else {
    UIUserNotificationType *types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings;
    settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
  }
}

- (void)sendNotification:(Notification)notification {
  if (@available(iOS 10.0, *)) {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = notification.title;
    content.body = notification.body;
    content.sound = [UNNotificationSound defaultSound];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:notification.date];
    NSDateComponents *newComponents = [[NSDateComponents alloc]init];
    newComponents.calendar = calendar;
    newComponents.timeZone = [NSTimeZone defaultTimeZone];
    newComponents.month = components.month;
    newComponents.day = components.day;
    newComponents.hour = components.hour;
    newComponents.minute = components.minute;
    newComponents.second = components.second;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification" content:content trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
  } else {
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = notification.date;
    if (notification.title) {
      localNotification.alertBody = [NSString stringWithFormat:@"%@ - %@", notification.title, notification.body];
    } else {
      localNotification.alertBody = notification.body;
    }
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
  }
}

Notification NotificationMake(NSString*_Nullable title, NSString*_Nonnull body, NSDate*_Nonnull date) {
  Notification notification;
  notification.title = title;
  notification.body = body;
  notification.date = date;
  return notification;
}

@end
