//
//  SomeTypeWineViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import "SomeTypeWineViewController.h"
#import "SomeTypeWineCell.h"
#import "SomeAWineViewController.h"
@interface SomeTypeWineViewController ()

@end

@implementation SomeTypeWineViewController
@synthesize mWineId;
@synthesize mSomeTypeWineArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"全部美酒";
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    [rightBtn setImage:[UIImage imageNamed:@"SelectedOneUnClicked.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"SelectedOneClicked.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(SelectedOne) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style=UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn release];
    
    isLoading = YES;
    mPageNum = 0;
    self.mSomeTypeWineArray = [NSMutableArray arrayWithCapacity:0];
    mlogoBgView.hidden=YES;
    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"desc" :@"" :@"" :self];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar:YES];
    [(CustomTabbar*)self.tabBarController disablebuttons];
    [(CustomTabbar*)self.tabBarController disablebutton];
    NSLog(@"%@,%i",self.tabBarController,[self.tabBarController retainCount]);
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%@,%i",self.tabBarController,[self.tabBarController retainCount]);
    [(CustomTabbar*)self.tabBarController enablebuttons];
    [(CustomTabbar*)self.tabBarController enablebutton];
    [self hideTabBar:NO];
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
#pragma mark UserAction
-(void)SelectedOne
{
    SomeTypeSelectedViewController * temp = [[SomeTypeSelectedViewController alloc]init];
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)DefaultClicked:(id)sender
{
    [self refreshTopBar:YES :NO :NO];
    [mSomeTypeWineArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"desc" :@"" :@"" :self];
}
-(IBAction)CouponClicked:(id)sender
{
    [self refreshTopBar:NO :YES :NO];
    [mSomeTypeWineArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"" :@"desc" :@"" :self];
}
-(IBAction)PriceClicked:(id)sender
{
    [self refreshTopBar:NO :NO :YES];
    [mSomeTypeWineArray removeAllObjects];
    mlogoBgView.hidden=YES;
    isLoading = YES;
    [mTableView reloadData];
    mPageNum = 0;
    if (isPriceDesc) {
        [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10:mWineId :@"" :@"" :@"desc" :self];
        isPriceDesc = NO;
    }
    else
    {
        [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"" :@"" :@"asc" :self];
        isPriceDesc = YES;
    }
}
-(void)refreshTopBar:(BOOL)isDefaultSelected:(BOOL)isCouponSelected:(BOOL)isPriceSelected
{
    mDefaultButton.selected = isDefaultSelected;
    mCouponButton.selected = isCouponSelected;
    mPriceButton.selected = isPriceSelected;
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
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mSomeTypeWineArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mSomeTypeWineArray count]>0 ){
        static NSString * tempSomeTypeWineCell = @"SomeTypeWineCell";
        SomeTypeWineCell *cell =(SomeTypeWineCell*)[tableView dequeueReusableCellWithIdentifier:tempSomeTypeWineCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SomeTypeWineCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mDictionary = (NSDictionary*)[mSomeTypeWineArray objectAtIndex:indexPath.row];
        [cell reloadData];
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
        
        if([self.mSomeTypeWineArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mSomeTypeWineArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mSomeTypeWineArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mSomeTypeWineArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 80;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mSomeTypeWineArray count];
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
                [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"desc" :@"" :@"" :self];
            }
            else if (mCouponButton.selected) {
                [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"" :@"desc" :@"" :self];
            }
            else if (mPriceButton.selected) {
                if (isPriceDesc) {
                    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10:mWineId :@"" :@"" :@"desc" :self];
                }
                else
                {
                    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"" :@"" :@"asc" :self];
                }
            }
            else{
                [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"desc" :@"" :@"" :self];
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
    if ([mSomeTypeWineArray count]>0 ){
        SomeAWineViewController * temp = [[SomeAWineViewController alloc]init];
        temp.mWineId = [[(NSDictionary*)[mSomeTypeWineArray objectAtIndex:indexPath.row] objectForKey:@"wine_id"] intValue];
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
    [mSomeTypeWineArray addObjectsFromArray:result];
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
#pragma SomeTypeSelectedDelegate
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId
{
    mWineId = windId;
    [mSomeTypeWineArray removeAllObjects];
     mPageNum = 0;
    isEnding = NO;
    mTableView.tableFooterView = nil;
    [dataHandler InTypeWineListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineId :@"desc" :@"" :@"" :self];
}
@end
