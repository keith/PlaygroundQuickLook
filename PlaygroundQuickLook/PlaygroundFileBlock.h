//
//  PlaygroundFileBlock.h
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 7/11/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

@protocol PlaygroundFileBlock <NSObject>

@property (nonatomic, readonly) NSString *fileName;

- (instancetype)initWithFileName:(NSString *)fileName;

@end
