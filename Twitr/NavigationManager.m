//
//  NavigationManager.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/2/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "NavigationManager.h"
#import "LoginViewController.h"
#import "TweetListViewController.h"
#import "TwitterClient.h"
#import "ProfileViewController.h"

@interface NavigationManager ()

@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation NavigationManager

+(instancetype)shared
{
    static NavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoggedIn = [TwitterClient sharedInstance].isAuthorized;
        
        UIViewController *root = self.isLoggedIn ? [self loggedInVC] : [self loggedOutVC];
        
        self.navigationController = [[UINavigationController alloc] init];
        self.navigationController.viewControllers = @[root];
        [self.navigationController setNavigationBarHidden:YES];
    }
    return self;
}


- (UIViewController *)rootViewController
{
    return self.navigationController;
}


- (void)onSignoutButton {
    [[NavigationManager shared] logOut];
}


- (UIViewController *)loggedInVC
{
    // Create root VC for the loggedIn VC hierarchy
    
    
    // First tab bar: Timeline
    TweetListViewController *tweetListController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    tweetListController.title = @"Timeline";
    tweetListController.initialURL = @"1.1/statuses/home_timeline.json";
    
    // create tab item
    // UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Logged In" image:nil tag:0];
    // tweetListController.tabBarItem = item;
    
    
    // create navigation controller
    UINavigationController *timelineController = [[UINavigationController alloc] initWithRootViewController:tweetListController];
    timelineController.tabBarItem.image = [UIImage imageNamed:@"Magical Scroll-30.png"];

    // Create Sign Out button
    UIButton *tweetListSignoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [tweetListSignoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [tweetListSignoutButton sizeToFit];
    [tweetListSignoutButton addTarget:self action:@selector(onSignoutButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tweetListBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tweetListSignoutButton];
    tweetListController.navigationItem.leftBarButtonItem = tweetListBarButtonItem;

    
    
    // Second tab bar: Mentions -- reuse the TweetListViewController but set a different initial URL
    TweetListViewController *mentionListController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    mentionListController.title = @"Mentions";
    mentionListController.initialURL = @"1.1/statuses/mentions_timeline.json";
    // create navigation controller
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:mentionListController];
    navController2.tabBarItem.image = [UIImage imageNamed:@"Megaphone-30.png"];

    
    // Create Sign Out button
    UIButton *mentionListSignoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [mentionListSignoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [mentionListSignoutButton sizeToFit];
    [mentionListSignoutButton addTarget:self action:@selector(onSignoutButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mentionListBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mentionListSignoutButton];
    mentionListController.navigationItem.leftBarButtonItem = mentionListBarButtonItem;

    
    
    // Third tab bar: Profile
    ProfileViewController *profileController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    profileController.title = @"My Profile";
    profileController.user = [TwitterClient sharedInstance].currentUser;
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:profileController];
    navController3.tabBarItem.image = [UIImage imageNamed:@"Cylon Head New-30.png"];

    // create tab bar view controller
    UITabBarController *tabController = [[UITabBarController alloc] init];
    // Add navigation controller to tab bar controller
    tabController.viewControllers = @[timelineController, navController2, navController3];
    
    return tabController;
}


- (UIViewController *)loggedOutVC
{
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    return vc;
}


- (void)logIn
{
    self.isLoggedIn = YES;
    
    NSArray *vcs = @[[self loggedInVC]];
    [self.navigationController setViewControllers:vcs];
}


- (void)logOut
{
    self.isLoggedIn = NO;
    self.navigationController.viewControllers = @[[self loggedOutVC]];
}


@end
