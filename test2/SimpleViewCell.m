//
//  SimpleViewCell.m
//  test2
//
//  Created by razomer on 1/6/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import "SimpleViewCell.h"

@implementation SimpleViewCell
@synthesize etailerName= _etailerName;
@synthesize logoPath = logoPath;


- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
