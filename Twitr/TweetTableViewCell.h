//
//  TweetTableViewCell.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol TweetTableViewCellDelegate <NSObject>

- (void) cellImageTapped:(Tweet *)tweet;

@end

@interface TweetTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TweetTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;

-(void) setTweet:(Tweet *)tweet;

@end
