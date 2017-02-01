//
//  Tweet.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) NSNumber *retweetCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
