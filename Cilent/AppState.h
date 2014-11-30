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

@property CGRect screenRect;
@property CGRect landscapeScreenRect;
@property CGFloat screenWidth;
@property CGFloat screenHeight;
@property UIColor* buttonBgColor;
@property UIColor* buttonTextColor;
@property UIFont* buttonFont;
@property UIFont* tinyFont;
@property double currentLatitude;
@property double currentLongitude;

+(id)getInstance;

@end
