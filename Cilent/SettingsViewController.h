//
//  SettingsViewController.h
//  Cilent
//
//  Created by Steven Stewart on 1/11/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppState.h"
#import "ViewUtil.h"

@interface SettingsViewController : UIViewController
{
    AppState* appState;
    UISwitch* swBatterySaver;
}

@end
