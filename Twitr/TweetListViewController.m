//
//  TweetListViewController.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface TweetListViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Tweet *> *tweets;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];

    [self fetchTweets];
}

- (void) fetchTweets {
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json"
                             parameters:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // NSLog(@"tweets: %@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        self.tweets = tweets;
        [self.tableView reloadData];

        for (Tweet *tweet in tweets) {
            NSLog(@"text: %@, created = %@", tweet.text, tweet.createdAt);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error getting tweets");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    
    [cell setTweet:tweet];
    
    NSLog(@"GOT TWEET: %@", tweet);
    if (indexPath.row % 2)  {
        cell.retweetContainerHeightConstraint.constant = 0;
    } else {
        cell.retweetContainerHeightConstraint.constant = 24 * indexPath.row
        ;
    }

    [cell setNeedsUpdateConstraints];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
