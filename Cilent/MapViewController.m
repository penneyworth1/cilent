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
    
//    avSearch = [[UIAlertView alloc]initWithTitle:@"Search For Places" message:@"Please enter an address or keyword." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    avSearch.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [avSearch textFieldAtIndex:0].delegate = self;
    
    avMarkCurrentLocation = [[UIAlertView alloc]initWithTitle:@"Add Location" message:@"Please enter a name for this location." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    avMarkCurrentLocation.alertViewStyle = UIAlertViewStylePlainTextInput;
    [avMarkCurrentLocation textFieldAtIndex:0].delegate = self;
    
    
    
}

- (void) viewDidAppear:(BOOL)animated
{
    
}



- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    request.region = mapView.region;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if([alertView isEqual:avSearch])
//    {
//        if(buttonIndex == 1) //Ok pressed on the search dialog.
//            [self searchEntered];
//        
//    }
    if([alertView isEqual:avMarkCurrentLocation])
    {
        
    }
}

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

-(void)annotationButtonPressed
{
    [avMarkCurrentLocation show];
}

-(void)searchEntered
{
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSLog(@"Map Items: %@", response.mapItems);
        
        NSMutableArray *annotations = [NSMutableArray array];
        
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            
            annotation.title = item.name;
            annotation.subtitle = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@",
                                   item.placemark.subThoroughfare,
                                   item.placemark.thoroughfare,
                                   item.placemark.postalCode,
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString
{
    if(textField == tfSearch)
    {
        request.naturalLanguageQuery = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
    }
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES]; //Dismiss keyboard
    [super touchesBegan:touches withEvent:event];
}

@end
