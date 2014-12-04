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
            appState.mediumFont = [UIFont fontWithName:@"ArialMT" size:15];
            appState.tinyFont = [UIFont fontWithName:@"ArialMT" size:10];
        }
    }
    return appState;
}

-(NSMutableArray*)getMyPlaces
{
    if(!myPlaces)
    {
        NSData *myPlacesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myPlaces"];
        NSArray *placesArray = [NSKeyedUnarchiver unarchiveObjectWithData:myPlacesData];
        
        if(!placesArray)
        {
            myPlaces = [[NSMutableArray alloc] init];
        }
        else
        {
            myPlaces = [placesArray mutableCopy];
        }
    }
    return myPlaces;
}

-(void)updateMyPlaces:(NSMutableArray*)updatedPlacesArray
{
    myPlaces = updatedPlacesArray;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataToSave = [NSKeyedArchiver archivedDataWithRootObject:myPlaces];
    [[NSUserDefaults standardUserDefaults] setObject:dataToSave forKey:@"myPlaces"];

    [defaults synchronize];
}

@end
