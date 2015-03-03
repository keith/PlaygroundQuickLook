@import CoreFoundation;
@import CoreServices;
@import QuickLook;
@import Foundation;
#import "PlaygroundHelper.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    if (QLPreviewRequestIsCancelled(preview)) {
        return noErr;
    }

    __block NSData *data = nil;
    NSURL *baseURL = (__bridge NSURL *)(url);
    NSURL *contentsSwiftURL = [baseURL URLByAppendingPathComponent:@"contents.swift"];
    if ([contentsSwiftURL checkResourceIsReachableAndReturnError:nil]) {
        data = [[NSData alloc] initWithContentsOfURL:contentsSwiftURL];
    } else {
        PlaygroundHelper *helper = [[PlaygroundHelper alloc] initWithFileURL:[baseURL URLByAppendingPathComponent:@"contents.xcplayground"]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [helper parseWithCompletionBlock:^(NSArray *files, NSError *error) {
                if (!error) {
                    data = [helper dataFromFiles:files relativeToURL:baseURL];
                }
            }];
        });
    }

    QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)(data), kUTTypePlainText, NULL);
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
