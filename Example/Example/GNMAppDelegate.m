//
//  GNMAppDelegate.m
//  Example
//
//  Created by Brandon Smith on 5/20/13.
//  Copyright (c) 2013 Brandon Smith. All rights reserved.
//

#import "GNMAppDelegate.h"

#import "GNMSlidingController.h"

@implementation GNMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *main = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *sliding = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    self.window.rootViewController = [GNMSlidingController controllerWithMainController:main
                                                                      slidingController:sliding
                                                                              slideSide:GnomeSlideSideFromLeft];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
