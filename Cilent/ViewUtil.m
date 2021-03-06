//
//  ViewUtil.m
//  Cilent
//
//  Created by Steven Stewart on 10/21/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(UIButton*)getButton:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(NSString*)text :(UIColor*)textColor :(UIFont*)font :(CGFloat)cornerRadius :(NSString*)bgImageName :(bool)dropShadow :(float)imageInsetTop :(float)imageInsetLeft :(float)imageInsetBottom :(float)imageInsetRight
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.clipsToBounds = YES;
    button.layer.cornerRadius = cornerRadius;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [button setBackgroundColor:bgColor];
    button.frame = CGRectMake(x, y, width, height);
    
    if(bgImageName != nil)
    {
        UIImage *image = [[UIImage imageNamed:bgImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(imageInsetTop, imageInsetLeft, imageInsetBottom, imageInsetRight)];
        [button setImage:image forState:UIControlStateNormal];
    }
    else
    {
        [button setTitleColor:textColor forState:UIControlStateNormal];
        [button setTitle:text forState:UIControlStateNormal];
        [button.titleLabel setFont:font];
    }
    
    if(dropShadow)
    {
        [ViewUtil addDropShadow:button];
    }
    
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

+(UIView*)getRoundedBox:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius :(bool)dropShadow
{
    UIView* vBox = [[UIView alloc] init];
    [vBox setBackgroundColor:bgColor];
    vBox.clipsToBounds = YES;
    vBox.layer.cornerRadius = cornerRadius;
    vBox.frame = CGRectMake(x, y, width, height);
    
    if(dropShadow)
    {
        [ViewUtil addDropShadow:vBox];
    }
    
    return vBox;
}

+(UIToolbar*)getRoundedToolBar:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius :(bool)dropShadow
{
    UIToolbar* vBox = [[UIToolbar alloc] init];
    //[vBox setBackgroundColor:bgColor];
    vBox.clipsToBounds = YES;
    vBox.layer.cornerRadius = cornerRadius;
    vBox.frame = CGRectMake(x, y, width, height);
    
//    if(dropShadow)
//    {
//        [ViewUtil addDropShadow:vBox];
//    }
    
    return vBox;
}

+(UIImageView*)getImageView:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(NSString*)imageName
{
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(x, y, width, height);
    UIImage* image = [UIImage imageNamed:imageName];
    imageView.image = image;
    
    return imageView;
}
+(UITextView*)getTextView:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)textColor :(UIFont*)font :(NSString*)text
{
    UITextView* textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(x, y, width, height);
    [textView setTextColor:textColor];
    textView.text = text;
    [textView setFont:font];
    [textView setEditable:NO];
    
    return textView;
}

+(UITextField*)getTextField:(CGFloat)x :(CGFloat)y :(CGFloat)width :(CGFloat)height :(UIColor*)bgColor :(CGFloat)cornerRadius
{
    UITextField* textField = [[UITextField alloc] init];
    [textField setFont:[UIFont fontWithName:@"ArialMT" size:20]];
    [textField setBackgroundColor:bgColor];
    textField.clipsToBounds = YES;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.layer.cornerRadius = cornerRadius;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.frame = CGRectMake(x, y, width, height);
    
    return textField;
}

+(void)addDropShadow:(UIView*)view
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);
    view.layer.shadowOpacity = 0.5f;
    view.layer.shadowPath = shadowPath.CGPath;
}

@end
