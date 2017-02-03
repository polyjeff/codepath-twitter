//
//  User.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSNumber *numFollowers;
@property (nonatomic, strong) NSNumber *numFollowing;
@property (nonatomic, strong) NSNumber *numTweets;
@property (nonatomic, strong) NSString *profileBackgroundImageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
