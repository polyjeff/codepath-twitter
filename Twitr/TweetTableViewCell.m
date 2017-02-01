//
//  TweetTableViewCell.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "Tweet.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;

@property (weak, nonatomic) IBOutlet UIView *topContainer;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setTweet:(Tweet *)tweet {
    if (tweet != nil) {
        self.nameLabel.text = tweet.author.name;
        self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.author.screenName];
        self.contentLabel.text = tweet.text;
        
        NSLog(@"retweetCount is %@, text is  %@", tweet.retweetCount, tweet.text);
        if (tweet.retweetCount.integerValue > 1) {
            self.retweetLabel.text = [NSString stringWithFormat:@"Retweeted %@ times", tweet.retweetCount];
        } else if (tweet.retweetCount.integerValue == 1) {
            self.retweetLabel.text = [NSString stringWithFormat:@"Retweeted %@ time", tweet.retweetCount];
        } else {
            self.retweetLabel.text = @"";
        }
        
        [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.author.profileImageURL]];

        NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        formatter.maximumUnitCount = 1;
        NSString *elapsed = [formatter stringFromDate:tweet.createdAt toDate:[NSDate date]];
        self.timestampLabel.text = elapsed;
    }
}

@end
