//
//  ViewUtil.m
//  Cilent
//
//  Created by Steven Stewart on 10/21/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(UIButton*)getButton:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(NSString*)text :(UIColor*)textColor :(UIFont*)font :(CGFloat)cornerRadius
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundColor:bgColor];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = cornerRadius;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.frame = CGRectMake(x, y, width, height);
    
    return button;
}

+(UIActivityIndicatorView*)getLoadingSpinner:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius
{
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(x,y,width,height)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    spinner.clipsToBounds = YES;
    spinner.backgroundColor = bgColor;
    spinner.layer.cornerRadius = cornerRadius;
    return spinner;
}

@end
