//
//  PlaygroundHelper.h
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

@import Foundation;

@interface PlaygroundHelper : NSObject

- (instancetype)initWithFileURL:(NSURL *)fileURL;

- (NSData *)dataFromFile;

@end
