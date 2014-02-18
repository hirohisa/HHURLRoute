//
//  HHURLRouteTests.m
//  HHURLRouteTests
//
//  Created by Hirohisa Kawasaki on 2014/02/17.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HHURLRoute.h"

@interface NSURL (HHURLRoute)

- (NSArray *)routeComponentsWithSeparator:(NSString *)separator;

@end

@interface HHURLRouteTests : XCTestCase

@end

@implementation HHURLRouteTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDictionaryWithRouteComponent
{
    NSDictionary *result;
    id validKey, validParameters;


    result = [NSDictionary dictionaryWithRouteComponent:@"host" separator:@"-"];
    validKey = @"host";
    validParameters = @[];
    XCTAssertTrue([result.routeKey isEqual:validKey],
                  @"result key %@ is fail", result.routeKey);
    XCTAssertTrue([result.routeParameters isEqual:validParameters],
                  @"result key %@ is fail", result.routeParameters);

    result = [NSDictionary dictionaryWithRouteComponent:@"path-query" separator:@"-"];
    validKey = @"path";
    validParameters = @[@"query"];
    XCTAssertTrue([result.routeKey isEqual:validKey],
                  @"result key %@ is fail", result.routeKey);
    XCTAssertTrue([result.routeParameters isEqual:validParameters],
                  @"result key %@ is fail", result.routeParameters);
}

- (void)testRouteComponents
{
    NSURL *URL;
    id result, valid;

    URL = [NSURL URLWithString:@"app://example"];
    result = [URL routeComponentsWithSeparator:@"-"];
    valid = @[];
    XCTAssertTrue([result isEqual:valid],
                  @"result %@ is fail", result);

    URL = [NSURL URLWithString:@"app://example/path-query"];
    result = [URL routeComponentsWithSeparator:@"-"];

    valid = @{
              HHURLRouteKey:@"path",
              HHURLRouteParametersKey:@[@"query"]
              };
    XCTAssertTrue([result count] == 1,
                  @"result %@ is fail", result);
    XCTAssertTrue([result[0][HHURLRouteKey] isEqual:valid[HHURLRouteKey]],
                  @"result[0][HHURLRouteKey] %@ is fail", result);
    XCTAssertTrue([result[0][HHURLRouteParametersKey] isEqual:valid[HHURLRouteParametersKey]],
                  @"result[0][HHURLRouteParametersKey] %@ is fail", result);

    URL = [NSURL URLWithString:@"app://"];
    result = [URL routeComponentsWithSeparator:@"-"];
    valid = @[];
    XCTAssertTrue([result isEqual:valid],
                  @"result %@ is fail", result);

    URL = nil;
    result = [URL routeComponentsWithSeparator:@"-"];
    XCTAssertNil(result,
                 @"result %@ is fail", result);
}

@end
