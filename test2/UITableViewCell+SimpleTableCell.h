//
//  UITableViewCell+SimpleTableCell.h
//  test2
//
//  Created by razomer on 1/11/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (SimpleTableCell)


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
