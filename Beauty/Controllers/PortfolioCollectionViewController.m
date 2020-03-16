//
//  PortfolioCollectionViewController.m
//  Beauty
//
//  Created by Anastasia Romanova on 21/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "PortfolioCollectionViewController.h"
#import "PortfolioCollectionViewCell.h"

@interface PortfolioCollectionViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *portfolio;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation PortfolioCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //creating portfolio
  _portfolio = @[@[NSLocalizedString(@"design", @""), [UIImage imageNamed:@"design1"]], @[NSLocalizedString(@"crackelure", @""), [UIImage imageNamed:@"crackelure"]], @[NSLocalizedString(@"french", @""), [UIImage imageNamed:@"french"]], @[NSLocalizedString(@"marble", @""), [UIImage imageNamed:@"marble1"]], @[NSLocalizedString(@"marble", @""), [UIImage imageNamed:@"marble2"]], @[NSLocalizedString(@"nude", @""), [UIImage imageNamed:@"nude1"]], @[NSLocalizedString(@"nude", @""), [UIImage imageNamed:@"nude2"]], @[NSLocalizedString(@"design", @""), [UIImage imageNamed:@"design2"]]];
  
  // Register cell classes
  [self.collectionView registerClass:[PortfolioCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
  
  //collectionView
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor cyanColor];
  
  //searchController
  _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchResultsUpdater = self;
  _searchArray = [[NSMutableArray alloc]init];
  self.navigationItem.searchController = self.searchController;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (self.searchController.isActive) {
    return self.searchArray.count;
  }
    return self.portfolio.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PortfolioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  if (self.searchController.isActive) {
    cell.title = self.searchArray[indexPath.item][0];
    cell.itemImage = self.searchArray[indexPath.item][1];
  } else {
    cell.title = self.portfolio[indexPath.item][0];
    cell.itemImage = self.portfolio[indexPath.item][1];
  }
  [cell configure];
  
  return cell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark <UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  if (searchController.searchBar.text) {
    [self.searchArray removeAllObjects];
    for (NSArray *item in self.portfolio) {
      NSString *title = item[0];
      if ([title.lowercaseString containsString:searchController.searchBar.text.lowercaseString]) {
        [self.searchArray addObject:item];
      }
    }
    [self.collectionView reloadData];
  }
}

@end
