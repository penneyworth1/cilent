//
//  AppDelegate.h
//  Cilent
//
//  Created by Steven Stewart on 10/12/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialPageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    TutorialPageViewController* tutorialPageViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) CLLocationManager* locationManager;

@end

