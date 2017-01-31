//
//  TwitterClient.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"HYaNZbEg0OdE3Dmi3XA5LhIvS";
NSString * const kTwitterConsumerSecret = @"7ZmAoGvwpnr2NDV7pyTc4iWb7nfYpmQRRKRf9CThcUXvfL60cR";
NSString * const kTwitterBaseURL = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    TwitterClient *instance = nil;

    if (instance == nil) {
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseURL] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
    }
    return instance;
}


@end
