//
//  PlaceAnnotationView.h
//  Cilent
//
//  Created by Steven Stewart on 1/6/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AppState.h"

@interface PlaceAnnotationView : MKAnnotationView
{
    
}

@property bool preventSelectionChange;
@property NSString* addressString;

@end
