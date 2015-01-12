//
//  AppState.h
//  Cilent
//
//  Created by Steven Stewart on 10/18/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppState : NSObject
{
    NSMutableArray* myPlaces;
}

@property CGRect screenRect;
@property CGRect landscapeScreenRect;
@property CGFloat screenWidth;
@property CGFloat screenHeight;
@property UIColor* buttonBgColor;
@property UIColor* buttonTextColor;
@property UIFont* buttonFont;
@property UIFont* largeFont;
@property UIFont* mediumFont;
@property UIFont* tinyFont;
@property double currentLatitude;
@property double currentLongitude;
@property double selectedLatitude;
@property double selectedLongitude;
@property NSString* selectedPlaceName;
@property NSString* selectedPlaceAddress;
@property float bannerHeight;
@property bool preventAnnotationDeselection;
@property bool batterySaverOn;

+(id)getInstance;
-(NSMutableArray*)getMyPlaces;
-(void)updateMyPlaces:(NSMutableArray*)updatedPlacesArray;
-(void)updateMyPlaces;
-(BOOL)getBatterySaverMode;
-(void)setBatterySaverMode:(BOOL)batterySaverModeOn;

@end
