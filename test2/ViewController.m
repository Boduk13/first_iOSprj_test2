//
//  ViewController.m
//  test2
//
//  Created by razomer on 1/5/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableCell.h"
#import "StationModel.h"
#import "UIImageViewNetwork.h"


@interface ViewController ()

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSString *json_url;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) UILabel *station_id;
@property (nonatomic, retain) StationModel *dataOfStation;
@property (nonatomic, retain) NSString * simpleTableIdentifier, *nibFileName;
@property (nonatomic, assign) int highOfRowCell;
@property (nonatomic, retain) CATransition *transition;



@end

@implementation ViewController

@synthesize responseData = _responseData;
@synthesize  json_url=_json_url;
@synthesize  tableData= _tableData;
@synthesize dataOfStation = _dataOfStation;
@synthesize simpleTableIdentifier = _simpleTableIdentifier;
@synthesize nibFileName = _nibFileName;
@synthesize highOfRowCell = _highOfRowCell;
@synthesize transition = _transition;

NSArray *dataFromJson = nil;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //init variables
    
    _json_url= @"http://gasvisor.com/fgws/v1/stationsWithin.json?latitude=48.954634&longitude=24.733985&radius=20";
    _simpleTableIdentifier = @"Cell";
    _nibFileName = @"SimpleTableCell";
    _highOfRowCell = 78;
    //end init
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableData = [NSMutableArray array];
    _dataOfStation = [NSMutableArray array];
    
    //settings of animation for item of list
    _transition = [CATransition animation];
    _transition.duration = 2.0f;
    _transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _transition.type = kCATransitionFade;
    
    
    //create request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_json_url]];

    // Create url connection
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //-------------
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//table view methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SimpleTableCell *cell = (SimpleTableCell *)[_tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:_nibFileName owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    StationModel *curentStModel = (StationModel * )[_tableData objectAtIndex:indexPath.row];
    
    //Log
    NSLog(@"Station name: %@, %@", [curentStModel nameSt], [curentStModel nameEth]);
    
    cell.progressViewer.color = [UIColor blackColor];
    cell.nameLabel.text =[curentStModel nameSt];
    
    cell.adress.text = [curentStModel adress];
    cell.tell.text = [curentStModel tell];
    cell.priceLable.text = [curentStModel price];
    
    
    //NSURL *url = [curentStModel imageUrl];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@",[curentStModel imageUrl]];
    
    NSLog(@"new URL Image = %@", urlstring);
    NSURL *url = [NSURL URLWithString:urlstring];
    
    
    [cell.thumbnailImageView loadImageFromURL:(NSURL*)url placeholderImage:[UIImage imageNamed:@"nofound_icon.png"]  cachingKey:(NSString*)[NSString stringWithFormat:@"%ld", indexPath.row] tableCell:cell];
    
    
    //add animation for image on list item
    //[cell.thumbnailImageView.layer addAnimation:_transition forKey:nil];
    
        return cell;
    }




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return (int) _highOfRowCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //animation for list item
    CATransform3D rotation;

    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
   
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    [UIView commitAnimations];
    
}

//-----


/// Connection and get json

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    NSLog(@"didReceiveResponse");
    _responseData = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSLog(@"didReceiveData");
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    NSLog(@"willCacheResponse");
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSLog(@"connectionDidFinishLoading");
   
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    
    ///Parse jsone
    NSMutableArray *for_count = [json valueForKey:@"stations"];
    int itemsInList = (int)[for_count count];
    
    for(int i=0; i<itemsInList; i++)
    {
     
        NSMutableDictionary *response = [[for_count objectAtIndex:i] mutableCopy];
        
            NSString *station_name = [response valueForKey:@"name"];
            NSString *imageUrl = [response valueForKey:@"imagePath"];
        
        
        NSMutableDictionary *etailer = [response valueForKey:@"etailer"];
        
            NSString *etailername = [etailer valueForKey:@"etailerName"];
        
        
        NSMutableDictionary *addressArr = [response valueForKey:@"address"];
       
            NSString *adress = [addressArr valueForKey:@"address"];
            NSString *phone;
        
        //check phone for null
        if ([response valueForKey:@"phone"] == (id)[NSNull null] || [response valueForKey:@"phone"] == 0 )
            phone = @"Tell not found!";
        else
            phone = [response valueForKey:@"phone"] ;
        //----
        
        
        StationModel *stModel =  [[StationModel alloc] init];
            stModel.nameSt = station_name;
            stModel.nameEth = etailername;
            stModel.imageUrl = imageUrl;
            stModel.adress = adress;
            stModel.tell = phone;
        
        [self.tableData addObject:stModel];
        
        NSLog( @"image url = %@", imageUrl );
        
    }//end loop
    
    
    [self.tableView reloadData];

    
}///----------End parse json

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"didFailWithError %@", error);
}


@end
