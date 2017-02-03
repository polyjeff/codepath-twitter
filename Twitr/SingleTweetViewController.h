//
//  SingleTweetViewController.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/3/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface SingleTweetViewController : UIViewController

@property (nonatomic, strong) Tweet *thisTweet;

-(void) setTweet:(Tweet *)tweet;

@end
