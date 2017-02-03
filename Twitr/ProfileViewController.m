//
//  ProfileViewController.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/2/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadData];
}

- (void)reloadData {
    if (self.user != nil) {
        self.nameLabel.text = self.user.name;
        self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
        self.numTweetsLabel.text = [NSString stringWithFormat:@"Number of tweets: %@", self.user.numTweets];
        self.numFollowersLabel.text = [NSString stringWithFormat:@"Number of followers: %@", self.user.numFollowers];
        self.numFollowingLabel.text = [NSString stringWithFormat:@"Number following: %@", self.user.numFollowing];
        [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageURL]];
        [self.profileBackgroundImageView setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageURL]];
        
        // NSLog(@"On profile page, user name is %@", self.user.name);
        // NSLog(@"On profile page, user background image url is %@", self.user.profileBackgroundImageURL);
    }
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
