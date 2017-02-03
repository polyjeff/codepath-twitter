//
//  SingleTweetViewController.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/3/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "SingleTweetViewController.h"
#import <UIImageView+AFNetworking.h>


@interface SingleTweetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation SingleTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTweet:self.thisTweet];
}

-(void) setTweet:(Tweet *)tweet {
    if (tweet != nil) {
        // Store model away for future reference
        
        // Set cell values
        self.nameLabel.text = tweet.author.name;
        self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.author.screenName];
        self.contentLabel.text = [NSString stringWithFormat:@"%@ (tweet id = %@, user id = %@)", tweet.text, tweet.tweetId, tweet.author.userId];
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
        
        NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        formatter.maximumUnitCount = 1;
        NSString *elapsed = [formatter stringFromDate:tweet.createdAt toDate:[NSDate date]];
        self.timestampLabel.text = elapsed;
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
