//
//  HHURLRoute.m
//  HHURLRoute
//
//  Created by Hirohisa Kawasaki on 2014/02/17.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

#import "HHURLRoute.h"

NSString * const HHURLRouteKey = @"HHURLRouteKey";
NSString * const HHURLRouteParametersKey = @"HHURLRouteParametersKey";

NSString * const HHURLRouteSeparator = @"-";
NSString * const HHURLRouteSeparatorKey = @"HHURLRouteSeparatorKey";

@implementation NSDictionary (HHURLRoute)

- (NSString *)routeKey
{
    return [self objectForKey:HHURLRouteKey];
}

- (NSArray *)routeParameters
{
    return [self objectForKey:HHURLRouteParametersKey];
}

- (NSString *)routeQuery
{
    if (self.routeParameters) {
        return [self.routeParameters componentsJoinedByString:[self querySeparator]];
    }
    return nil;
}

- (NSString *)querySeparator
{
    if ([self objectForKey:HHURLRouteSeparatorKey]) {
        return [self objectForKey:HHURLRouteSeparatorKey];
    }
    return HHURLRouteSeparator;
}

+ (instancetype)dictionaryWithRouteKey:(NSString *)routeKey routeParameters:(NSArray *)routeParameters
{
    if (!routeKey) {
        return nil;
    }

    NSMutableDictionary *dictionary = [@{} mutableCopy];
    [dictionary setObject:routeKey forKey:HHURLRouteKey];
    if (routeParameters) {
        [dictionary setObject:routeParameters forKey:HHURLRouteParametersKey];
        [dictionary setObject:HHURLRouteSeparator forKey:HHURLRouteSeparatorKey];
    }
    

    return [dictionary copy];
}

+ (instancetype)dictionaryWithRouteComponent:(NSString *)routeComponent separator:(NSString *)separator
{
    if (!routeComponent) {
        return nil;
    }

    NSDictionary *dictionary;

    NSArray *components = [routeComponent componentsSeparatedByString:separator];
    if ([components count]) {
        NSArray *parameters = @[];
        if ([components count] > 1) {
            NSRange range = NSMakeRange(1, [components count]-1);
            parameters = [components subarrayWithRange:range];
        }
        dictionary = [NSDictionary dictionaryWithRouteKey:components[0] routeParameters:parameters];
    }
    return dictionary;
}
@end

@implementation UIViewController (HHURLRoute)

- (void)setRouteParameters:(NSArray *)routeParameters
{}

@end

@interface NSURL (HHURLRoute)

- (NSArray *)routeComponentsWithSeparator:(NSString *)separator;

@end

@implementation NSURL (HHURLRoute)

- (NSArray *)routeComponentsWithSeparator:(NSString *)separator
{
    NSMutableArray *components = [@[] mutableCopy];

    for (NSString *pathComponent in self.pathComponents) {
        if (pathComponent && [pathComponent length] && ![pathComponent isEqualToString:@"/"]) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithRouteComponent:pathComponent separator:separator];
            if (dictionary) {
                [components addObject:dictionary];
            }
        }
    }

    return [components copy];
}

@end

@interface HHURLRoute ()

@end

@implementation HHURLRoute

- (id)initWithString:(NSString *)URLString
{
    self = [super initWithString:URLString];
    return self;
}

- (NSString *)separator
{
    if (self.routeComponentSeparator) {
        return self.routeComponentSeparator;
    }
    return HHURLRouteSeparator;
}

- (NSDictionary *)routeHost
{
    return [NSDictionary dictionaryWithRouteComponent:self.host separator:[self separator]];
}

- (NSArray *)routePathComponents
{
    return [self routeComponentsWithSeparator:[self separator]];
}

+ (instancetype)URLRouteWithURL:(NSURL *)URL
{
    return [self URLRouteWithString:[URL absoluteString]];
}

+ (instancetype)URLRouteWithString:(NSString *)URLString
{
    return [[self alloc] initWithString:URLString];
}

@end