//
//  DemoViewController.m
//  HHURLRoute Example
//
//  Created by Hirohisa Kawasaki on 2014/02/17.
//  Copyright (c) 2014年 LINE. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)setRouteParameters:(NSArray *)routeParameters
{
    NSLog(@"parameters %@", routeParameters);
}

- (void)setRouteQuery:(NSString *)routeQuery
{
    NSLog(@"Query %@", routeQuery);
}

@end
