//
//  GNMSlidingController.m
//  GnomeKit
//
//  Created by Smith, Brandon on 5/17/13.
//  Copyright (c) 2013 Smith, Brandon. All rights reserved.
//

#import "GNMSlidingController.h"

@interface _GNMMainContainerView : UIView
@end
@implementation _GNMMainContainerView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}
@end

@interface _GNMSlidingContainerView : UIView
@end
@implementation _GNMSlidingContainerView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor darkGrayColor];
        
    }
    return self;
}
@end

@interface GNMSlidingController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) _GNMMainContainerView *mainContainerView;
@property (nonatomic, strong) _GNMSlidingContainerView *slidingContainerView;
@end

@implementation GNMSlidingController

+ (instancetype)controllerWithMainController:(UIViewController *)main
                           slidingController:(UIViewController *)sliding
                                   slideSide:(GnomeSlideSide)side
{
    GNMSlidingController *controller = [[self alloc] initWithMainController:main slidingController:sliding slideSide:side];
    return controller;
}

- (id)initWithMainController:(UIViewController *)main slidingController:(UIViewController *)sliding slideSide:(GnomeSlideSide)side
{
    NSParameterAssert(main);
    self = [super init];
    if (self) {
        self.maximumSlidingWidth = 320.0f;
        _slideSide = side;
        
        [self setMainViewController:main];
        [self setSlidingViewController:sliding];
        
        [self setShowGestureModeMask:GnomeShowGestureModeNone];
        [self setHideGestureModeMask:GnomeHideGestureModeNone];
        
        [self setupGestureRecognizers];
    }
    return self;
}

# pragma mark - Getters

- (_GNMMainContainerView *)mainContainerView
{
    if (_mainContainerView == nil) {
        _mainContainerView = [[_GNMMainContainerView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mainContainerView];
    }

    return _mainContainerView;
}

- (_GNMSlidingContainerView *)slidingContainerView
{
    if (_slidingContainerView == nil) {
        
        CGFloat xCoord;
        UIViewAutoresizing resize;
        if (self.slideSide == GnomeSlideSideFromLeft) {
            xCoord = -self.maximumSlidingWidth;
            resize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        } else {
            xCoord = self.view.bounds.size.width;
            resize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        }
        
        CGRect frame = CGRectMake(xCoord, 0.0f, self.maximumSlidingWidth, self.view.bounds.size.height);
        _slidingContainerView = [[_GNMSlidingContainerView alloc] initWithFrame:frame];
        self.slidingContainerView.autoresizingMask = resize;
        [self.view addSubview:_slidingContainerView];
    }
    
    return _slidingContainerView;
}

# pragma mark - Setters

- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated
{    
    // Get rid of the old main controller
    UIViewController *oldController = self.mainViewController;
    if (oldController) {
        [oldController removeFromParentViewController];
        [oldController.view removeFromSuperview];
    }
    
    // Set the new controller
    _mainViewController = mainViewController;
    [self addChildViewController:self.mainViewController];
    self.mainViewController.view.frame = self.mainContainerView.bounds;
    [self.mainContainerView addSubview:self.mainViewController.view];
    self.mainViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.mainViewController didMoveToParentViewController:self];
}

- (void)setSlidingViewController:(UIViewController *)slidingViewController animated:(BOOL)animated
{        
    // Get rid of the old side controller
    UIViewController *oldController = self.slidingViewController;
    if (oldController) {
        [oldController removeFromParentViewController];
        [oldController.view removeFromSuperview];
    }
    
    // Set the new controller
    if (slidingViewController) {
        _slidingViewController = slidingViewController;
        [self addChildViewController:self.slidingViewController];
        self.slidingViewController.view.frame = self.slidingContainerView.bounds;
        [self.slidingContainerView addSubview:self.slidingViewController.view];
        [self.slidingViewController didMoveToParentViewController:self];
        self.slidingViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
}

- (void)setMainViewController:(UIViewController *)mainViewController
{
    [self setMainViewController:mainViewController animated:NO];
}

- (void)setSlidingViewController:(UIViewController *)slidingViewController
{
    [self setSlidingViewController:slidingViewController animated:NO];
}

# pragma mark - UIViewController subclass

- (void)viewDidLoad
{
    [super viewDidLoad];
}

# pragma mark - Sliding animations

- (void)hideSlidingViewContainer:(BOOL)animated
{
    [UIView animateWithDuration:0.3 animations:^{
        self.slidingContainerView.transform = CGAffineTransformIdentity;
    }];
}

- (void)showSlidingViewContainer:(BOOL)animated
{
    [UIView animateWithDuration:0.3 animations:^{
        self.slidingContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, self.maximumSlidingWidth, 0.0f);
    }];
}

- (void)endPanningWithTranslation:(CGPoint)translation velocity:(CGPoint)velocity
{
    if (translation.x < (self.maximumSlidingWidth / 4.0f) || velocity.x < -50.0f) {
        [self hideSlidingViewContainer:YES];
    } else {
        [self showSlidingViewContainer:YES];
    }
}

# pragma mark - UIGestureRecognizer setup

- (void)setupGestureRecognizers
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

# pragma mark - UIGestureRecognizer handlers

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation, velocity;
    translation = [pan translationInView:self.mainContainerView];
    velocity = [pan velocityInView:self.mainContainerView];
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            [pan setTranslation:CGPointApplyAffineTransform(CGPointZero, self.slidingContainerView.transform) inView:self.mainContainerView];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat normal = MIN(MAX(0.0f, translation.x), self.maximumSlidingWidth);
            self.slidingContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, normal, 0.0f);
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self endPanningWithTranslation:translation velocity:velocity];
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
            break;
    }
}

# pragma mark - UIGestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"Pan");
    CGPoint point = [touch locationInView:self.slidingContainerView];
    return point.x >= self.slidingContainerView.bounds.size.width;
}

@end

@implementation UIViewController (GnomeKitSlidingController)

- (GNMSlidingController *)gnm_slidingController
{
    UIViewController *parent = self.parentViewController;
    while (parent) {
        if ([parent isKindOfClass:[GNMSlidingController class]]) {
            return (GNMSlidingController *)parent;
        } else {
            parent = parent.parentViewController;
        }
    }
    return nil;
}

@end
