//
//  MapViewController.m
//  Cilent
//
//  Created by Steven Stewart on 10/19/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appState = [AppState getInstance];
    searchPhrase = @"Library";
    menuOpen = false;
    cumulativeDiffX = 0;
    draggingMenu = false;
    shouldShowCustomCallout = true;
    self.navigationItem.backBarButtonItem.title = @"";
    
    mainMapView = [[MKMapView alloc] initWithFrame:appState.screenRect];
    mainMapView.delegate = self;
    [self.view addSubview:mainMapView];
    
    //Show the annotation for the user's current location.
    mainMapView.showsUserLocation = YES;
    
    //Banner - initialize size
    bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    appState.bannerHeight = bannerView.frame.size.height;
    
    vSearchBar = [ViewUtil getRoundedBox:11 :30 :appState.screenWidth-21 :48 :[UIColor whiteColor] :4 :true];
    [self.view addSubview:vSearchBar];
    btnSearch = [ViewUtil getButton:22 :41 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"SearchGlass" :false :0 :0 :0 :0];
    [btnSearch addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
    btnClearSearch = [ViewUtil getButton:appState.screenWidth-49 :41 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"BlackX" :false :0 :0 :0 :0];
    [btnClearSearch addTarget:self action:@selector(clearSearchPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClearSearch];
    tfSearch = [ViewUtil getTextField:62 :34 :appState.screenWidth-120 :40 :[UIColor whiteColor] :2.0f];
    tfSearch.textColor = [UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    tfSearch.delegate = self;
    [self.view addSubview:tfSearch];
    
    spinner = [ViewUtil getLoadingSpinner:appState.screenWidth/2-25 :appState.screenHeight/2-25 :50 :50 :[UIColor grayColor] :8];
    request = [[MKLocalSearchRequest alloc] init];
    
    btnMarkCurrentLocation = [ViewUtil getButton:appState.screenWidth-50 :appState.screenHeight-50-appState.bannerHeight :40 :40 :[UIColor whiteColor] :@"Current Location" :appState.buttonTextColor :appState.buttonFont :8 :@"Arrow" :true :8 :8 :8 :8];
    [self.view addSubview:btnMarkCurrentLocation];
    [btnMarkCurrentLocation addTarget:self action:@selector(currentLocationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    avMarkCurrentLocation = [[UIAlertView alloc]initWithTitle:@"Add Location" message:@"Please enter a name for this location." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    avMarkCurrentLocation.alertViewStyle = UIAlertViewStylePlainTextInput;
    [avMarkCurrentLocation textFieldAtIndex:0].delegate = self;
    
    //Menu
    btnMenuTab = [ViewUtil getButton:-10 :appState.screenHeight-50-appState.bannerHeight :50 :40 :[UIColor whiteColor] :@"" :[UIColor blackColor] :appState.buttonFont :8 :nil :true :0 :0 :0 :0];
    [btnMenuTab addTarget:self action:@selector(menuTabPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMenuTab];
    vMenuTabBar1 = [ViewUtil getRoundedBox:0 :5.7 :44 :5.7 :[UIColor grayColor] :2.85 :false];
    [vMenuTabBar1 setUserInteractionEnabled:NO];
    [btnMenuTab addSubview:vMenuTabBar1];
    vMenuTabBar2 = [ViewUtil getRoundedBox:0 :17.1 :44 :5.7 :[UIColor grayColor] :2.85 :false];
    [vMenuTabBar2 setUserInteractionEnabled:NO];
    [btnMenuTab addSubview:vMenuTabBar2];
    vMenuTabBar3 = [ViewUtil getRoundedBox:0 :28.6 :44 :5.7 :[UIColor grayColor] :2.85 :false];
    [vMenuTabBar3 setUserInteractionEnabled:NO];
    [btnMenuTab addSubview:vMenuTabBar3];
    vMenuContainer = [ViewUtil getRoundedBox:-240 :0 :250 :3*appState.screenHeight :[UIColor clearColor] :0 :false];
    [self.view addSubview:vMenuContainer];
    vMenuBg = [ViewUtil getRoundedBox:0 :0 :240 :3*appState.screenHeight :[UIColor blackColor] :0 :true];
    [vMenuContainer addSubview:vMenuBg];
    
    btnHomeIcon = [ViewUtil getButton:50 :90 :20 :20 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuHome" :false :0 :0 :0 :0];
    [btnHomeIcon addTarget:self action:@selector(menuTabPressed) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnHomeIcon];
    btnHomeText = [ViewUtil getButton:90 :80 :120 :40 :[UIColor clearColor] :@"" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    UILabel* lblHomeText = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 110, 30)];
    lblHomeText.text = @"Home"; lblHomeText.font = appState.buttonFont; lblHomeText.textColor = [UIColor lightGrayColor];
    [btnHomeText addSubview:lblHomeText];
    [btnHomeText addTarget:self action:@selector(menuTabPressed) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnHomeText];
    
    btnMyPlacesIcon = [ViewUtil getButton:50 :125 :20 :20 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuMap" :false :0 :0 :0 :0];
    [btnMyPlacesIcon addTarget:self action:@selector(myPlacesPressed) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnMyPlacesIcon];
    btnMyPlacesText = [ViewUtil getButton:90 :115 :120 :40 :[UIColor clearColor] :@"" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnMyPlacesText addTarget:self action:@selector(myPlacesPressed) forControlEvents:UIControlEventTouchUpInside];
    UILabel* lblMyPlacesText = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 110, 30)];
    lblMyPlacesText.text = @"My Places"; lblMyPlacesText.font = appState.buttonFont; lblMyPlacesText.textColor = [UIColor lightGrayColor];
    [btnMyPlacesText addSubview:lblMyPlacesText];
    [vMenuBg addSubview:btnMyPlacesText];
    
    btnSettingsIcon = [ViewUtil getButton:50 :250 :20 :20 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuSetting" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSettingsIcon];
    btnSettingsText = [ViewUtil getButton:90 :240 :120 :40 :[UIColor clearColor] :@"" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnSettingsText addTarget:self action:@selector(settingsTapped) forControlEvents:UIControlEventTouchUpInside];
    UILabel* lblSettingsText = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 110, 30)];
    lblSettingsText.text = @"Settings"; lblSettingsText.font = appState.buttonFont; lblSettingsText.textColor = [UIColor lightGrayColor];
    [btnSettingsText addSubview:lblSettingsText];
    [vMenuBg addSubview:btnSettingsText];
    
    btnAboutIcon = [ViewUtil getButton:50 :285 :20 :20 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuAbout" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnAboutIcon];
    btnAboutText = [ViewUtil getButton:90 :275 :120 :40 :[UIColor clearColor] :@"" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnAboutText addTarget:self action:@selector(aboutTapped) forControlEvents:UIControlEventTouchUpInside];
    UILabel* lblAboutText = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 110, 30)];
    lblAboutText.text = @"About"; lblAboutText.font = appState.buttonFont; lblAboutText.textColor = [UIColor lightGrayColor];
    [btnAboutText addSubview:lblAboutText];
    [vMenuBg addSubview:btnAboutText];
    
    btnSendFeedbackIcon = [ViewUtil getButton:50 :323 :20 :16 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"email-icon" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSendFeedbackIcon];
    btnSendFeedbackText = [ViewUtil getButton:90 :310 :220 :40 :[UIColor clearColor] :@"" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnSendFeedbackText addTarget:self action:@selector(sendFeedbackTapped) forControlEvents:UIControlEventTouchUpInside];
    UILabel* lblFeedbackText = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 210, 30)];
    lblFeedbackText.text = @"Send Feedback"; lblFeedbackText.font = appState.buttonFont; lblFeedbackText.textColor = [UIColor lightGrayColor];
    [btnSendFeedbackText addSubview:lblFeedbackText];
    [vMenuBg addSubview:btnSendFeedbackText];
    
    btnHelpUsGrowIcon = [ViewUtil getButton:50 :330 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"Grow" :false :0 :0 :0 :0];
    //[vMenuBg addSubview:btnHelpUsGrowIcon];
    btnHelpUsGrowText = [ViewUtil getButton:100 :330 :120 :40 :[UIColor clearColor] :@"Help Us Grow" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    //[vMenuBg addSubview:btnHelpUsGrowText];
    btnUpgradeToPro = [ViewUtil getButton:50 :390 :180 :40 :[UIColor lightGrayColor] :@"Upgrade To Pro" :[UIColor blackColor] :appState.buttonFont :8 :nil :false :0 :0 :0 :0];
    //[vMenuBg addSubview:btnUpgradeToPro];
    
    //My places dialog
    //vMyPlacesBg = [ViewUtil getRoundedBox:appState.screenWidth/2-100 :appState.screenHeight/2-150 :200 :300 :[UIColor whiteColor] :8 :true];
    vMyPlacesBg = [ViewUtil getRoundedToolBar:appState.screenWidth/2-100 :appState.screenHeight/2-150 :200 :300 :[UIColor whiteColor] :8 :true];
    vMyPlacesBg.hidden = true;
    [self.view addSubview:vMyPlacesBg];
    btnCloseMyPlaces = [ViewUtil getButton:162 :10 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"BlackX" :false :0 :0 :0 :0];
    [btnCloseMyPlaces addTarget:self action:@selector(closeMyPlacesDialog) forControlEvents:UIControlEventTouchUpInside];
    [vMyPlacesBg addSubview:btnCloseMyPlaces];
    tblMyPlaces = [[UITableView alloc] initWithFrame:CGRectMake(5, 45, vMyPlacesBg.frame.size.width-10, vMyPlacesBg.frame.size.height-50)];
    tblMyPlaces.delegate = self;
    tblMyPlaces.dataSource = self;
    [vMyPlacesBg addSubview:tblMyPlaces];
    
    //Edit place dialog
    vEditPlaceBg = [ViewUtil getRoundedBox:appState.screenWidth/2-140 :appState.screenHeight/2-100 :280 :200 :[UIColor whiteColor] :8 :true];
    vEditPlaceBg.hidden = true;
    [self.view addSubview:vEditPlaceBg];
    btnCloseEditPlace = [ViewUtil getButton:242 :10 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"BlackX" :false :0 :0 :0 :0];
    [btnCloseEditPlace addTarget:self action:@selector(closeEditPlaceDialog) forControlEvents:UIControlEventTouchUpInside];
    [vEditPlaceBg addSubview:btnCloseEditPlace];
    tvEditPlaceTitle = [ViewUtil getTextView:10 :10 :200 :40 :[UIColor blackColor] :appState.buttonFont :@"Edit Place"];
    [vEditPlaceBg addSubview:tvEditPlaceTitle];
    tvNameLabel = [ViewUtil getTextView:10 :50 :200 :40 :[UIColor blackColor] :appState.buttonFont :@"Name"];
    [vEditPlaceBg addSubview:tvNameLabel];
    tvRadiusLabel = [ViewUtil getTextView:10 :90 :200 :40 :[UIColor blackColor] :appState.buttonFont :@"Radius"];
    [vEditPlaceBg addSubview:tvRadiusLabel];
    tfEditPlaceName = [ViewUtil getTextField:100 :55 :170 :32 :[UIColor lightGrayColor] :8.0f];
    tfEditPlaceName.delegate = self;
    [vEditPlaceBg addSubview:tfEditPlaceName];
    tfEditPlaceRadius = [ViewUtil getTextField:100 :95 :170 :32 :[UIColor lightGrayColor] :8.0f];
    tfEditPlaceRadius.keyboardType = UIKeyboardTypeNumberPad;
    tfEditPlaceRadius.delegate = self;
    [vEditPlaceBg addSubview:tfEditPlaceRadius];
    btnViewPlaceOnMap = [ViewUtil getButton:10 :150 :120 :32 :[UIColor darkGrayColor] :@"View Place On Map" :[UIColor whiteColor] :appState.tinyFont :8 :nil :false :0 :0 :0 :0];
    [btnViewPlaceOnMap addTarget:self action:@selector(showPlaceOnMapButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [vEditPlaceBg addSubview:btnViewPlaceOnMap];
    btnDeletePlace = [ViewUtil getButton:150 :150 :120 :32 :[UIColor darkGrayColor] :@"Delete Place" :[UIColor whiteColor] :appState.tinyFont :8 :nil :false :0 :0 :0 :0];
    [btnDeletePlace addTarget:self action:@selector(deletePlaceButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [vEditPlaceBg addSubview:btnDeletePlace];
    
    //Banner - adding to view controller
    bannerView.frame = CGRectMake(0, appState.screenHeight, appState.screenWidth, appState.bannerHeight);
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    bannerView.rootViewController = self;
    GADRequest *gadRequest = [GADRequest request];
    [bannerView loadRequest:gadRequest];
    bannerView.hidden = YES;
    
    //Init images
    imgPin = [UIImage imageNamed:@"Pin.png"];
    
    //Custom callout
    vCustomCallout = [ViewUtil getRoundedBox:0 :0 :200 :100 :[UIColor whiteColor] :5 :true];
    UIView* vCustomCalloutSeperator = [ViewUtil getRoundedBox:0 :55 :200 :1 :[UIColor lightGrayColor] :1 :false];
    [vCustomCallout addSubview:vCustomCalloutSeperator];
    UIButton* btnAddPlace = [ViewUtil getButton:20 :65 :160 :23 :[UIColor clearColor] :@"" :nil :nil :0 :@"AddToList.png" :false :0 :0 :0 :0];
    [btnAddPlace addTarget:self action:@selector(addToPlacesTapped) forControlEvents:UIControlEventTouchUpInside];
    [vCustomCallout addSubview:btnAddPlace];
    lblSelectedPlace = [[UILabel alloc] init];
    lblSelectedPlace.text = @"Testing";
    lblSelectedPlace.textColor = [UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    lblSelectedPlace.textAlignment = NSTextAlignmentCenter;
    [lblSelectedPlace setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:20]];
    lblSelectedPlace.frame = CGRectMake(5, 13, 190, 35);
    [vCustomCallout addSubview:lblSelectedPlace];
    
    //Zoom in on current location
    MKCoordinateRegion mapRegion;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:[appState currentLatitude] longitude:[appState currentLongitude]];
    mapRegion.center = location.coordinate;
    mapRegion.span.latitudeDelta = 0.05;
    mapRegion.span.longitudeDelta = 0.05;
    [mainMapView setRegion:mapRegion animated: YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)sendFeedbackTapped
{
    NSString *url = [@"mailto:maaz.app@gmail.com?subject=Cilent Feedback&body=Input Feedback here" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: url]];
}
-(void)settingsTapped
{
    SettingsViewController *nextViewController = [[SettingsViewController alloc] init];
    [[self navigationController] pushViewController:nextViewController animated:YES];
}
-(void)aboutTapped
{
    AboutViewController *nextViewController = [[AboutViewController alloc] init];
    [[self navigationController] pushViewController:nextViewController animated:YES];
}
-(void)addToPlacesTapped
{
    Place* newPlace = [[Place alloc] init];
    newPlace.latitude = appState.selectedLatitude;
    newPlace.longitude = appState.selectedLongitude;
    newPlace.name = appState.selectedPlaceName;
    newPlace.address = appState.selectedPlaceAddress;
    newPlace.radiusInMeters = 50;
    
    EditLocation *editLocation = [[EditLocation alloc] init];
    editLocation.place = newPlace;
    [[self navigationController] pushViewController:editLocation animated:YES];
}

-(void)myPlacesPressed
{
    MyPlacesViewController *nextViewController = [[MyPlacesViewController alloc] init];
    [[self navigationController] pushViewController:nextViewController animated:YES];
}
-(void)showMyPlacesDialog
{
    vMyPlacesBg.hidden = NO;
    vMyPlacesBg.transform = CGAffineTransformScale(CGAffineTransformIdentity, .01, .01);
    [self performScaleAnimation:vMyPlacesBg :1 :1 : ^void(BOOL finished) {} ];
}
-(void)closeMyPlacesDialog
{
    void (^completionBlock)(BOOL) = ^void(BOOL finished)
    {
        vMyPlacesBg.hidden = YES;
    };
    [self performScaleAnimation:vMyPlacesBg :.01 :.01 :completionBlock];
}
-(void)showEditPlaceDialog
{
    vEditPlaceBg.hidden = NO;
    vEditPlaceBg.transform = CGAffineTransformScale(CGAffineTransformIdentity, .01, .01);
    [self performScaleAnimation:vEditPlaceBg :1 :1 : ^void(BOOL finished) {} ];
}
-(void)closeEditPlaceDialog
{
    [appState updateMyPlaces];
    [tblMyPlaces reloadData];
    void (^completionBlock)(BOOL) = ^void(BOOL finished)
    {
        vEditPlaceBg.hidden = YES;
    };
    [self performScaleAnimation:vEditPlaceBg :.01 :.01 :completionBlock];
}
-(void)deletePlaceButtonPressed
{
    NSMutableArray* myPlaces = [appState getMyPlaces];
    [myPlaces removeObject:selectedPlace];
    [appState updateMyPlaces];
    [tblMyPlaces reloadData];
    [self closeEditPlaceDialog];
}
-(void)showPlaceOnMapButtonPressed
{
    [self closeEditPlaceDialog];
    [self closeMyPlacesDialog];
    [self.view endEditing:YES]; //Dismiss keyboard
    if(menuOpen)
        [self menuTabPressed];
    MKCoordinateRegion mapRegion;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:selectedPlace.latitude longitude:selectedPlace.longitude];
    mapRegion.center = location.coordinate;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    [mainMapView setRegion:mapRegion animated: YES];
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:location.coordinate radius:selectedPlace.radiusInMeters];
    [mainMapView removeOverlays:mainMapView.overlays]; //Remove all overlays.
    [mainMapView addOverlay:circle];
}
-(void)showBanner
{
    bannerView.hidden = NO;
    [self performTranlateAnimation:bannerView :0 :-appState.bannerHeight];
}

-(void)menuTabPressed
{
    if(menuOpen)
    {
        [self performTranlateAnimation:vMenuContainer :0 :0];
        [self performTranlateAnimation:btnMenuTab :0 :0];
        menuOpen = false;
    }
    else
    {
        [self performTranlateAnimation:vMenuContainer :200 :0];
        [self performTranlateAnimation:btnMenuTab :190 :0];
        menuOpen = true;
    }
}

#pragma mark - Animations
-(void)performTranlateAnimation:(UIView*)view :(float)tx :(float)ty
{
    CGAffineTransform theTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tx, ty);
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.transform = theTransform;
    } completion:^(BOOL finished){ }];
}
-(void)performScaleAnimation:(UIView*)view :(float)sx :(float)sy :(void (^)(BOOL finished))completionBlock
{
    CGAffineTransform theTransform = CGAffineTransformScale(CGAffineTransformIdentity, sx, sy);
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.transform = theTransform;
    } completion:completionBlock];
}


