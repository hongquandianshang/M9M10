//
//  WineRecommandViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-8-31.
//
//

#import "WineRecommandViewController.h"
#import "CustomTabbar.h"
#import "WineRecommendCell.h"
#import "AllWineViewController.h"
#import "RecommendSelectedViewController.h"
#import "SomeAWineViewController.h"
@interface WineRecommandViewController ()
-(void)refreshTopTab:(BOOL)isDefaultSelected:(BOOL)isCouponSelected:(BOOL)isPriceSelected;
@end

@implementation WineRecommandViewController
@synthesize mWineRecommandArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    [rightBtn setImage:[UIImage imageNamed:@"SelectedOneUnClicked.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"SelectedOneClicked.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(SelectedOne) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style=UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn release];
    [rightBarBtn release];
    
    
    isLoading = YES;
    mPageNum = 0;
    mWineId = 0;
    self.title = @"推荐美酒";
    mlogoBgView.hidden=YES;
    self.mWineRecommandArray = [NSMutableArray arrayWithCapacity:0];
    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"desc" :@"" :@"" :@"" :self];
    // Do any additional setup after loading the view from its nib.
}
-(void)SelectedOne
{
    RecommendSelectedViewController * temp = [[RecommendSelectedViewController alloc]init];
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - 
#pragma mark UserAction
-(IBAction)DefaultClicked:(id)sender
{
    [self refreshTopTab:YES :NO :NO];
    [mWineRecommandArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    if (mWineId>0)
    {
        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10:@"desc" :@"" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
    }
    else
    {
        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"desc" :@"" :@"" :@"" :self];
    }
}
-(IBAction)CouponClicked:(id)sender
{
    [self refreshTopTab:NO :YES :NO];
    [mWineRecommandArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    if (mWineId>0)
    {
        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"desc" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
    }
    else
    {
        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"desc" :@"" :@"" :self];
    }
    
}
-(IBAction)PriceClicked:(id)sender
{
    [self refreshTopTab:NO :NO :YES];
    [mWineRecommandArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    if (isPriceDesc)
    {
        if (mWineId>0)
        {
            [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"desc" :[NSString stringWithFormat:@"%i",mWineId] :self];
        }
        else
        {
            [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"desc" :@"" :self];
        }
        isPriceDesc = NO;
    }
    else
    {
        if (mWineId>0)
        {
            [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"asc" :[NSString stringWithFormat:@"%i",mWineId] :self];
        }
        else
        {
            [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"asc" :@"" :self];
        }
        isPriceDesc = YES;
    }
    
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
            cell = [nib objectAtIndex:0];
        }
        cell.mWineRecommendDictionary = (NSDictionary*)[mWineRecommandArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
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
        return 80.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mWineRecommandArray count];
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
            if (mDefaultButton.selected) {
                if (mWineId>0)
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10:@"desc" :@"" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
                }
                else
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"desc" :@"" :@"" :@"" :self];
                }
            }
            else if (mCouponButton.selected) {
                if (mWineId>0)
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"desc" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
                }
                else
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"desc" :@"" :@"" :self];
                }
            }
            else if (mPriceButton.selected) {
                if (isPriceDesc)
                {
                    if (mWineId>0)
                    {
                        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"desc" :[NSString stringWithFormat:@"%i",mWineId] :self];
                    }
                    else
                    {
                        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"desc" :@"" :self];
                    }
                }
                else
                {
                    if (mWineId>0)
                    {
                        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"asc" :[NSString stringWithFormat:@"%i",mWineId] :self];
                    }
                    else
                    {
                        [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"" :@"" :@"asc" :@"" :self];
                    }
                }
            }
            else{
                if (mWineId>0)
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10:@"desc" :@"" :@"" :[NSString stringWithFormat:@"%i",mWineId] :self];
                }
                else
                {
                    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"desc" :@"" :@"" :@"" :self];
                }
            }
        }
        if (isEnding)
        {
            mTableView.tableFooterView = nil;
        }
    }
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
    mPageNum++;
    if ([result count]<10)
    {
        isEnding = YES;
    }
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
#pragma recomenndselecteddelegate
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId
{
    mWineId = windId;
    [mWineRecommandArray removeAllObjects];
    mPageNum = 0;
    isEnding = NO;
    mTableView.tableFooterView = nil;
    [dataHandler RecommendWineListRecord:mPageNum*10 :(mPageNum+1)*10 :@"desc" :@"" :@"" :[NSString stringWithFormat:@"%i",windId] :self];
}
@end
