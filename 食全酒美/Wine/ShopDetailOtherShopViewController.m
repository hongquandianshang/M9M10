//
//  ShopDetailOtherShopViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-27.
//
//

#import "ShopDetailOtherShopViewController.h"
#import "ShopCell.h"
#import "ShopDetailViewController.h"
@interface ShopDetailOtherShopViewController ()

@end

@implementation ShopDetailOtherShopViewController
@synthesize mOtherShopArray;
@synthesize mShopId;
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
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择商家";
    self.mOtherShopArray = [NSMutableArray arrayWithCapacity:0];
    mPageNum = 0;
    isLoading = YES;
    mlogoBgView.hidden=YES;
    [dataHandler OthershopListRequestRecord:mPageNum*10 :(mPageNum+1)*10 :mShopId :self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar:YES];
    [(CustomTabbar*)self.tabBarController disablebuttons];
    [(CustomTabbar*)self.tabBarController disablebutton];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [(CustomTabbar*)self.tabBarController enablebuttons];
    [(CustomTabbar*)self.tabBarController enablebutton];
    [self hideTabBar:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mOtherShopArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mOtherShopArray count]>0 ){
        static NSString * tempShopCell = @"ShopCell";
        ShopCell *cell =(ShopCell*)[tableView dequeueReusableCellWithIdentifier:tempShopCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mShopDic = (NSDictionary*)[mOtherShopArray objectAtIndex:indexPath.row];
        [cell refreshData];
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
        
        if([self.mOtherShopArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mOtherShopArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mOtherShopArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([mOtherShopArray count]>0 ){
        ShopDetailViewController * temp = [[ShopDetailViewController alloc]init];
        temp.mShopId = mShopId;
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mOtherShopArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 80.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mOtherShopArray count];
    if (indexPath.row == total-1&&total>9) {
        NSLog(@"end-------");
        //if (!isLoadFinish) {
        if (!isLoading&&!isEnding) {
            if (mTableView.tableFooterView==nil) {
                UIView *footSpinnerView=[[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 40)];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 320, 40) ];
                label1.textColor = [UIColor colorWithRed:240.0f/255.0f green:107.0f/255.0f blue:35.0f/255.0f alpha:1.0];
                
                label1.text=@"更多...";
                label1.textAlignment=UITextAlignmentCenter;
                label1.font=[label1.font fontWithSize:18.0];
                label1.backgroundColor=[UIColor clearColor];
                [footSpinnerView insertSubview:label1 atIndex:1];
                [label1 release];
                
                mTableView.tableFooterView = footSpinnerView;
                [footSpinnerView release];
            }
            isLoading = YES;
            [dataHandler OthershopListRequestRecord:mPageNum*10 :(mPageNum+1)*10 :mShopId :self];
        }
        if (isEnding)
        {
            mTableView.tableFooterView = nil;
        }
        
    }
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
    [mOtherShopArray addObjectsFromArray:result];
    isLoading = NO;
    [mTableView reloadData];
    mPageNum++;
    if ([result count]<10)
    {
        isEnding = YES;
    }
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
@end
