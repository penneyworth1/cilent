//
//  ViewUtil.h
//  Cilent
//
//  Created by Steven Stewart on 10/21/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewUtil : NSObject

+(UIButton*)getButton:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(NSString*)text :(UIColor*)textColor :(UIFont*)font :(CGFloat)cornerRadius;
+(UIActivityIndicatorView*)getLoadingSpinner:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius;


@end
