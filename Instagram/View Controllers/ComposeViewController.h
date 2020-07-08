//
//  ComposeViewController.h
//  Instagram
//
//  Created by Brian Sanchez on 7/7/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionField;

@end

NS_ASSUME_NONNULL_END
