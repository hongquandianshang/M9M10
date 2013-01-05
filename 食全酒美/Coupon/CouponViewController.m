//
//  CouponViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponShopViewController.h"
#import "CouponCell.h"
@interface CouponViewController ()

@end

@implementation CouponViewController
@synthesize mCouponArray;
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
    self.title = @"优惠券";
    self.navigationItem.leftBarButtonItem =nil;
    mpagnum = 0;
    isEnding = NO;
    isLoading = YES;
    self.mCouponArray = [NSMutableArray arrayWithCapacity:0];
    mlogoBgView.hidden=YES;
    [dataHandler CouponListRqeustRecord:mpagnum*10 :(mpagnum+1)*10 :@"" :self];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [mTabelView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - 
#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    mpagnum = 0;
    mlogoBgView.hidden=YES;
    [dataHandler CouponListRqeustRecord:0 :10 :searchBar.text:self];
}
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mCouponArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mCouponArray count]>0 ){
        static NSString * tempCouponCell = @"CouponCell";
        CouponCell *cell =(CouponCell*)[tableView dequeueReusableCellWithIdentifier:tempCouponCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CouponCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mCouponInfoDictionary = (NSDictionary*)[mCouponArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData];
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
        
        if([self.mCouponArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mCouponArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mCouponArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([mCouponArray count]>0 ){
        CouponShopViewController * temp = [[CouponShopViewController alloc]init];
        temp.mEventId = [[(NSDictionary*)[mCouponArray objectAtIndex:indexPath.row] objectForKey:@"event_id"] intValue];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mCouponArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 80.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mCouponArray count];
    if (indexPath.row == total-1&&total>9) {
        NSLog(@"end-------");
        //if (!isLoadFinish) {
        if (!isLoading&&!isEnding) {
            if (mTabelView.tableFooterView==nil) {
                UIView *footSpinnerView=[[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 40)];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 320, 40) ];
                label1.textColor = [UIColor colorWithRed:240.0f/255.0f green:107.0f/255.0f blue:35.0f/255.0f alpha:1.0];
                
                label1.text=@"更多...";
                label1.textAlignment=UITextAlignmentCenter;
                label1.font=[label1.font fontWithSize:18.0];
                label1.backgroundColor=[UIColor clearColor];
                [footSpinnerView insertSubview:label1 atIndex:1];
                [label1 release];
                
                mTabelView.tableFooterView = footSpinnerView;
                [footSpinnerView release];
            }
            isLoading = YES;
            [dataHandler CouponListRqeustRecord:mpagnum*10 :(mpagnum+1)*10 :@"" :self];
        }
        if (isEnding)
        {
            mTabelView.tableFooterView = nil;
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [mSearchBar resignFirstResponder];
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
    [mTabelView reloadData];
    
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
    [mCouponArray addObjectsFromArray:result];
    isLoading = NO;
    [mTabelView reloadData];
    mpagnum++;
    if ([result count]<10)
    {
        isEnding = YES;
    }
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
@end
