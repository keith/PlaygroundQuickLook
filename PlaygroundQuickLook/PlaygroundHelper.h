//
//  PlaygroundHelper.h
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

@import Foundation;

typedef void (^PlaygroundParserCompletionBlock)(NSArray *files, NSError *error);

@interface PlaygroundHelper : NSObject <NSXMLParserDelegate>

- (instancetype)initWithFileURL:(NSURL *)fileURL;

- (void)parseWithCompletionBlock:(PlaygroundParserCompletionBlock)completionBlock;
- (NSData *)dataFromFiles:(NSArray *)files relativeToURL:(NSURL *)URL;

@end
