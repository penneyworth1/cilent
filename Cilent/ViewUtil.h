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

+(UIButton*)getButton:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(NSString*)text :(UIColor*)textColor :(UIFont*)font :(CGFloat)cornerRadius :(NSString*)bgImageName :(bool)dropShadow :(float)imageInsetTop :(float)imageInsetLeft :(float)imageInsetBottom :(float)imageInsetRight;
+(UIActivityIndicatorView*)getLoadingSpinner:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius;
+(UIView*)getRoundedBox:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius :(bool)dropShadow;
+(UIImageView*)getImageView:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(NSString*)imageName;
+(UITextField*)getTextField:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius;
+(UITextView*)getTextView:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)textColor :(UIFont*)font :(NSString*)text;
+(void)addDropShadow:(UIView*)view;

@end
