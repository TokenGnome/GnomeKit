//
//  TestGNMSlidingController.m
//  Tests
//
//  Created by Brandon Smith on 5/20/13.
//  Copyright (c) 2013 Brandon Smith. All rights reserved.
//

#import "TestGNMSlidingController.h"
#import "GNMSlidingController.h"

@implementation TestGNMSlidingController

- (void)testChildControllers
{
    UIViewController *main = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *sec = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    GNMSlidingController *slidingController = [GNMSlidingController controllerWithMainController:main slidingController:sec slideSide:GnomeSlideSideFromLeft];
    
    STAssertEqualObjects(slidingController, main.parentViewController, @"The sliding controller should be the parent of the main controller");
    STAssertEqualObjects(slidingController, sec.parentViewController, @"The sliding controller should be the parent of the sliding controller");
    
}

@end
