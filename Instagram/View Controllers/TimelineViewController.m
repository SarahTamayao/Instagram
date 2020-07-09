//
//  TimelineViewController.m
//  Instagram
//
//  Created by Brian Sanchez on 7/7/20.
//  Copyright © 2020 Brian Sanchez. All rights reserved.
//

#import "TimelineViewController.h"
#import "InstaCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import <Parse/Parse.h>
@import MBProgressHUD;

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(queryPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(queryPosts) name:@"postedPhoto" object:nil];
    [self queryPosts];
}

- (void)queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects != nil) {
            self.posts = objects;
            for (PFObject *posts in objects) {
                NSLog(@"%@", posts[@"caption"]);
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    [cell setPost:post];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"profileSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.post = post;
    }
}


@end
