//
//  InstaCell.m
//  Instagram
//
//  Created by Brian Sanchez on 7/7/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import "InstaCell.h"
#import "DateTools.h"

@implementation InstaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.captionLabel.text = post[@"caption"];
    PFUser *user = post[@"author"];
    self.usernameLabel.text = user.username;
    NSDate *date = [post updatedAt];
    self.dateLabel.text = date.timeAgoSinceNow;
    NSLog(@"%@", date);
    self.postimageView.file = post[@"image"];
    [self.postimageView loadInBackground];
    self.profilePic.file = user[@"profilePic"];
    [self.profilePic loadInBackground];
}

@end
