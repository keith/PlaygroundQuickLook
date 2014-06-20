//
//  PlaygroundHelper.m
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

#import "PlaygroundHelper.h"

@implementation PlaygroundHelper

static NSString * const FileName = @"section-1.swift";

+ (NSData *)dataForPlaygroundAtURL:(NSURL *)URL
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:URL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    if (contents.count < 1) {
        return nil;
    }

    NSArray *matches = [PlaygroundHelper matchesForFiles:contents];
    for (NSURL *file in matches) {
        NSData *data = [NSData dataWithContentsOfURL:file];
        if (data) {
            return data;
        }
    }

    return nil;
}

+ (NSArray *)matchesForFiles:(NSArray *)files
{
    NSMutableArray *matches = [NSMutableArray array];
    for (NSURL *file in files) {
        if ([file.lastPathComponent isEqualToString:FileName]) {
            [matches insertObject:file atIndex:0];
        } else if ([file.pathExtension isEqualToString:@"swift"]) {
            [matches addObject:file];
        }
    }

    return matches;
}

@end
