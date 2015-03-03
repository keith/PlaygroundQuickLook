@import CoreFoundation;
@import CoreServices;
@import QuickLook;
@import Foundation;
#import "PlaygroundHelper.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    if (QLThumbnailRequestIsCancelled(thumbnail)) {
        return noErr;
    }

    NSURL *baseURL = (__bridge NSURL *)(url);
    PlaygroundHelper *helper = [[PlaygroundHelper alloc] initWithFileURL:[baseURL URLByAppendingPathComponent:@"contents.swift"]];
    __block NSData *data = nil;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [helper parseWithCompletionBlock:^(NSArray *files, NSError *error) {
            if (!error) {
                data = [helper dataFromFiles:files relativeToURL:baseURL];
            }
        }];
    });

    QLThumbnailRequestSetImageWithData(thumbnail, (__bridge CFDataRef)(data), NULL);
    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
