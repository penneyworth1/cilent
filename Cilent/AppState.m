//
//  AppState.m
//  Cilent
//
//  Created by Steven Stewart on 10/18/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "AppState.h"

@implementation AppState

+(id)getInstance
{
    static AppState *appState = nil;
    @synchronized(self)
    {
        if(appState == nil)
        {
            appState = [[self alloc] init];
            
            appState.screenRect = [[UIScreen mainScreen] bounds];
            appState.screenWidth = appState.screenRect.size.width;
            appState.screenHeight = appState.screenRect.size.height;
            appState.landscapeScreenRect = CGRectMake(0, 0, appState.screenRect.size.height, appState.screenRect.size.width);
            appState.buttonBgColor = [UIColor darkGrayColor];
            appState.buttonTextColor = [UIColor whiteColor];
            appState.buttonFont = [UIFont fontWithName:@"ArialMT" size:20];
            appState.tinyFont = [UIFont fontWithName:@"ArialMT" size:10];
        }
    }
    return appState;
}

@end
