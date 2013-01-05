//
//  NearByViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NearByViewController.h"
#import "ShopDetailViewController.h"
#import "NearByCell.h"
@interface NearByViewController ()

@end

@implementation NearByViewController
@synthesize mLocation;
@synthesize mLatitude;
@synthesize mLongtitude;
@synthesize mShopArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近";
    self.navigationItem.leftBarButtonItem =nil;
    self.mShopArray = [NSMutableArray arrayWithCapacity:0];
    self.mLocation = [[CLLocationManager alloc]init];
    mpagnum = 0;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    if([self.mShopArray count]==0){
        self.mLongtitude = [NSNumber numberWithDouble:0.0];
        self.mLatitude = [NSNumber numberWithDouble:0.0];
        
        mLocation.delegate = self;
        mLocation.desiredAccuracy = kCLLocationAccuracyBest;
        [mLocation startUpdatingLocation];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [super dealloc];
    [mLocation release];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -LocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%f",newLocation.coordinate.longitude);
    self.mLongtitude = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
    self.mLatitude = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
    if (isLoading == NO)
    {
        isLoading = YES;
        mlogoBgView.hidden=YES;
        [dataHandler NearByShopListRequestRecord:mLongtitude :mLatitude :mpagnum*10 :(mpagnum+1)*10 :self];
    }
    [mLocation stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.mLongtitude = [NSNumber numberWithDouble:0.000001];
    self.mLatitude = [NSNumber numberWithDouble:0.000001];
    [mTableView reloadData];
}
#pragma mark -
#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isLoading = NO;
    [mTableView reloadData];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=NO;
    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络出错" message:@"网络无响应，请检查网络并稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString *results = [[NSString alloc]
                         initWithBytes:[receivedData bytes]
                         length:[receivedData length]
                         encoding:NSUTF8StringEncoding];
    NSLog(@"%@",results);
    [receivedData release];
    receivedData=nil;
    self.receivedData=[NSMutableData dataWithCapacity:512];
    NSDictionary *dic=(NSDictionary *)[results JSONValue] ;
    NSArray * result = (NSArray*)[dic objectForKey:@"data"];
    [mShopArray addObjectsFromArray:result];
    if ([result count]<10)
    {
        isEnding = YES;
    }
    isLoading = NO;
    [mTableView reloadData];
    mpagnum++;
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mShopArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mShopArray count]>0 ){
        //static NSString * tempNearByCell = @"NearByCell";
        NearByCell *cell =nil;//(NearByCell*)[tableView dequeueReusableCellWithIdentifier:tempNearByCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NearByCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSDictionary * mShopDetail = [mShopArray objectAtIndex:indexPath.row];//shop_id;shop_name;shop_addr;shop_cuisines;shop_logo;distance;
        cell.mShopNameLabel.text = [mShopDetail objectForKey:@"shop_name"];
        cell.mCuisinesLabel.text = [mShopDetail objectForKey:@"shop_cuisines"];
        cell.mAddressLabel.text = [NSString stringWithFormat:@"地址:%@",[mShopDetail objectForKey:@"shop_addr"]];
        cell.mDistanceLabel.text = [mShopDetail objectForKey:@"distance"];
        SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
        [tempDownLoader downloadWithURL:[NSURL URLWithString:[mShopDetail objectForKey:@"shop_logo"]] delegate:cell];
        
        int height=13;
        CGSize size = [cell.mShopNameLabel.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        CGRect frame = cell.mShopNameLabel.frame;
        frame.size=size;
        cell.mShopNameLabel.frame=frame;
        [cell.mShopNameLabel setNumberOfLines:0];
        height+=size.height;
        
        size = [cell.mCuisinesLabel.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        frame = cell.mCuisinesLabel.frame;
        frame.origin.y = height;
        frame.size=size;
        cell.mCuisinesLabel.frame = frame;
        [cell.mCuisinesLabel setNumberOfLines:0];
        height+=size.height;
        
        size = [cell.mDistanceLabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

        size = [cell.mAddressLabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(310-73-size.width-cell.mAddressLogo.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        frame = cell.mAddressLabel.frame;
        frame.origin.y = height;
        frame.size=size;
        cell.mAddressLabel.frame = frame;
        [cell.mAddressLabel setNumberOfLines:0];
        height+=size.height;
        
        size = [cell.mDistanceLabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        frame = cell.mDistanceLabel.frame;
        frame.origin.x=310-size.width;
        frame.origin.y = height-size.height;
        frame.size=size;
        cell.mDistanceLabel.frame = frame;
        [cell.mDistanceLabel setNumberOfLines:0];
        
        frame = cell.mAddressLogo.frame;
        frame.origin.x=cell.mDistanceLabel.frame.origin.x-frame.size.width;
        frame.origin.y=cell.mDistanceLabel.frame.origin.y+(cell.mDistanceLabel.frame.size.height-frame.size.height)/2;
        cell.mAddressLogo.frame = frame;
        
        frame = cell.mShopLogo.frame;
        frame.origin.y=(height+13-frame.size.height)/2;
        cell.mShopLogo.frame = frame;
        
        
        height+=13;
        frame = cell.mCellLineIV.frame;
        frame.origin.y=height-1;
        cell.mCellLineIV.frame = frame;
        return cell;
    }
    else{
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"PlaceholderCell"];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlaceholderCell"] autorelease];
			cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.detailTextLabel.backgroundColor=[UIColor clearColor];
			
		}
        
        if([self.mShopArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mShopArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mShopArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            if ([self.mLongtitude doubleValue]==0.0 && [self.mLatitude doubleValue]==0.0) {
                cell.detailTextLabel.text = @"正在定位";
            }
            else if ([self.mLongtitude doubleValue]==0.000001 && [self.mLatitude doubleValue]==0.000001) {
                cell.detailTextLabel.text = @"附近悬赏需要打开定位服务，请开启定位服务";
            }
            else{
                cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
            }
        }
		return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mShopArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
    {
        NSDictionary * mShopDetail = [mShopArray objectAtIndex:indexPath.row];//shop_id;shop_name;shop_addr;shop_cuisines;shop_logo;distance;
        
        int height=13;
        CGSize size = [[mShopDetail objectForKey:@"shop_name"] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        height+=size.height;
        
        size = [[mShopDetail objectForKey:@"shop_cuisines"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        height+=size.height;
        
        size = [[mShopDetail objectForKey:@"distance"] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(310-73, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        size = [[NSString stringWithFormat:@"地址:%@",[mShopDetail objectForKey:@"shop_addr"]] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(310-73-size.width-9, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        height+=size.height;
        
        height+=13;
        return height;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([mShopArray count]>0 ){
        ShopDetailViewController *temp = [[ShopDetailViewController alloc]init];
        temp.mShopId = [[(NSDictionary*)[mShopArray objectAtIndex:indexPath.row] objectForKey:@"shop_id"] intValue];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mShopArray count];
    if (indexPath.row == total-1&&total>9) {
        NSLog(@"end-------");
        //if (!isLoadFinish) {
        if (!isLoading&&!isEnding) {
            if (mTableView.tableFooterView==nil) {
                UIView *footSpinnerView=[[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 40)];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 320, 40) ];
                label1.textColor = [UIColor colorWithRed:240.0f/255.0f green:107.0f/255.0f blue:35.0f/255.0f alpha:1.0];
                
                label1.text=@"上拉显示更多数据";
                label1.textAlignment=UITextAlignmentCenter;
                label1.font=[label1.font fontWithSize:18.0];
                label1.backgroundColor=[UIColor clearColor];
                [footSpinnerView insertSubview:label1 atIndex:1];
                [label1 release];
                
                mTableView.tableFooterView = footSpinnerView;
                [footSpinnerView release];
            }
            isLoading = YES;
            [dataHandler NearByShopListRequestRecord:mLongtitude :mLatitude :mpagnum*10 :(mpagnum+1)*10 :self];
        }
        if (isEnding)
        {
            mTableView.tableFooterView = nil;
        }
        
    }
}
@end
