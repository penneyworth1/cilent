//
//  TutorialPageViewController.h
//  Cilent
//
//  Created by Steven Stewart on 10/12/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialChildViewController.h"
#import "AppState.h"
#import "MapViewController.h"

@interface TutorialPageViewController : UIViewController <UIPageViewControllerDataSource>
{
    AppState* appState;
    UIButton* btnGetStarted;
    UIPageViewController *pageController;
}

@end
