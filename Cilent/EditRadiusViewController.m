//
//  EditRadiusViewController.m
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "EditRadiusViewController.h"

@interface EditRadiusViewController ()

@end

@implementation EditRadiusViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppState* appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Radius";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [ViewUtil colorWithHexString:@"3FCCE5"];
    [self.view addSubview:vBackground];
    
    UIButton* btnSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSmall.frame = CGRectMake(0, 65, appState.screenWidth, 80);
    btnSmall.backgroundColor = [UIColor whiteColor];
    [btnSmall addTarget:self action:@selector(smallPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSmall];
    UILabel* lblSmall = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, appState.screenWidth-10, 30)];
    lblSmall.text = @"Small";
    lblSmall.font = appState.largeFont;
    [btnSmall addSubview:lblSmall];
    UIImageView* ivSmallArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnSmall addSubview:ivSmallArrow];
    
    UIButton* btnMedium = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMedium.frame = CGRectMake(0, 146, appState.screenWidth, 80);
    btnMedium.backgroundColor = [UIColor whiteColor];
    [btnMedium addTarget:self action:@selector(mediumPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMedium];
    UILabel* lblMedium = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, appState.screenWidth-10, 30)];
    lblMedium.text = @"Medium";
    lblMedium.font = appState.largeFont;
    [btnMedium addSubview:lblMedium];
    UIImageView* ivMediumArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnMedium addSubview:ivMediumArrow];
    
    UIButton* btnLarge = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLarge.frame = CGRectMake(0, 227, appState.screenWidth, 80);
    btnLarge.backgroundColor = [UIColor whiteColor];
    [btnLarge addTarget:self action:@selector(largePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLarge];
    UILabel* lblLarge = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, appState.screenWidth-10, 30)];
    lblLarge.text = @"Large";
    lblLarge.font = appState.largeFont;
    [btnLarge addSubview:lblLarge];
    UIImageView* ivLargeArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnLarge addSubview:ivLargeArrow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)smallPressed
{
    self.place.radiusInMeters = 10;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)mediumPressed
{
    self.place.radiusInMeters = 25;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)largePressed
{
    self.place.radiusInMeters = 50;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
