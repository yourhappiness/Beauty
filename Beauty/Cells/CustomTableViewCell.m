//
//  CustomTableViewCell.m
//  Beauty
//
//  Created by Anastasia Romanova on 13/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width / 2, 44.0)];
    self.itemLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.itemLabel];
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2 - 10, 44.0)];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLabel];
  }
  return self;
}

-(void)layoutSubviews {
  self.itemLabel.frame = CGRectMake(10, 0, self.bounds.size.width / 2, 44.0);
  self.priceLabel.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2 - 10, 44.0);
}

@end
