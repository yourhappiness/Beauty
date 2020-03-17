//
//  CalendarViewController.m
//  Beauty
//
//  Created by Anastasia Romanova on 26/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "CalendarViewController.h"
#import "CoreDataService.h"
#import "Appointment.h"
#import "NotificationCenter.h"

@interface CalendarViewController ()

@property (nonatomic, strong) NSArray *availableDatesAndTime;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSString *selectedTime;
@property (nonatomic, strong) NSDateFormatter *dateFormatterDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatterTime;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonClick)];
  self.navigationItem.rightBarButtonItem = rightButton;
  
  NSMutableArray *availableDates = [[NSMutableArray alloc]init];
  _buttons = [[NSMutableArray alloc]init];
  
  self.dateFormatterDate = [[NSDateFormatter alloc]init];
  [self.dateFormatterDate setDateFormat:@"dd/MM/yyyy"];
  
  self.dateFormatterTime = [[NSDateFormatter alloc]init];
  [self.dateFormatterTime setDateFormat:@"HH:mm"];
  
  NSDate *firstDate = [NSDate date];
  [availableDates addObject:firstDate];
  NSDate *secondDate = [self.dateFormatterDate dateFromString:@"06/04/2020"];
  [availableDates addObject:secondDate];
  NSDate *thirdDate = [self.dateFormatterDate dateFromString:@"27/03/2020"];
  [availableDates addObject:thirdDate];
  NSDate *forthDate = [self.dateFormatterDate dateFromString:@"08/06/2020"];
  [availableDates addObject:forthDate];
  
  NSDate *twelve = [self.dateFormatterTime dateFromString:@"12:00"];
  NSDate *fifteen = [self.dateFormatterTime dateFromString:@"15:00"];
  NSDate *eighteen = [self.dateFormatterTime dateFromString:@"18:00"];
  
  _availableDatesAndTime = @[@[availableDates[0], twelve, fifteen, eighteen], @[availableDates[1], fifteen], @[availableDates[2], twelve, eighteen], @[availableDates[3], twelve]];;
  
  self.view.backgroundColor = [UIColor cyanColor];
  
  CGRect datePickerFrame = CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width - 20, 100);
  
  _datePicker = [[UIDatePicker alloc]initWithFrame:datePickerFrame];
  [self.datePicker setTimeZone:NSTimeZone.localTimeZone];
  [self.datePicker setDatePickerMode:UIDatePickerModeDate];
  [self.datePicker setMinimumDate:[NSDate date]];
  [self.datePicker addTarget:self action:@selector(dateChangedWith:) forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.datePicker];
  
  [self addButtonsForDate:self.datePicker.date];
}

- (void)dateChangedWith:(UIDatePicker *)datePicker {
  if (self.buttons.count > 0) {
    for (UIButton *button in self.buttons) {
      [button removeFromSuperview];
    }
  }
  [self addButtonsForDate:datePicker.date];
}

- (void)addButtonsForDate:(NSDate *)date {
  for (NSArray *value in self.availableDatesAndTime) {
    NSDateComponents *dateComponentsOfDatePicker = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSDateComponents *dateComponentsOfAppointmentDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:value[0]];
    if (dateComponentsOfDatePicker.year == dateComponentsOfAppointmentDate.year && dateComponentsOfDatePicker.month == dateComponentsOfAppointmentDate.month && dateComponentsOfAppointmentDate.day == dateComponentsOfDatePicker.day) {
      NSInteger count = value.count - 1;
      for (int i = 1; i <= count; i++) {
        CGRect buttonFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, 300 + 50 * i + 30 * (i - 1), 100, 30);
        UIButton *button = [[UIButton alloc]initWithFrame:buttonFrame];
        [button setTitle:[self.dateFormatterTime stringFromDate:value[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [self.view addSubview:button];
      }
    }
  }
}

- (void)clickOnButton:(UIButton *)sender {
  if (self.selectedTime) {
    for (UIButton* button in self.buttons) {
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
  }
  [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  self.selectedTime = sender.titleLabel.text;
}

- (void)saveButtonClick {
  if (self.selectedTime) {
    Appointment *appointment = [[Appointment alloc]initWithDate:self.datePicker.date andTime:self.selectedTime];
    [[CoreDataService sharedInstance] addAppointment:appointment];
    
    //current notification as example
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar componentsInTimeZone: ([NSTimeZone systemTimeZone]) fromDate:[NSDate date]];
    NSDateComponents *exampleComponents = [[NSDateComponents alloc]init];
    exampleComponents.calendar = calendar;
    exampleComponents.timeZone = [NSTimeZone defaultTimeZone];
    exampleComponents.year = components.year;
    exampleComponents.month = components.month;
    exampleComponents.day = components.day;
    exampleComponents.hour = components.hour;
    exampleComponents.minute = components.minute;
    exampleComponents.second = components.second + 8;
    NSDate *exampleDate = [calendar dateFromComponents:exampleComponents];
    
    NSString *exampleMessage = [NSString stringWithFormat:NSLocalizedString(@"appointment body", @""),[self.dateFormatterDate stringFromDate:self.datePicker.date], self.selectedTime];
    
    Notification exampleNotification = NotificationMake(NSLocalizedString(@"appointment title", @""), exampleMessage, exampleDate);
    [[NotificationCenter sharedInstance]sendNotification:exampleNotification];
    
    [self.navigationController popViewControllerAnimated:true];
  } else {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", @"") message:NSLocalizedString(@"need to choose time", @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"Close", @"") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:true completion:nil];
  }
}

@end