-(void)annotationButtonPressed
{
    UITextField *tfPlaceName = [avMarkCurrentLocation textFieldAtIndex:0];
    if(appState.selectedPlaceName != nil)
        tfPlaceName.text = appState.selectedPlaceName;
    [avMarkCurrentLocation show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView isEqual:avMarkCurrentLocation])
    {
        if(buttonIndex == 1) //The "ok" button.
        {
            NSString* placeName = [alertView textFieldAtIndex:0].text;
            NSString* trimmedPlaceName = [placeName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if(trimmedPlaceName.length > 0)
            {
                //NSLog(appState.selectedPlaceName);
                Place* newPlace = [[Place alloc] init];
                newPlace.latitude = appState.selectedLatitude;
                newPlace.longitude = appState.selectedLongitude;
                newPlace.name = trimmedPlaceName;
                newPlace.radiusInMeters = 50;
                
                NSMutableArray* currentPlaces = [appState getMyPlaces];
                [currentPlaces addObject:newPlace];
                [appState updateMyPlaces:currentPlaces];
                [tblMyPlaces reloadData];
            }
        }
    }
}

#pragma mark - MapView delegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    PlaceAnnotationView *annView = [[PlaceAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationIdentifier"];
    annView.addressString = [annotation subtitle];
    [annView setCanShowCallout:NO];
    annView.frame = CGRectMake(0, 0, imgPin.size.width, imgPin.size.height);
    annView.centerOffset = CGPointMake(0.0f, 0.0f);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imgPin];
    [annView addSubview:imageView];
    
    return annView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(PlaceAnnotationView *)view
{
    selectedAnnotation = [mainMapView.selectedAnnotations objectAtIndex:0];
    
    if(shouldShowCustomCallout)
    {
        vSelectedAnnotationView = view;
        vCustomCallout.center = CGPointMake(imgPin.size.width*0.5, -vCustomCallout.bounds.size.height*0.5f);
        [view addSubview:vCustomCallout];
        vCustomCallout.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, vCustomCallout.bounds.size.height*0.75f);
        vCustomCallout.transform = CGAffineTransformScale(vCustomCallout.transform, .01, .01);
        [self performScaleAnimation:vCustomCallout :1 :1 : ^void(BOOL finished) {} ];
        lblSelectedPlace.text = view.annotation.title;
        
        appState.selectedLatitude = view.annotation.coordinate.latitude;
        appState.selectedLongitude = view.annotation.coordinate.longitude;
        appState.selectedPlaceName = view.annotation.title;
        appState.selectedPlaceAddress = view.addressString;
    }
    shouldShowCustomCallout = true;
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    //Close custom callout
    if(appState.preventAnnotationDeselection) //Must reselect this annotation if the callout did not go away so this method can fire next time.
    {
        appState.preventAnnotationDeselection = false; //Make sure the next deselection is not automatically assumed to be invalid due to tapping an annotation buuble (callout).
        shouldShowCustomCallout = false;
        [mainMapView selectAnnotation:selectedAnnotation animated:NO];
    }
    else
    {
        [vCustomCallout removeFromSuperview];
    }
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    request.region = mapView.region;
}
-(MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
        circleView.lineWidth = 2;
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.25];
        return circleView;
    }
    return nil;
}

