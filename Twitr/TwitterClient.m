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
NSString * const kTwitterCurrentUserKey = @"twitterCurrentUser";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;

    if (instance == nil) {
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseURL] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:kTwitterCurrentUserKey];
        if (data) {
            NSDictionary *currentUserDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (currentUserDictionary) {
                instance.currentUser = [[User alloc] initWithDictionary:currentUserDictionary];
            }
        }
        

    }
    return instance;
}

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterdemojeff://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        // NSLog(@"Got the request token");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat: @"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                // NSLog(@"Opened URL");
            } else {
                NSLog(@"Failed to open URL");
            }
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token");
        self.loginCompletion(nil, error);
    }];
   
}

- (void) openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        // NSLog(@"Got access token!");
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            
            // Store dictionary in user defaults
            if (user && user.dictionary) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user.dictionary];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:kTwitterCurrentUserKey];
                self.currentUser = [[User alloc] initWithDictionary:user.dictionary];
            }
            
            // NSLog(@"current user: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error getting user");
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get access token");
        self.loginCompletion(nil, error);
    }];
}

@end
