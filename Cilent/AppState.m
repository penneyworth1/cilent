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
            appState.largeFont = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:22];
            appState.buttonFont = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:20];
            appState.mediumFont = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:15];
            appState.tinyFont = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:10];
            appState.currentLatitude = 0;
            appState.currentLongitude = 0;
            appState.preventAnnotationDeselection = false;
        }
    }
    return appState;
}

-(BOOL)getBatterySaverMode
{
    BOOL batterySaverOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"batterySaver"];
    self.batterySaverOn = batterySaverOn;
    return batterySaverOn;
}
-(void)setBatterySaverMode:(BOOL)batterySaverModeOn
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:batterySaverModeOn forKey:@"batterySaver"];
    [defaults synchronize];
    self.batterySaverOn = batterySaverModeOn;
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
-(void)updateMyPlaces
{
    [self updateMyPlaces:myPlaces];
}

@end
