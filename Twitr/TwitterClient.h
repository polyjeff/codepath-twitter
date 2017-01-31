//
//  TwitterClient.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)sharedInstance;

@end
