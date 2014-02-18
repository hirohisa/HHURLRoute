//
//  AppDelegate.m
//  HHURLRoute Example
//
//  Created by Hirohisa Kawasaki on 2014/02/17.
//  Copyright (c) 2014年 LINE. All rights reserved.
//

#import "AppDelegate.h"
#import "HHURLRoute.h"
#import "DemoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [self rootViewController];

    NSURL *URL = [NSURL URLWithString:@"app://example/sample-query/test-params1-params2"];
    [self openURL:URL];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)openURL:(NSURL *)URL
{
    HHURLRoute *URLRoute =[HHURLRoute URLRouteWithURL:URL];

    NSMutableArray *viewControllers = [@[] mutableCopy];
    for (NSDictionary *routePathComponent in URLRoute.routePathComponents) {
        DemoViewController *vc = [[DemoViewController alloc] init];
        [vc setRouteParameters:routePathComponent.routeParameters];
        [vc setRouteQuery:routePathComponent.routeQuery];
    }

    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    [navigationController setViewControllers:[viewControllers copy] animated:YES];
}

- (UIViewController *)rootViewController
{
    UIViewController *viewController = [[UIViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{}

- (void)applicationDidEnterBackground:(UIApplication *)application
{}

- (void)applicationWillEnterForeground:(UIApplication *)application
{}

- (void)applicationDidBecomeActive:(UIApplication *)application
{}

- (void)applicationWillTerminate:(UIApplication *)application
{}

@end
