//
//  ViewController.h
//  test2
//
//  Created by razomer on 1/5/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableCell.h"

@interface ViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>
{
    IBOutlet UITableView* _tableView;
    NSMutableData *_responseData;
    NSString *_json_url;
    UILabel *nameEt;
 

    
}


@end

