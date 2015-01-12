//
//  MyPlacesViewController.h
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppState.h"
#import "ViewUtil.h"
#import "EditLocation.h"
#import "Place.h"
#import "PlaceTableViewCell.h"

@interface MyPlacesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    AppState* appState;
    UITableView* tblvPlaces;
}

@end
