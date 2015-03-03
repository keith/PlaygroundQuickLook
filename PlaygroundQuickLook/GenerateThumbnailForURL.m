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
    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
