//
//  Place.m
//  Cilent
//
//  Created by Steven Stewart on 12/1/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "Place.h"

@implementation Place

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.latitude = [decoder decodeDoubleForKey:@"latitude"];
    self.longitude = [decoder decodeDoubleForKey:@"longitude"];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.radiusInMeters = [decoder decodeDoubleForKey:@"radiusInMeters"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.latitude forKey:@"latitude"];
    [encoder encodeDouble:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeDouble:self.radiusInMeters forKey:@"radiusInMeters"];
}



@end
