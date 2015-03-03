//
//  PlaygroundHelper.m
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

@import Cocoa;
#import "PlaygroundHelper.h"

@interface PlaygroundHelper ()

@property (nonatomic) NSURL *contentsFile;

@end

@implementation PlaygroundHelper


- (instancetype)initWithFileURL:(NSURL *)fileURL
{
    self = [super init];
    if (!self) return nil;
    self.contentsFile = fileURL;
    return self;
}

- (NSData *)dataFromFile
{
    NSMutableData *data = [NSMutableData data];
    NSData *fileData = [NSData dataWithContentsOfURL:self.contentsFile];
    [data appendData:fileData];
    [data appendData:[@"\n\n" dataUsingEncoding:NSUTF8StringEncoding]];

    return data;
}

@end
