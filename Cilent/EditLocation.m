//
//  EditLocation.m
//  Cilent
//
//  Created by Steven Stewart on 1/8/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "EditLocation.h"

@implementation EditLocation

- (void)viewDidLoad
{
    AppState* appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Edit Location";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(savePlace)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [ViewUtil colorWithHexString:@"3FCCE5"];
    [self.view addSubview:vBackground];
    
    UIView* vSelectedPlaceInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 64, appState.screenWidth, 80)];
    vSelectedPlaceInfo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vSelectedPlaceInfo];
    
    self.lblOriginalPlaceName = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, appState.screenWidth-10, 30)];
    self.lblOriginalPlaceName.text = self.place.name;
    self.lblOriginalPlaceName.font = appState.largeFont;
    [vSelectedPlaceInfo addSubview:self.lblOriginalPlaceName];
    
    UILabel* lblOriginalPlaceAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, appState.screenWidth-10, 30)];
    lblOriginalPlaceAddress.text = self.place.address;
    lblOriginalPlaceAddress.font = appState.mediumFont;
    [vSelectedPlaceInfo addSubview:lblOriginalPlaceAddress];
    
    UIButton* btnRadiusInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRadiusInfo.frame = CGRectMake(0, 145, appState.screenWidth, 80);
    btnRadiusInfo.backgroundColor = [UIColor whiteColor];
    [btnRadiusInfo addTarget:self action:@selector(radiusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRadiusInfo];
    
    self.lblRadiusInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, appState.screenWidth-10, 30)];
    self.lblRadiusInfo.text = @"Notification Radius: ";
    self.lblRadiusInfo.font = appState.buttonFont;
    [btnRadiusInfo addSubview:self.lblRadiusInfo];
    
    UILabel* lblRadiusInstructions = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, appState.screenWidth-10, 30)];
    lblRadiusInstructions.text = @"Tap to edit the notification radius";
    lblRadiusInstructions.font = appState.mediumFont;
    [btnRadiusInfo addSubview:lblRadiusInstructions];
    
    UIImageView* ivRadiusRightArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnRadiusInfo addSubview:ivRadiusRightArrow];
    
    UIButton* btnNameInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNameInfo.frame = CGRectMake(0, 226, appState.screenWidth, 80);
    btnNameInfo.backgroundColor = [UIColor whiteColor];
    [btnNameInfo addTarget:self action:@selector(nameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNameInfo];
    
    self.lblNameInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, appState.screenWidth-60, 30)];
    self.lblNameInfo.text = [NSString stringWithFormat:@"%@%@",@"Location Name: ",self.place.name];
    self.lblNameInfo.font = appState.buttonFont;
    [btnNameInfo addSubview:self.lblNameInfo];
    
    UILabel* lblNameInstructions = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, appState.screenWidth-10, 30)];
    lblNameInstructions.text = @"Tap to edit this location name";
    lblNameInstructions.font = appState.mediumFont;
    [btnNameInfo addSubview:lblNameInstructions];
    
    UIImageView* ivNameRightArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnNameInfo addSubview:ivNameRightArrow];
    
    if(self.place.isSaved)
    {
        self.btnRemoveThisLocation = [UIButton buttonWithType:UIButtonTypeCustom];;
        self.btnRemoveThisLocation.frame = CGRectMake(0, 346, appState.screenWidth, 80);
        self.btnRemoveThisLocation.backgroundColor = [UIColor redColor];
        [self.btnRemoveThisLocation addTarget:self action:@selector(removePlacePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.btnRemoveThisLocation];
        
        UILabel* lblRemoveThisLocation = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, appState.screenWidth, 40)];
        lblRemoveThisLocation.text = @"Remove this location";
        lblRemoveThisLocation.textColor = [UIColor whiteColor];
        lblRemoveThisLocation.font = appState.largeFont;
        lblRemoveThisLocation.textAlignment = NSTextAlignmentCenter;
        [self.btnRemoveThisLocation addSubview: lblRemoveThisLocation];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.place.radiusInMeters <= 10.1)
        self.lblRadiusInfo.text = @"Notification Radius: Small";
    else if(self.place.radiusInMeters <= 25.1)
        self.lblRadiusInfo.text = @"Notification Radius: Medium";
    else
        self.lblRadiusInfo.text = @"Notification Radius: Large";
    
    self.lblNameInfo.text = [NSString stringWithFormat:@"%@%@",@"Location Name: ",self.place.name];
    self.lblOriginalPlaceName.text = self.place.name;
}

-(void)removePlacePressed
{
    AppState* appState = [AppState getInstance];
    NSMutableArray* currentPlaces = [appState getMyPlaces];
    [currentPlaces removeObject:self.place];
    [appState updateMyPlaces:currentPlaces];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)radiusButtonPressed
{
    EditRadiusViewController *nextViewController = [[EditRadiusViewController alloc] init];
    nextViewController.place = self.place;
    [[self navigationController] pushViewController:nextViewController animated:YES];
}
-(void)nameButtonPressed
{
    EditNameViewController *nextViewController = [[EditNameViewController alloc] init];
    nextViewController.place = self.place;
    [[self navigationController] pushViewController:nextViewController animated:YES];
}

-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)savePlace
{
    AppState* appState = [AppState getInstance];
    NSMutableArray* currentPlaces = [appState getMyPlaces];
    
    if(!self.place.isSaved)
    {
        self.place.isSaved = true;
        [currentPlaces addObject:self.place];
    }
    
    [appState updateMyPlaces:currentPlaces];
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
