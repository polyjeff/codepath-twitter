//
//  LoginViewController.m
//  Twitr
//
//  Created by Jeffrey Okamoto on 1/30/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetListViewController.h"
#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>


@implementation LoginViewController


- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            NSLog(@"Welcome, %@", user.name);
            // Modally present tweets list
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.tweetListViewController];
            
            [self presentViewController:navController animated:NO completion:nil];
            
        } else {
            // ERROR!
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    TweetListViewController *tweetListController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    self.tweetListViewController = tweetListController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
