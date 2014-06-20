//
//  PlaygroundQuickLookTests.m
//  PlaygroundQuickLookTests
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlaygroundHelper.h"

@interface PlaygroundQuickLookTests : XCTestCase

@end

@interface PlaygroundHelper ()

+ (NSArray *)matchesForFiles:(NSArray *)files;

@end

@implementation PlaygroundQuickLookTests

- (void)testMatchesForFiles
{
    NSString *baseURLString = @"file:///Users/foo";
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSArray *files = @[[NSURL URLWithString:@"foo.noise" relativeToURL:baseURL], [NSURL URLWithString:@"bar.swift" relativeToURL:baseURL], [NSURL URLWithString:@"section-1.swift" relativeToURL:baseURL]];
    NSArray *matches = [PlaygroundHelper matchesForFiles:files];
    XCTAssertEqual(matches.count, 2, @"%@ should only have 2 items", matches);
    XCTAssertTrue([[matches.firstObject lastPathComponent] isEqualToString:@"section-1.swift"], @"");
    XCTAssertTrue([[matches.lastObject lastPathComponent] isEqualToString:@"bar.swift"], @"");
}

@end
