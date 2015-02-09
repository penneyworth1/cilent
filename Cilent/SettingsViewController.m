//
//  SettingsViewController.m
//  Cilent
//
//  Created by Steven Stewart on 1/11/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Settings";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [ViewUtil colorWithHexString:@"3FCCE5"];
    [self.view addSubview:vBackground];
    
    UIView* vBatterSaver = [[UIView alloc] initWithFrame:CGRectMake(0, 64, appState.screenWidth, 80)];
    vBatterSaver.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vBatterSaver];
    
    UILabel* lblBatterySaverTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, appState.screenWidth-10, 30)];
    lblBatterySaverTitle.text = @"Battery Saver Mode";
    lblBatterySaverTitle.font = appState.largeFont;
    [vBatterSaver addSubview:lblBatterySaverTitle];
    
    UILabel* lblBatterSaverText = [[UILabel alloc] initWithFrame:CGRectMake(10, 38, appState.screenWidth-10, 30)];
    lblBatterSaverText.text = @"Senses significant location changes.";
    lblBatterSaverText.font = appState.mediumFont;
    [vBatterSaver addSubview:lblBatterSaverText];
    
    UILabel* lblBatterSaverText2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 52, appState.screenWidth-10, 30)];
    lblBatterSaverText2.text = @"May be less accurate.";
    lblBatterSaverText2.font = appState.mediumFont;
    [vBatterSaver addSubview:lblBatterSaverText2];
    
    swBatterySaver = [[UISwitch alloc] initWithFrame:CGRectMake(appState.screenWidth-65, 24, 100, 50)];
    [vBatterSaver addSubview:swBatterySaver];
    if([appState getBatterySaverMode])
        [swBatterySaver setOn:YES];
    [swBatterySaver addTarget:self action:@selector(switched) forControlEvents:UIControlEventValueChanged];
    
    UIButton* btnRemoveAds = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRemoveAds.frame = CGRectMake(0, 145, appState.screenWidth, 80);
    btnRemoveAds.backgroundColor = [UIColor whiteColor];
    [btnRemoveAds addTarget:self action:@selector(removeAdsPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRemoveAds];
    UILabel* lblRemoveAds = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, appState.screenWidth-10, 30)];
    lblRemoveAds.text = @"Disable Ads";
    lblRemoveAds.font = appState.largeFont;
    [btnRemoveAds addSubview:lblRemoveAds];
    UIImageView* ivArrow = [ViewUtil getImageView:appState.screenWidth-50 :25 :30 :30 :@"RightArrow.png"];
    [btnRemoveAds addSubview:ivArrow];
}
-(void)removeAdsPressed
{
    
}
-(void)switched
{
    if(swBatterySaver.isOn)
    {
        [appState setBatterySaverMode:YES];
    }
    else
    {
        [appState setBatterySaverMode:NO];
    }
}
-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
