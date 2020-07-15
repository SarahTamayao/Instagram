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
    self.profilePic.layer.cornerRadius = (self.profilePic.frame.size.width) / 2;
    self.profilePic.clipsToBounds = YES;
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePic addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePic setUserInteractionEnabled:YES];
    UITapGestureRecognizer *profileTapnameGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePic addGestureRecognizer:profileTapnameGestureRecognizer];
    [self.profilePic setUserInteractionEnabled:YES];

}

- (void)didTapUserProfile: (UITapGestureRecognizer *)sender {
    [self.delegate postCell:self didTap:self.post[@"author"]];
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
    self.postimageView.file = post[@"image"];
    [self.postimageView loadInBackground];
    if (post[@"author"][@"profilePic"] != nil) {
        self.profilePic.file = user[@"profilePic"];
        [self.profilePic loadInBackground];
    }
}
@end
