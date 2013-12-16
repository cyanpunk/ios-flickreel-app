//
//  DrawerController.m
//  Flickreel
//
//  Created by Austris Landmanis on 11/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import "DrawerController.h"

@interface DrawerController ()

@end

@implementation DrawerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0]];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setShowsStatusBarBackgroundView:YES];
    [self setStatusBarViewBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
