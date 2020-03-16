//
//  PortfolioCollectionViewCell.m
//  Beauty
//
//  Created by Anastasia Romanova on 21/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "PortfolioCollectionViewCell.h"
#import <UIKit/UIKit.h>

@interface PortfolioCollectionViewCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *itemImageView;

@end

@implementation PortfolioCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_itemImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.contentView.frame.size.width - 20 * 2, 1)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;
    [self.contentView addSubview:self.titleLabel];
  }
  return self;
}

- (void)configure {
    self.itemImageView.image = self.itemImage;
    self.titleLabel.text = self.title;
    [self setNeedsLayout];
}

- (void)prepareForReuse {
  self.titleLabel.text = nil;
  self.itemImageView.image = nil;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.titleLabel sizeToFit];
  self.titleLabel.frame = CGRectMake(self.contentView.frame.size.width / 2 - self.titleLabel.frame.size.width / 2, 5, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
}

@end
