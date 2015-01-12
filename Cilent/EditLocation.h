//
//  EditLocation.h
//  Cilent
//
//  Created by Steven Stewart on 1/8/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppState.h"
#import "ViewUtil.h"
#import "EditRadiusViewController.h"
#import "EditNameViewController.h"
#import "Place.h"

@interface EditLocation : UIViewController
{
    
}

@property Place* place;
@property UILabel* lblNameInfo;
@property UILabel* lblRadiusInfo;
@property UIButton* btnRemoveThisLocation;
@property UILabel* lblOriginalPlaceName;

@end
