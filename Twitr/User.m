//
//  User.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageURL = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.userId = dictionary[@"id_str"];
        self.numFollowers = dictionary[@"followers_count"];
        self.numFollowing = dictionary[@"friends_count"];
        self.numTweets = dictionary[@"statuses_count"];
    }
    return self;
}
@end
