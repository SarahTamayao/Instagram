//
//  ComposeViewController.m
//  Instagram
//
//  Created by Brian Sanchez on 7/7/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSDictionary *imageData;
@property (nonatomic, strong) UIImage *originalImage;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pressShare:(id)sender {
    [Post postUserImage:self.originalImage withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error posting: %@", error.localizedDescription);
        } else {
            NSLog(@"Post was successful");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (IBAction)pressCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.originalImage = [self resizeImage:self.originalImage withSize:CGSizeMake(120, 120)];
    self.postImageView.image = self.originalImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

    // Do something with the images (based on your use case)
    // Dismiss UIImagePickerController to go back to your original view controller
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
