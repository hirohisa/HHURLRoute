//
//  HHURLRoute.h
//  HHURLRoute
//
//  Created by Hirohisa Kawasaki on 2014/02/17.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

@import Foundation;
@import UIKit;

extern NSString * const HHURLRouteKey;
extern NSString * const HHURLRouteParametersKey;

@interface NSDictionary (HHURLRoute)

- (NSString *)routeKey;
- (NSArray  *)routeParameters; // default is @[]
- (NSString *)routeQuery;

+ (instancetype)dictionaryWithRouteKey:(NSString *)routeKey routeParameters:(NSArray *)routeParameters;
+ (instancetype)dictionaryWithRouteComponent:(NSString *)routeComponent separator:(NSString *)separator;

@end

@protocol HHURLRouteViewControllerProtocol

@optional
- (void)setRoute:(NSDictionary *)route;
- (void)setRouteParameters:(NSArray *)routeParameters;
- (void)setRouteQuery:(NSString *)routeQuery;

@end

@interface UIViewController (HHURLRoute)

<HHURLRouteViewControllerProtocol>

@end

@interface HHURLRoute : NSURL

@property (nonatomic, strong) NSString *routeComponentSeparator; // default is `-`

//
// theirs properties are components parsed or separated form URL.
//
@property (nonatomic, readonly) NSDictionary *routeHost;
@property (nonatomic, readonly) NSArray *routePathComponents;

+ (instancetype)URLRouteWithURL:(NSURL *)URL;
+ (instancetype)URLRouteWithString:(NSString *)URLString;

@end
