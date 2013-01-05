//
//  ShopDetailFoodChooseWineViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-10.
//
//

#import "ShopDetailFoodChooseWineViewController.h"
#import "AllWineCell.h"
#import "ShopDetailFoodWineViewController.h"
#import "ShopDetailFoodChooseWineCell.h"
@interface ShopDetailFoodChooseWineViewController ()

@end

@implementation ShopDetailFoodChooseWineViewController
@synthesize mShopId;
@synthesize mWineArray;
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
    self.title = @"选择美酒";
    self.mWineArray = [NSMutableArray arrayWithCapacity:0];
    isLoading = YES;
    mlogoBgView.hidden=YES;
    [dataHandler ShopWineIdListRequestRecord:mShopId :self];
    // Do any additional setup after loading the view from its nib.
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
    int count = [self.mWineArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mWineArray count]>0 ){
        static NSString * tempShopDetailFoodChooseWineCell = @"ShopDetailFoodChooseWineCell";
        ShopDetailFoodChooseWineCell *cell =(ShopDetailFoodChooseWineCell*)[tableView dequeueReusableCellWithIdentifier:tempShopDetailFoodChooseWineCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopDetailFoodChooseWineCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mWineInfo = (NSDictionary*)[mWineArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [cell refreshData];
        return cell;
    }
    else{
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"PlaceholderCell"];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlaceholderCell"] autorelease];
			cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleBlue;
			cell.detailTextLabel.backgroundColor=[UIColor clearColor];
			
		}
        
        if([self.mWineArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mWineArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mWineArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([mWineArray count]>0 ){
        ShopDetailFoodWineViewController * temp = [[ShopDetailFoodWineViewController alloc]init];
        temp.mShopId = mShopId;
        temp.mWineId = [[[mWineArray objectAtIndex:indexPath.row] objectForKey:@"wine_id"] intValue];
        temp.mWineInfo = [mWineArray objectAtIndex:indexPath.row];
        temp.mArrangeNum = indexPath.row+1;
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mWineArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 80.0f;
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
    [mWineArray addObjectsFromArray:result];
    isLoading = NO;
    [mTableView reloadData];
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
@end
