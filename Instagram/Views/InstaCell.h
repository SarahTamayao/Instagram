//
//  InstaCell.h
//  Instagram
//
//  Created by Brian Sanchez on 7/7/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@protocol InstaCellDelegate;

@interface InstaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postimageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (nonatomic, weak) id<InstaCellDelegate> delegate;

- (void)setPost:(Post *)post;

@end

@protocol InstaCellDelegate

- (void)postCell:(InstaCell *) instaCell didTap:(PFUser *)user;

@end

NS_ASSUME_NONNULL_END
