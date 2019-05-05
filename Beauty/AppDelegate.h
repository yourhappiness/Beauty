//
//  AppDelegate.h
//  Beauty
//
//  Created by Anastasia Romanova on 05/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

