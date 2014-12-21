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
    
    mainMapView = [[MKMapView alloc] initWithFrame:appState.screenRect];
    mainMapView.delegate = self;
    [self.view addSubview:mainMapView];
    mainMapView.showsUserLocation = YES;
    
    vSearchBar = [ViewUtil getRoundedBox:11 :30 :appState.screenWidth-21 :48 :[UIColor whiteColor] :4 :true];
    [self.view addSubview:vSearchBar];
    btnSearch = [ViewUtil getButton:22 :41 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"SearchGlass" :false :0 :0 :0 :0];
    [btnSearch addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
    btnClearSearch = [ViewUtil getButton:appState.screenWidth-49 :41 :28 :28 :[UIColor clearColor] :@"" :appState.buttonTextColor :appState.buttonFont :0 :@"BlackX" :false :0 :0 :0 :0];
    [btnClearSearch addTarget:self action:@selector(clearSearchPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClearSearch];
    tfSearch = [ViewUtil getTextField:62 :34 :appState.screenWidth-120 :40 :[UIColor whiteColor] :2.0f];
    tfSearch.delegate = self;
    [self.view addSubview:tfSearch];
    
    spinner = [ViewUtil getLoadingSpinner:appState.screenWidth/2-25 :appState.screenHeight/2-25 :50 :50 :[UIColor grayColor] :8];
    request = [[MKLocalSearchRequest alloc] init];
    
    btnMarkCurrentLocation = [ViewUtil getButton:appState.screenWidth-50 :appState.screenHeight-50 :40 :40 :[UIColor whiteColor] :@"Current Location" :appState.buttonTextColor :appState.buttonFont :8 :@"Arrow" :true :8 :8 :8 :8];
    [self.view addSubview:btnMarkCurrentLocation];
    [btnMarkCurrentLocation addTarget:self action:@selector(currentLocationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    avMarkCurrentLocation = [[UIAlertView alloc]initWithTitle:@"Add Location" message:@"Please enter a name for this location." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    avMarkCurrentLocation.alertViewStyle = UIAlertViewStylePlainTextInput;
    [avMarkCurrentLocation textFieldAtIndex:0].delegate = self;
    
    //Menu
    btnMenuTab = [ViewUtil getButton:-10 :appState.screenHeight-50 :50 :40 :[UIColor whiteColor] :@"" :[UIColor blackColor] :appState.buttonFont :8 :nil :true :0 :0 :0 :0];
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
    btnHomeIcon = [ViewUtil getButton:50 :30 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuHome" :false :0 :0 :0 :0];
    [btnHomeIcon addTarget:self action:@selector(menuTabPressed) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnHomeIcon];
    btnHomeText = [ViewUtil getButton:100 :30 :120 :40 :[UIColor clearColor] :@"Home" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnHomeText addTarget:self action:@selector(menuTabPressed) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnHomeText];
    btnMyPlacesIcon = [ViewUtil getButton:50 :90 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuMap" :false :0 :0 :0 :0];
    [btnMyPlacesIcon addTarget:self action:@selector(showMyPlacesDialog) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnMyPlacesIcon];
    btnMyPlacesText = [ViewUtil getButton:100 :90 :120 :40 :[UIColor clearColor] :@"My Places" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [btnMyPlacesText addTarget:self action:@selector(showMyPlacesDialog) forControlEvents:UIControlEventTouchUpInside];
    [vMenuBg addSubview:btnMyPlacesText];
    btnSettingsIcon = [ViewUtil getButton:50 :150 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuSetting" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSettingsIcon];
    btnSettingsText = [ViewUtil getButton:100 :150 :120 :40 :[UIColor clearColor] :@"Settings" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSettingsText];
    btnAboutIcon = [ViewUtil getButton:50 :210 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"MenuAbout" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnAboutIcon];
    btnAboutText = [ViewUtil getButton:100 :210 :120 :40 :[UIColor clearColor] :@"About" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnAboutText];
    btnSendFeedbackIcon = [ViewUtil getButton:50 :270 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"Feedback" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSendFeedbackIcon];
    btnSendFeedbackText = [ViewUtil getButton:100 :270 :120 :40 :[UIColor clearColor] :@"Send Feedback" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnSendFeedbackText];
    btnHelpUsGrowIcon = [ViewUtil getButton:50 :330 :40 :40 :[UIColor clearColor] :@"" :[UIColor blackColor] :appState.mediumFont :0 :@"Grow" :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnHelpUsGrowIcon];
    btnHelpUsGrowText = [ViewUtil getButton:100 :330 :120 :40 :[UIColor clearColor] :@"Help Us Grow" :[UIColor grayColor] :appState.mediumFont :0 :nil :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnHelpUsGrowText];
    btnUpgradeToPro = [ViewUtil getButton:50 :390 :180 :40 :[UIColor lightGrayColor] :@"Upgrade To Pro" :[UIColor blackColor] :appState.buttonFont :8 :nil :false :0 :0 :0 :0];
    [vMenuBg addSubview:btnUpgradeToPro];
    
    //My places dialog
    vMyPlacesBg = [ViewUtil getRoundedBox:appState.screenWidth/2-100 :appState.screenHeight/2-150 :200 :300 :[UIColor whiteColor] :8 :true];
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

- (void) viewDidAppear:(BOOL)animated
{
    
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
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] ;
    customPinView.pinColor = MKPinAnnotationColorRed;
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = YES;
    
    UIButton* rightButton = [ViewUtil getButton:0 :0 :30 :30 :[UIColor greenColor] :@"+" :[UIColor blackColor] :appState.buttonFont :15 :nil :false :0 :0 :0 :0];
    [rightButton addTarget:self
                    action:@selector(annotationButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    customPinView.rightCalloutAccessoryView = rightButton;
    
    return customPinView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    appState.selectedLatitude = view.annotation.coordinate.latitude;
    appState.selectedLongitude = view.annotation.coordinate.longitude;
    appState.selectedPlaceName = view.annotation.title;
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
        
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            
            NSString* subThoroghfare = item.placemark.subThoroughfare ? item.placemark.subThoroughfare : @"";
            NSString* thoroghfare = item.placemark.thoroughfare ? item.placemark.thoroughfare : @"";
            NSString* postalCode = item.placemark.postalCode ? item.placemark.postalCode : @"";
            
            annotation.title = item.name;
            annotation.subtitle = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@",
                                   subThoroghfare,
                                   thoroghfare,
                                   postalCode,
                                   item.placemark.locality,
                                   item.placemark.country];
            annotation.coordinate = item.placemark.location.coordinate;
            
            [annotations addObject:annotation];
        }];
        
        [mainMapView removeAnnotations:mainMapView.annotations];
        [mainMapView addAnnotations:annotations];
        if(mainMapView.annotations.count > 0)
            [mainMapView selectAnnotation:[mainMapView.annotations objectAtIndex:0] animated:YES];
        
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
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
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

@end
