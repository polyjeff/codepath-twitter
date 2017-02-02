//
//  NavigationManager.h
//  Twitr
//
//  Created by Jeffrey Okamoto on 2/2/17.
//  Copyright © 2017 Jeffrey Okamoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NavigationManager.h"

@interface NavigationManager : NSObject

+ (instancetype)shared;

- (UIViewController *)rootViewController;

- (void)logIn;
- (void)logOut;

@end
