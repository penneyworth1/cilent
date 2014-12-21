//
//  MapViewController.h
//  Cilent
//
//  Created by Steven Stewart on 10/19/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AppState.h"
#import "ViewUtil.h"
#import "Place.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    MKMapView * mainMapView;
    UIActivityIndicatorView *spinner;
    AppState* appState;
    UIButton* btnMarkCurrentLocation;
    UIAlertView* avMarkCurrentLocation;
    NSString* searchPhrase;
    MKLocalSearchRequest *request;
    
    UIView* vSearchBar;
    UIView* vSearchBarShadow;
    UIButton* btnSearch;
    UIButton* btnClearSearch;
    UITextField* tfSearch;
    
    UIButton* btnMenuTab;
    UIView* vMenuTabBar1;
    UIView* vMenuTabBar2;
    UIView* vMenuTabBar3;
    bool menuOpen;
    UIView* vMenuContainer;
    UIView* vMenuBg;
    UIButton* btnHomeIcon;
    UIButton* btnHomeText;
    UIButton* btnMyPlacesIcon;
    UIButton* btnMyPlacesText;
    UIButton* btnSettingsIcon;
    UIButton* btnSettingsText;
    UIButton* btnAboutIcon;
    UIButton* btnAboutText;
    UIButton* btnSendFeedbackIcon;
    UIButton* btnSendFeedbackText;
    UIButton* btnHelpUsGrowIcon;
    UIButton* btnHelpUsGrowText;
    UIButton* btnUpgradeToPro;
    
    UIView* vMyPlacesBg;
    UIButton* btnCloseMyPlaces;
    UITableView* tblMyPlaces;
    
    UIView* vEditPlaceBg;
    UIButton* btnCloseEditPlace;
    UITextField* tfEditPlaceName;
    UITextField* tfEditPlaceRadius;
    UITextView* tvNameLabel;
    UITextView* tvRadiusLabel;
    UITextView* tvEditPlaceTitle;
    UIButton* btnViewPlaceOnMap;
    UIButton* btnDeletePlace;
    Place* selectedPlace;
    
    bool draggingMenu;
    float lastTouchX;
    float cumulativeDiffX;
}



@end
