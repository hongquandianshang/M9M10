//
//  AllWineForAShopViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "AllWineForAShopViewController.h"
#import "WineRecommendCell.h"
#import "SomeAWineViewController.h"
@interface AllWineForAShopViewController ()

@end

@implementation AllWineForAShopViewController
@synthesize mWineRecommandArray;
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
    isLoading = YES;
    mPageNum = 0;
    self.title = @"所有美酒";
    self.mWineRecommandArray = [NSMutableArray arrayWithCapacity:0];
    mlogoBgView.hidden=YES;
    [dataHandler ShopToWineListRecord:0 :10 :mShopId :self];
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
#pragma mark UserAction
-(IBAction)DefaultClicked:(id)sender
{
    [self refreshTopTab:YES :NO :NO];
//    [mWineRecommandArray removeAllObjects];
//    if (mWineId>0)
//    {
//        [dataHandler RecommendWineListRecord:0 :10 :@"desc" :@"" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
//    }
//    else
//    {
//        [dataHandler RecommendWineListRecord:0 :10 :@"desc" :@"" :@"" :@"" :self];
//    }
}
-(IBAction)CouponClicked:(id)sender
{
    [self refreshTopTab:NO :YES :NO];
    [mWineRecommandArray removeAllObjects];
//    if (mWineId>0)
//    {
//        [dataHandler RecommendWineListRecord:0 :10 :@"" :@"desc" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
//    }
//    else
//    {
//        [dataHandler RecommendWineListRecord:0 :10 :@"" :@"desc" :@"" :@"" :self];
//    }
    
}
-(IBAction)PriceClicked:(id)sender
{
    [self refreshTopTab:NO :NO :YES];
    [mWineRecommandArray removeAllObjects];
//    if (isPriceDesc)
//    {
//        if (mWineId>0)
//        {
//            [dataHandler RecommendWineListRecord:0 :10 :@"" :@"" :@"desc" :[NSString stringWithFormat:@"%i",mWineId] :self];
//        }
//        else
//        {
//            [dataHandler RecommendWineListRecord:0 :10 :@"" :@"" :@"desc" :@"" :self];
//        }
//        isPriceDesc = NO;
//    }
//    else
//    {
//        if (mWineId>0)
//        {
//            [dataHandler RecommendWineListRecord:0 :10 :@"" :@"" :@"asc" :[NSString stringWithFormat:@"%i",mWineId] :self];
//        }
//        else
//        {
//            [dataHandler RecommendWineListRecord:0 :10 :@"" :@"" :@"asc" :@"" :self];
//        }
//        isPriceDesc = YES;
//    }
    
}
-(void)refreshTopTab:(BOOL)isDefaultSelected:(BOOL)isCouponSelected:(BOOL)isPriceSelected
{
    [mDefaultButton setSelected:isDefaultSelected];
    [mCouponButton setSelected:isCouponSelected];
    [mPriceButton setSelected:isPriceSelected];
    if (isPriceSelected)
    {
        if (isPriceDesc)
        {
            mPriceIndicator.image = [UIImage imageNamed:@"TopTabUp.png"];
        }
        else
        {
            mPriceIndicator.image = [UIImage imageNamed:@"TopTabDown.png"];
        }
    }
}
-(IBAction)SelectedClicked:(id)sender
{
    RecommendSelectedViewController * temp = [[RecommendSelectedViewController alloc]init];
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mWineRecommandArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mWineRecommandArray count]>0 ){
        static NSString * tempAllWineCell = @"WineRecommendCell";
        WineRecommendCell *cell =(WineRecommendCell*)[tableView dequeueReusableCellWithIdentifier:tempAllWineCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WineRecommend" owner:self options:nil];
            cell = [nib objectAtIndex:1];
        }
        cell.mWineRecommendDictionary = (NSDictionary*)[mWineRecommandArray objectAtIndex:indexPath.row];
        
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
        
        if([self.mWineRecommandArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mWineRecommandArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mWineRecommandArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mWineRecommandArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([mWineRecommandArray count]>0 ){
        SomeAWineViewController* temp = [[SomeAWineViewController alloc]init];
        temp.mWineId = [[[mWineRecommandArray objectAtIndex:indexPath.row] objectForKey:@"wine_id"] intValue];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
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
    [mWineRecommandArray addObjectsFromArray:result];
    isLoading = NO;
    [mTableView reloadData];
    
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
@end
