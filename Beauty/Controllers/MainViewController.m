//
//  MainViewController.m
//  Beauty
//
//  Created by Anastasia Romanova on 05/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "MainViewController.h"
#import "CustomTableViewCell.h"
#import "LocationService.h"

@interface MainViewController () <MKMapViewDelegate, CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *firstLetterImageView;
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UISegmentedControl *menu;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *contactsLabel;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) MKPointAnnotation *annotation;
@property (nonatomic, strong) UIView *animationLetterView;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor cyanColor];
  
  //creating pricelist
  _prices = @[@[NSLocalizedString(@"manicure", @""), @"2000"], @[NSLocalizedString(@"pedicure", @""), @"3000"], @[NSLocalizedString(@"strengthening", @""), @"500"], @[NSLocalizedString(@"design", @""), @"500"]];
  
  //Adding imageView
  CGRect imageViewFrame = CGRectMake(100.0, 100.0, 80.0, 80.0);
  _firstLetterImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
  self.firstLetterImageView.image = [UIImage imageNamed:@"B-letter"];
  self.firstLetterImageView.backgroundColor = self.view.backgroundColor;
  [self.view addSubview:self.firstLetterImageView];
  self.firstLetterImageView.hidden = YES;
  
  //for animation
  _animationLetterView = [[UIView alloc]initWithFrame:imageViewFrame];
  self.animationLetterView.backgroundColor = self.view.backgroundColor;
  [self.view addSubview:self.animationLetterView];

  //Adding label
  CGFloat fontSize = 24.0;
  CGRect labelFrame = CGRectMake(CGRectGetMaxX(imageViewFrame), CGRectGetMaxY(imageViewFrame) - fontSize - 5, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(imageViewFrame), fontSize + 2);
  _mainTitleLabel = [[UILabel alloc] initWithFrame:labelFrame];
  self.mainTitleLabel.font = [UIFont systemFontOfSize:fontSize];
  self.mainTitleLabel.textColor = [UIColor blackColor];
  self.mainTitleLabel.textAlignment = NSTextAlignmentLeft;
  self.mainTitleLabel.text = @"eauty";
  [self.view addSubview:self.mainTitleLabel];
  self.mainTitleLabel.layer.opacity = 0;
  
  //Adding segmentedControl
  CGRect controlFrame = CGRectMake(60, CGRectGetMaxY(imageViewFrame) + 50, [UIScreen mainScreen].bounds.size.width - 60 * 2, 30.0);
  _menu = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"prices", @""),NSLocalizedString(@"contacts", @"")]];
  self.menu.frame = controlFrame;
  self.menu.tintColor = [UIColor darkGrayColor];
  self.menu.selectedSegmentIndex = 0;
  [self.view addSubview: self.menu];
  [self.menu addTarget: self action: @selector(menuItemWasChoosen) forControlEvents: UIControlEventValueChanged];
  self.menu.layer.opacity = 0;
  
  //Adding tableView
  CGRect tableViewFrame = CGRectMake(20, CGRectGetMaxY(controlFrame) + 20, [UIScreen mainScreen].bounds.size.width - 20 * 2, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(controlFrame) - 20 - 150);
  _pricesTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
  [self.view addSubview: self.pricesTableView];
  self.pricesTableView.backgroundColor = self.view.backgroundColor;
  self.pricesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.pricesTableView.dataSource = self;
  self.pricesTableView.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
  
  //Adding label with address
  CGRect maxContactsFrame = CGRectMake(40, CGRectGetMaxY(controlFrame) + 30, [UIScreen mainScreen].bounds.size.width - 40 * 2, 16);
  _contactsLabel = [[UILabel alloc] initWithFrame:maxContactsFrame];
  self.contactsLabel.font = [UIFont systemFontOfSize:16];
  self.contactsLabel.textColor = [UIColor blackColor];
  self.contactsLabel.textAlignment = NSTextAlignmentLeft;
  self.contactsLabel.numberOfLines = 0;
  self.contactsLabel.text = NSLocalizedString(@"address", @"");
  [self.contactsLabel sizeToFit];
  self.contactsLabel.hidden = true;
  [self.view addSubview:self.contactsLabel];
  
  //Adding map
  _locationService = [[LocationService alloc] init];
  CGRect mapFrame = CGRectMake(40, CGRectGetMaxY(self.contactsLabel.frame) + 30, [UIScreen mainScreen].bounds.size.width - 40 * 2, CGRectGetMaxY(self.contactsLabel.frame) - 30 * 2);
  _mapView = [[MKMapView alloc] initWithFrame:mapFrame];
  self.mapView.showsUserLocation = YES;
  self.mapView.delegate = self;
  
  [self.locationService locationFromAddress: @"улица Бутлерова, 12, Москва" withCompletion:^(CLLocation *location){
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 30000, 30000);
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.annotation = [[MKPointAnnotation alloc] init];
      self.annotation.title = NSLocalizedString(@"our studio", @"");
      self.annotation.coordinate = location.coordinate;
      
      [self.mapView setRegion:region animated:YES];
      [self.mapView addAnnotation:self.annotation];
    });
  }];

  self.mapView.hidden = true;
  [self.view addSubview:self.mapView];
  
  
  //Animation
  [self animate];
  
}

