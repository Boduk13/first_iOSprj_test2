//
//  SimpleTableCell.h
//  test2
//
//  Created by razomer on 1/11/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *adress;
@property (nonatomic, weak) IBOutlet UILabel *tell;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressViewer;
@property (weak, nonatomic) IBOutlet UIView *priceViewer;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@end
