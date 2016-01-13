//
//  SimpleTableCell.m
//  test2
//
//  Created by razomer on 1/11/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize nameLabel = _nameLabel;
@synthesize adress = _adress;
@synthesize tell = _tell;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize progressViewer = _progressViewer;
@synthesize priceViewer = _priceViewer;
@synthesize priceLable = _priceLable;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
