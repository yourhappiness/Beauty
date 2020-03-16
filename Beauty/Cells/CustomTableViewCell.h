//
//  CustomTableViewCell.h
//  Beauty
//
//  Created by Anastasia Romanova on 13/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *itemLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@end

NS_ASSUME_NONNULL_END
