//
//  EditViewController.h
//  Instagram
//
//  Created by Brian Sanchez on 7/8/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *bioField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

NS_ASSUME_NONNULL_END