#pragma mark - Tableview dataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tblMyPlaces)
    {
        return ((NSMutableArray*)[appState getMyPlaces]).count;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    //cell.backgroundView = [[UIView alloc] init];
    //[cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    //[[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (tableView == tblMyPlaces)
    {
        Place* currentPlace = (Place*)[[appState getMyPlaces] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = currentPlace.name;
        
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row + 1];
    }
    
    return cell;
}
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    selectedPlace = (Place*)[[appState getMyPlaces] objectAtIndex:indexPath.row];
    tfEditPlaceName.text = selectedPlace.name;
    tfEditPlaceRadius.text = [NSString stringWithFormat:@"%i",(int)selectedPlace.radiusInMeters];
    [self showEditPlaceDialog];
}





-(void)searchEntered
{
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        //NSLog(@"Map Items: %@", response.mapItems);
        
        NSMutableArray *annotations = [NSMutableArray array];
        firstSearchResultSelected = false; //Only zoom in on the very first result.
        
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            
            NSString* subThoroghfare = item.placemark.subThoroughfare ? item.placemark.subThoroughfare : @"";
            NSString* thoroghfare = item.placemark.thoroughfare ? item.placemark.thoroughfare : @"";
            NSString* postalCode = item.placemark.postalCode ? item.placemark.postalCode : @"";
            
            NSString* subtitleString = @"";
            if([subThoroghfare length] > 0)
                subtitleString = [NSString stringWithFormat:@"%@",subThoroghfare];
            if([thoroghfare length] > 0)
                subtitleString = [NSString stringWithFormat:@"%@ %@, ",subtitleString,thoroghfare];
            
            
            annotation.title = item.name;
            annotation.subtitle = [NSString stringWithFormat:@"%@%@, %@, %@",
                                   subtitleString,
                                   item.placemark.locality,
                                   item.placemark.country,
                                   postalCode];
            annotation.coordinate = item.placemark.location.coordinate;
            
            [annotations addObject:annotation];
            
            if(!firstSearchResultSelected)
            {
                firstSearchResultSelected = true;
                appState.currentLatitude = annotation.coordinate.latitude;
                appState.currentLongitude = annotation.coordinate.longitude;
                //Zoom in on selected location
                MKCoordinateRegion mapRegion;
                CLLocation* location = [[CLLocation alloc] initWithLatitude:[appState currentLatitude] longitude:[appState currentLongitude]];
                mapRegion.center = location.coordinate;
                mapRegion.span.latitudeDelta = 0.1;
                mapRegion.span.longitudeDelta = 0.1;
                [mainMapView setRegion:mapRegion animated: YES];
            }
        }];
        
        [mainMapView removeAnnotations:mainMapView.annotations];
        [mainMapView addAnnotations:annotations];
        if(mainMapView.annotations.count > 0)
        {
            MKPointAnnotation* tempAnnotation = (MKPointAnnotation*)[mainMapView.annotations objectAtIndex:0];
            
            [mainMapView selectAnnotation:tempAnnotation animated:YES];
        }
        
        [spinner removeFromSuperview];
    }];
}

