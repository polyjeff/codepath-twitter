//
//  SingleTweetViewController.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/3/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol SingleTweetViewDelegate <NSObject>

- (void) singleTweetImageTapped:(Tweet *)tweet;

@end

@interface SingleTweetViewController : UIViewController

@property (weak, nonatomic) id<SingleTweetViewDelegate> delegate;

@property (nonatomic, strong) Tweet *thisTweet;

-(void) setTweet:(Tweet *)tweet;

@end
