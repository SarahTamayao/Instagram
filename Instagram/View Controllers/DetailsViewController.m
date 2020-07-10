//
//  DetailsViewController.m
//  Instagram
//
//  Created by Brian Sanchez on 7/8/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.captionLabel.text = self.post.caption;
    self.likeLabel.text = self.post.likeCount.stringValue;
    PFUser *user = self.post.author;
    self.usernameLabel.text = user.username;
    self.smallusernameLabel.text = user.username;
    NSDate *date = [self.post updatedAt];
    self.dateLabel.text = date.timeAgoSinceNow;
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
