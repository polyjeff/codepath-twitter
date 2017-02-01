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


@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // self.nameLabel.text = @"My Twitter Name";
    // self.handleLabel.text = @"@Placeholder";
    self.timestampLabel.text = @"4h";
    // self.contentLabel.text = @"Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world!";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setTweet:(Tweet *)tweet {
    self.nameLabel.text = tweet.author.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.author.screenName];
    self.contentLabel.text = tweet.text;
    NSLog(@"Profile Image URL is %@", tweet.author.profileImageURL);
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.author.profileImageURL]];
}

@end
