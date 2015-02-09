//
//  AppDelegate.m
//  Cilent
//
//  Created by Steven Stewart on 10/12/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    appState = [AppState getInstance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    tutorialPageViewController = [[TutorialPageViewController alloc] initWithNibName:nil bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:tutorialPageViewController];
    [self.navController setNavigationBarHidden:YES animated:YES];
    [[self window] setRootViewController:self.navController];
    
    //Change the color of the dots on the tutorial screens.
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[TutorialPageViewController class], nil];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3f];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        locationManager.pausesLocationUpdatesAutomatically = NO;
        
        if([appState getBatterySaverMode])
            [self startUpdatingSignificantLocationChanges];
        else
            [self startUpdatingAccurateLocationChanges];
    }
    
    [self registerForNotifications];
    
    return YES;
}

-(void)startUpdatingAccurateLocationChanges
{
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
    updatingAccurateLocations = true;
}
-(void)startUpdatingSignificantLocationChanges
{
    [locationManager stopUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
    updatingAccurateLocations = false;
}

- (void)registerForNotifications
{
    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"fail");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(updatingAccurateLocations && appState.batterySaverOn)
    {
        [self startUpdatingSignificantLocationChanges];
    }
    else if(!updatingAccurateLocations && !appState.batterySaverOn)
    {
        [self startUpdatingAccurateLocationChanges];
    }
    
    
    for(CLLocation* loc in locations)
    {
        appState.currentLatitude = loc.coordinate.latitude;
        appState.currentLongitude = loc.coordinate.longitude;
        
        NSMutableArray* myPlaces = [appState getMyPlaces];
        
        for(Place *place in myPlaces)
        {
            CLLocation* placeLocation = [[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude];
            double distance = [loc distanceFromLocation:placeLocation];
            
            
            if(distance < place.radiusInMeters)
            {
                if(!place.currentlyInside)
                {
                    place.currentlyInside = true;
                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:0.5];
                    localNotification.alertBody = [NSString stringWithFormat:@"Entering %@",place.name];
                    localNotification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                    [appState updateMyPlaces:myPlaces];
                }
            }
            else if(place.currentlyInside)
            {
                place.currentlyInside = false;
                [appState updateMyPlaces:myPlaces];
            }
        }
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"notification");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //Clear the badge
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