-(void)menuItemWasChoosen {
  if (self.menu.selectedSegmentIndex == 0) {
    self.pricesTableView.hidden = false;
    self.contactsLabel.hidden = true;
    self.mapView.hidden = true;
  } else if (self.menu.selectedSegmentIndex == 1) {
    self.contactsLabel.hidden = false;
    self.mapView.hidden = false;
    self.pricesTableView.hidden = true;
  }
}

//button on view for annotation
-(void)pressedInfoButton:(UIButton *)sender {
  NSLog(@"Нажата кнопка");
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  static NSString *identifier = @"MarkerIdentifier";
  MKAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
  if (!annotationView) {
    annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.canShowCallout = true;
    annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    
    if (annotation == self.annotation) {
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton addTarget:self action:@selector(pressedInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView = infoButton;
    }
  }
  annotationView.annotation = annotation;
  return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  self.annotation.subtitle = NSLocalizedString(@"street address", @"");
}

#pragma mark - TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.prices.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PriceCell"];
  if (!cell) {
    cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriceCell"];
  }
  cell.itemLabel.text = self.prices[indexPath.row][0];
  cell.priceLabel.text = self.prices[indexPath.row][1];
  cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
  return cell;
}

#pragma mark - Animation

-(void) animate {
  CAShapeLayer *layer = [CAShapeLayer layer];
  layer.lineCap = kCALineCapRound;
  layer.lineJoin = kCALineJoinBevel;
  layer.fillColor = [[UIColor clearColor] CGColor];
  layer.strokeColor = [[UIColor blackColor]CGColor];
  layer.lineWidth = 3;
  layer.affineTransform = CGAffineTransformMakeScale(0.63, 0.63);

  UIBezierPath *bodyPath = [[UIBezierPath alloc] init];
  [bodyPath moveToPoint:CGPointMake(15, 35)];
  [bodyPath addLineToPoint:CGPointMake(26, 24)];
  [bodyPath addLineToPoint:CGPointMake(43, 19)];
  [bodyPath addLineToPoint:CGPointMake(60, 19)];
  [bodyPath addLineToPoint:CGPointMake(74, 23)];
  [bodyPath addLineToPoint:CGPointMake(81, 31)];
  [bodyPath addLineToPoint:CGPointMake(83, 41)];
  [bodyPath addLineToPoint:CGPointMake(79, 49)];
  [bodyPath addLineToPoint:CGPointMake(61, 63)];
  [bodyPath addLineToPoint:CGPointMake(39, 75)];
  [bodyPath addLineToPoint:CGPointMake(83, 68)];
  [bodyPath addLineToPoint:CGPointMake(102, 69)];
  [bodyPath addLineToPoint:CGPointMake(112, 73)];
  [bodyPath addLineToPoint:CGPointMake(115, 80)];
  [bodyPath addLineToPoint:CGPointMake(115, 88)];
  [bodyPath addLineToPoint:CGPointMake(107, 100)];
  [bodyPath addLineToPoint:CGPointMake(82, 114)];
  [bodyPath addLineToPoint:CGPointMake(60, 120)];
  [bodyPath addLineToPoint:CGPointMake(46, 123)];
  [bodyPath addLineToPoint:CGPointMake(29, 122)];
  [bodyPath moveToPoint:CGPointMake(51, 122)];
  [bodyPath addLineToPoint:CGPointMake(48, 73)];
  [bodyPath addLineToPoint:CGPointMake(42, 5)];
  
  layer.path = bodyPath.CGPath;
  
  CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  pathAnimation.duration = 3;
  pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
  pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
  pathAnimation.autoreverses = NO;
  pathAnimation.delegate = self;
  [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

  [self.animationLetterView.layer addSublayer:layer];

}

#pragma mark - CAAnimationDelegate

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (flag) {
    [self.animationLetterView removeFromSuperview];
    self.firstLetterImageView.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
      self.mainTitleLabel.layer.opacity = 1;
    } completion: ^(BOOL finished){
      [UIView animateWithDuration:1.5 animations:^{
        self.menu.layer.opacity = 1;
        self.pricesTableView.layer.affineTransform = CGAffineTransformIdentity;
      }];
    }];
  }
}

@end
