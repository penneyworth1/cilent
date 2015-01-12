//
//  EditNameViewController.h
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppState.h"
#import "ViewUtil.h"
#import "Place.h"

@interface EditNameViewController : UIViewController <UITextFieldDelegate>

@property Place* place;
@property NSString* tempName;

@end