-(void)clearSearchPressed
{
    [tfSearch setText:@""];
}

-(void)searchButtonPressed
{
    mainMapView.showsUserLocation = NO;
    [self searchEntered];
}

-(void)currentLocationButtonPressed
{
    [mainMapView removeAnnotations:mainMapView.annotations];
    mainMapView.showsUserLocation = YES;
    [mainMapView setCenterCoordinate:mainMapView.userLocation.location.coordinate animated:YES];
    [mainMapView selectAnnotation:mainMapView.userLocation animated:YES];
}

#pragma mark - Text Field Delegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString
{
    NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
    if(textField == tfSearch)
    {
        request.naturalLanguageQuery = resultString;
    }
    if(textField == tfEditPlaceName)
    {
        if(resultString.length > 0 && resultString.length < 150)
            selectedPlace.name = resultString;
    }
    if(textField == tfEditPlaceRadius)
    {
        if(resultString.length > 0 && resultString.length < 4)
            selectedPlace.radiusInMeters = [resultString doubleValue];
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES]; //Dismiss keyboard
    [self searchButtonPressed];
    return YES;
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        mainMapView.frame = appState.screenRect;
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        mainMapView.frame = appState.landscapeScreenRect;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [(UITouch *)[[touches allObjects] objectAtIndex:0] locationInView:nil];
    lastTouchX = point.x;
    
    [self.view endEditing:YES]; //Dismiss keyboard
    if(menuOpen)
        [self menuTabPressed];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    CGPoint point = [(UITouch *)[[touches allObjects] objectAtIndex:0] locationInView:nil];
    float currentX = point.x;
    
    if(lastTouchX < 10 && currentX > lastTouchX)
    {
        draggingMenu = true;
    }
    
    if(draggingMenu)
    {
        float diff = currentX - lastTouchX;
        cumulativeDiffX += diff;
        if(cumulativeDiffX > 200) cumulativeDiffX = 200;
        [self performTranlateAnimation:vMenuContainer :cumulativeDiffX :0];
        [self performTranlateAnimation:btnMenuTab :cumulativeDiffX :0];
    }
    
    lastTouchX = currentX;
    
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Snap menu
    if(!menuOpen && cumulativeDiffX > 100)
    {
        [self menuTabPressed];
    }
    else if(!menuOpen && cumulativeDiffX > 0 && cumulativeDiffX <100) //Didn't fully open - snap it back out of view.
    {
        menuOpen = true;
        [self menuTabPressed];
    }
        
    draggingMenu = false;
    cumulativeDiffX = 0;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    [super touchesCancelled:touches withEvent:event];
}

#pragma mark - Admob banner delegate
/// Called when an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView
{
    [self showBanner];
}
/// Called when an ad request failed.
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}
/// Called just before presenting the user a full screen view, such as
/// a browser, in response to clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}
/// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}
/// Called just after dismissing a full screen view.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}
/// Called just before the application will background or terminate
/// because the user clicked on an ad that will launch another
/// application (such as the App Store).
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewDidLeaveApplication");
}

@end
