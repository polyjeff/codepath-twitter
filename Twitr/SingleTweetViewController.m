//
//  SingleTweetViewController.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/3/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "SingleTweetViewController.h"
#import <UIImageView+AFNetworking.h>
#import "Tweet.h"

@interface SingleTweetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) Tweet *tweetmodel;

@end

@implementation SingleTweetViewController

- (void)profileTap:(UITapGestureRecognizer *)sender {
    NSLog(@"Inside profileTap of SingleTweetViewContoller, about to delegate");
    [self.delegate singleTweetImageTapped:self.tweetmodel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTweet:self.thisTweet];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileTap:)];
    [self.profileImageView addGestureRecognizer:tapRecognizer];
}

-(void) setTweet:(Tweet *)tweet {
    if (tweet != nil) {
        // Store model away for future reference
        self.tweetmodel = tweet;

        // Set cell values
        self.nameLabel.text = tweet.author.name;
        self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.author.screenName];
        self.contentLabel.text = tweet.text;
        // self.contentLabel.text = [NSString stringWithFormat:@"%@ (tweet id = %@, user id = %@)", tweet.text, tweet.tweetId, tweet.author.userId];
        /*
        if (tweet.retweetCount.integerValue > 1) {
            self.retweetLabel.text = [NSString stringWithFormat:@"Retweeted %@ times", tweet.retweetCount];
        } else if (tweet.retweetCount.integerValue == 1) {
            self.retweetLabel.text = [NSString stringWithFormat:@"Retweeted %@ time", tweet.retweetCount];
        } else {
            self.retweetLabel.text = @"";
        }
        */
        [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.author.profileImageURL]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss z y";
        NSString *createdAt = [formatter stringFromDate:tweet.createdAt];
        self.timestampLabel.text = createdAt;
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
