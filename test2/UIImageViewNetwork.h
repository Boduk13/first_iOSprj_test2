//
//  UIImageViewNetwork.h
//  test2
//
//  Created by razomer on 1/13/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableCell.h"

@interface UIImageView(Network)

@property (nonatomic, copy) NSURL *imageURL;

- (void) loadImageFromURL:(NSURL*)url placeholderImage:(UIImage*)placeholder cachingKey:(NSString*)key tableCell:(SimpleTableCell *)cell;

@end