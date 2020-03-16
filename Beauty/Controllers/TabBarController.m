//
//  TabBarController.m
//  Beauty
//
//  Created by Anastasia Romanova on 21/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "TabBarController.h"
#import "PortfolioCollectionViewController.h"
#import "MainViewController.h"
#import "AppointmentsTableViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5.0;
    flowLayout.minimumInteritemSpacing = 3.0;
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 3) / 2 , (self.view.bounds.size.width - 3) / 2);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    

    PortfolioCollectionViewController *portfolioVC = [[PortfolioCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    portfolioVC.title = NSLocalizedString(@"portfolio", @"");
    portfolioVC.definesPresentationContext = YES;
    portfolioVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    UINavigationController *firstNavC = [[UINavigationController alloc] initWithRootViewController:portfolioVC];
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.title = NSLocalizedString(@"studio", @"");
    mainVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    
    AppointmentsTableViewController *appointmentsTableVC = [[AppointmentsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    appointmentsTableVC.title = NSLocalizedString(@"appointments", @"");
    appointmentsTableVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    UINavigationController *secondNavC = [[UINavigationController alloc]initWithRootViewController:appointmentsTableVC];
    
    self.viewControllers = @[firstNavC, mainVC, secondNavC];
    self.tabBar.tintColor = [UIColor lightGrayColor];
    self.selectedIndex = 1;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
