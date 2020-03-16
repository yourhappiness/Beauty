//
//  PortfolioCollectionViewCell.h
//  Beauty
//
//  Created by Anastasia Romanova on 21/05/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PortfolioCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *itemImage;

- (void)configure;

@end

NS_ASSUME_NONNULL_END
