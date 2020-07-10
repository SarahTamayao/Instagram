//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Brian Sanchez on 7/8/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;


@end

NS_ASSUME_NONNULL_END
