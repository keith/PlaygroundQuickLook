//
//  CodeBlock.m
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 7/11/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

#import "CodeBlock.h"

@implementation CodeBlock

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

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%p Code: %@>", self, self.fileName];
}

@end
