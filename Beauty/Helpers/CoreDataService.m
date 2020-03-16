//
//  CoreDataService.m
//  Beauty
//
//  Created by Anastasia Romanova on 26/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "CoreDataService.h"

@interface CoreDataService()

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataService

+ (instancetype)sharedInstance {
  static CoreDataService *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[CoreDataService alloc] init];
    [instance setup];
  });
  
  return instance;
}

- (void)setup {
  self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Beauty"];
  [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * description, NSError * error) {
    if (error != nil) {
      NSLog(@"Ошибка инициализации CoreData");
      abort();
    }
    self.managedObjectContext = self.persistentContainer.viewContext;
  }];
}

- (void)save {
  NSError *error;
  [self.managedObjectContext save:&error];
  if (error) {
    NSLog(@"%@", [error localizedDescription]);
  }
}

- (void)addAppointment:(Appointment *)appointment {
  MyAppointment *appnt = [NSEntityDescription insertNewObjectForEntityForName:@"MyAppointment" inManagedObjectContext:self.managedObjectContext];
  appnt.date = appointment.date;
  appnt.time = appointment.time;
  [self save];
}

- (NSArray*)appointments {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MyAppointment"];
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:true]];
  return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)removeAppointment:(MyAppointment*)appointment {
  [self.managedObjectContext deleteObject:appointment];
  [self save];
}


@end
