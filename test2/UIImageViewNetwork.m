//
//  UIImageViewNetwork.m
//  test2
//
//  Created by razomer on 1/13/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import "UIImageViewNetwork.h"
#import "FTWCache.h"
#import <objc/runtime.h>
#import "SimpleTableCell.h"

static char URL_KEY;


@implementation UIImageView(Network)

@dynamic imageURL;

- (void) loadImageFromURL:(NSURL*)url placeholderImage:(UIImage*)placeholder cachingKey:(NSString*)key tableCell:(SimpleTableCell *)cell {
    self.imageURL = url;
    self.image = placeholder;
    
    NSData *cachedData = [FTWCache objectForKey:key];
    if (cachedData) {
        self.imageURL   = nil;
        self.image      = [UIImage imageWithData:cachedData];
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        //add animation
        [cell.progressViewer startAnimating];
        cell.thumbnailImageView.hidden = true;
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *imageFromData = [UIImage imageWithData:data];
        
        [FTWCache setObject:data forKey:key];
        
        if (imageFromData) {
            if ([self.imageURL.absoluteString isEqualToString:url.absoluteString]) {
    dispatch_async(dispatch_get_main_queue(), ^{
        
                    self.image = imageFromData;
        
                    //add animation
                    cell.thumbnailImageView.hidden = false;
                    [cell.progressViewer stopAnimating];
        
                });
            } else {
                				NSLog(@"urls are not the same, bailing out!");
            }
        }
        self.imageURL = nil;
    });
}

- (void) setImageURL:(NSURL *)newImageURL {
    objc_setAssociatedObject(self, &URL_KEY, newImageURL, OBJC_ASSOCIATION_COPY);
}

- (NSURL*) imageURL {
    return objc_getAssociatedObject(self, &URL_KEY);
}

@end