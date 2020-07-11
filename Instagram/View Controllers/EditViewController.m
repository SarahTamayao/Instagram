//
//  EditViewController.m
//  Instagram
//
//  Created by Brian Sanchez on 7/8/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import "EditViewController.h"
#import <Parse/Parse.h>

@interface EditViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *originalImage;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currUser = [PFUser currentUser];
    self.profilePic.file = currUser[@"profilePic"];
    [self.profilePic loadInBackground];
    self.bioField.text = currUser[@"bio"];
    
}
- (IBAction)changePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)tapDone:(id)sender {
    PFUser *currUser = [PFUser currentUser];
    if (self.bioField.text != nil) {
        currUser[@"bio"] = self.bioField.text;
    }
    currUser[@"name"] = self.nameField.text;
    [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Edit was successful");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.profilePic.image = self.originalImage;
    PFUser *currUser = [PFUser currentUser];
    currUser[@"profilePic"] = [self getPFFileFromImage:self.originalImage];
    [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Edit was successful");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

    // Do something with the images (based on your use case)
    // Dismiss UIImagePickerController to go back to your original view controller
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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
