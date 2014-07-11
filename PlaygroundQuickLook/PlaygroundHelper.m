//
//  PlaygroundHelper.m
//  PlaygroundQuickLook
//
//  Created by Keith Smiley on 6/20/14.
//  Copyright (c) 2014 smileykeith. All rights reserved.
//

@import Cocoa;
#import "CodeBlock.h"
#import "DocumentationBlock.h"
#import "PlaygroundFileBlock.h"
#import "PlaygroundHelper.h"

@interface PlaygroundHelper ()

@property (nonatomic) NSXMLParser *parser;
@property (nonatomic) NSMutableArray *dataFiles;
@property (nonatomic, copy) PlaygroundParserCompletionBlock parseCompletionBlock;

@end

@implementation PlaygroundHelper

static NSString * const FileName = @"section-1.swift";

- (instancetype)initWithFileURL:(NSURL *)fileURL
{
    self = [super init];
    if (!self) return nil;

    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    self.parser.delegate = self;

    return self;
}

- (void)parseWithCompletionBlock:(PlaygroundParserCompletionBlock)completionBlock
{
    self.parseCompletionBlock = completionBlock;
    [self.parser parse];
}

- (NSData *)dataFromFiles:(NSArray *)files relativeToURL:(NSURL *)URL
{
    NSMutableData *data = [NSMutableData data];
    for (id <PlaygroundFileBlock> file in files) {
        NSURL *fileURL = [URL URLByAppendingPathComponent:[file fileName]];
        NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
        if ([file isKindOfClass:[DocumentationBlock class]]) {
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTML:[NSData dataWithContentsOfURL:fileURL] baseURL:nil documentAttributes:nil];
            fileData = [attributedString.string dataUsingEncoding:NSUTF8StringEncoding];
        }

        [data appendData:fileData];
        [data appendData:[@"\n\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }

    return data;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.dataFiles = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    id <PlaygroundFileBlock> fileBlock;
    if ([elementName isEqualToString:@"code"]) {
        CodeBlock *codeBlock = [[CodeBlock alloc] initWithFileName:attributeDict[@"source-file-name"]];
        fileBlock = codeBlock;
    } else if ([elementName isEqualToString:@"documentation"]) {
        DocumentationBlock *documentationBlock = [[DocumentationBlock alloc] initWithFileName:attributeDict[@"relative-path"]];
        fileBlock = documentationBlock;
    }

    if (fileBlock) {
        [self.dataFiles addObject:fileBlock];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.parseCompletionBlock(nil, parseError);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.parseCompletionBlock(self.dataFiles, nil);
    self.dataFiles = nil;
}

@end
