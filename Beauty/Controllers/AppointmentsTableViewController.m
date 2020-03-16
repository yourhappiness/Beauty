//
//  AppointmentsTableViewController.m
//  Beauty
//
//  Created by Anastasia Romanova on 26/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "AppointmentsTableViewController.h"
#import "CalendarViewController.h"
#import "CoreDataService.h"

@interface AppointmentsTableViewController ()

@property (nonatomic, strong) NSMutableArray *appointments;

@end

@implementation AppointmentsTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.backgroundColor = [UIColor cyanColor];
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClick)];
  self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewWillAppear:(BOOL)animated {
  self.appointments = [[NSMutableArray alloc] initWithArray:[[CoreDataService sharedInstance] appointments]];
  [self.tableView reloadData];
}

- (void)rightButtonClick {
  CalendarViewController *calendarVC = [[CalendarViewController alloc]init];
  [self.navigationController pushViewController:calendarVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appointments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Cell"];
  }
  MyAppointment *appointment = self.appointments[indexPath.row];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"dd/MM/yyyy"];
  cell.textLabel.text = [formatter stringFromDate:appointment.date];
  cell.detailTextLabel.text = appointment.time;
  cell.backgroundColor = tableView.backgroundColor;
  return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      MyAppointment *appointment = self.appointments[indexPath.row];
      [[CoreDataService sharedInstance] removeAppointment:appointment];
      [self.appointments removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
