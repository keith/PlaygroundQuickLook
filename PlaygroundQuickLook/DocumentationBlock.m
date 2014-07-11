//
//  DocumentationBlock.m
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 7/11/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

#import "DocumentationBlock.h"

@implementation DocumentationBlock

@synthesize fileName = _fileName;

- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _fileName = fileName;

    return self;
}

- (NSString *)fileName
{
    return [NSString stringWithFormat:@"Documentation/%@", _fileName];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%p Description: %@>", self, self.fileName];
}

@end
