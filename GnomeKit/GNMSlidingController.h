//
//  GNMSlidingController.h
//  GnomeKit
//
//  Created by Smith, Brandon on 5/17/13.
//  Copyright (c) 2013 Smith, Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GnomeSlideSide)
{
    GnomeSlideSideNone = 0,
    GnomeSlideSideFromLeft,
    GnomeSlideSideFromRight
};

typedef NS_OPTIONS(NSInteger, GnomeShowGestureMode)
{
    GnomeShowGestureModeNone                 = 0,
    GnomeShowGestureModePanningNavigationBar = 1 << 1,
    GnomeShowGestureModePanningMainView      = 1 << 2,
    GnomeShowGestureModeAll = GnomeShowGestureModePanningNavigationBar |
                              GnomeShowGestureModePanningMainView
};

typedef NS_OPTIONS(NSInteger, GnomeHideGestureMode)
{
    GnomeHideGestureModeNone                 = 0,
    GnomeHideGestureModePanningNavigationBar = 1 << 1,
    GnomeHideGestureModePanningMainView      = 1 << 2,
    GnomeHideGestureModeTapNavigationbar     = 1 << 3,
    GnomeHideGestureModeTapMainView          = 1 << 4,
    GnomeHideGestureModeAll = GnomeHideGestureModePanningNavigationBar |
                              GnomeHideGestureModePanningMainView |
                              GnomeHideGestureModeTapNavigationbar |
                              GnomeHideGestureModeTapMainView
};

@interface GNMSlidingController : UIViewController

@property (nonatomic, strong) UIViewController *mainViewController;

@property (nonatomic, strong) UIViewController *slidingViewController;

@property (nonatomic, assign) CGFloat maximumSlidingWidth;

@property (nonatomic, assign, readonly) GnomeSlideSide slideSide;

@property (nonatomic, assign) GnomeShowGestureMode showGestureModeMask;

@property (nonatomic, assign) GnomeHideGestureMode hideGestureModeMask;

+ (instancetype)controllerWithMainController:(UIViewController *)main
                           slidingController:(UIViewController *)sliding
                                   slideSide:(GnomeSlideSide)side;

@end

@interface UIViewController (GnomeKitSlidingController)
@property (nonatomic, readonly) GNMSlidingController *gnm_slidingController;
@end