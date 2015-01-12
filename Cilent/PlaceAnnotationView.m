//
//  PlaceAnnotationView.m
//  Cilent
//
//  Created by Steven Stewart on 1/6/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "PlaceAnnotationView.h"

@implementation PlaceAnnotationView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    AppState* appState = [AppState getInstance];
    appState.preventAnnotationDeselection = false;
    if (hitView != nil)
    {
        appState.preventAnnotationDeselection = true;
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
            {
                break;
            }
        }
    }
    return isInside;
}


@end
