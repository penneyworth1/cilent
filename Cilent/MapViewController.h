//
//  MapViewController.h
//  Cilent
//
//  Created by Steven Stewart on 10/19/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppState.h"
#import "ViewUtil.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    MKMapView * mainMapView;
    UIActivityIndicatorView *spinner;
    AppState* appState;
    UIButton* btnMarkCurrentLocation;
    //UIAlertView* avSearch;
    UIAlertView* avMarkCurrentLocation;
    NSString* searchPhrase;
    MKLocalSearchRequest *request;
    
    UIView* vSearchBar;
    UIView* vSearchBarShadow;
    UIButton* btnSearch;
    UIButton* btnClearSearch;
    UITextField* tfSearch;
    
}



@end
