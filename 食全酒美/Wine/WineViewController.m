//
//  WineViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WineViewController.h"
#import "AllWineViewController.h"
#import "BrandWineViewController.h"
#import "WineActivityViewController.h"
#import "WineRecommandViewController.h"
#import "WineActivityCell.h"
#import "ShopListViewController.h"
#import "ActivityDetailViewController.h"

@interface WineViewController ()
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) NSArray *wines;
@end

@implementation WineViewController
@synthesize mWineActivityArray;
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
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.leftBarButtonItem =nil;
    mPageNum = 0;
    self.mWineActivityArray = [NSMutableArray arrayWithCapacity:0];
    isLoading = YES;
    mlogoBgView.hidden=YES;
    //[dataHandler WineEventIndexRecord:mPageNum*10 :(mPageNum+1)*10 :self];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [(CustomTabbar*)self.tabBarController enablebuttons];
    [(CustomTabbar*)self.tabBarController enablebutton];
    [self hideTabBar:NO];
    self.navigationController.navigationBarHidden = YES;
    NSURL *URL = [NSURL URLWithString:@"http://m9m10.com.cn:8080/wines.php"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (data) {
                                   NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   self.wines = array;
                                   NSLog(@"wines %@",array);
                               }
                        [self refreshWines];
    }];
}

- (void)refreshWines
{
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    CGRect bounds = self.scrollView.bounds;
    CGSize size = bounds.size;
    size = CGSizeMake(size.width * self.wines.count, size.height);
    self.scrollView.contentSize = size;
    int i = 0;
    for (NSDictionary *wine in self.wines) {
        NSString *detailtext = [wine objectForKey:@"Detail"];
        NSString *discounttext = [wine objectForKey:@"Discount"];
        NSString *imageURL = [wine objectForKey:@"Image"];        
        CGRect frame = bounds;
        frame.origin.x = 0;
        NSLog(@"%@",[NSValue valueWithCGRect:bounds]);
        frame = CGRectOffset(frame, bounds.size.width * i, 0);
        frame = CGRectInset(frame, 20, 12);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"list-item-frame@2x.png"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        
        CGRect wineFrame = CGRectMake(16, 66, 250, 166);
        //wineFrame = CGRectOffset(wineFrame, 0, -16);
        UIImageView *wineImageView = [[UIImageView alloc]initWithFrame:wineFrame];
        NSURL *URL = [NSURL URLWithString:imageURL];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   UIImage *image = [UIImage imageWithData:data];
                                   wineImageView.image = image;
        }];
        
        CGRect detailFrame = CGRectMake(21, 15, 63, 10);
        UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:detailFrame];
        detailImageView.image = [UIImage imageNamed:@"list-item-title@2x.png"];
        
        CGRect detailtextFrame = CGRectMake(19, 32, 238, 22);
        UILabel *detailtextLabel = [[UILabel alloc]initWithFrame:detailtextFrame];
        detailtextLabel.backgroundColor = [UIColor clearColor];
        detailtextLabel.text = detailtext;
        detailtextLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:10];
        detailtextLabel.numberOfLines = 2;
        CGRect discountFrame = CGRectMake(19, 244, 66, 15);
        UIImageView *discountImageView = [[UIImageView alloc]initWithFrame:discountFrame];
        discountImageView.image = [UIImage imageNamed:@"list-item-sale@2x.png"];
        
        CGRect discounttextFrame = CGRectMake(19, 260, 238, 22);
        UILabel *discounttextLabel = [[UILabel alloc]initWithFrame:discounttextFrame];
        discounttextLabel.text = discounttext;
        discounttextLabel.backgroundColor = [UIColor clearColor];
        discounttextLabel.numberOfLines = 2;
        discounttextLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:10];
        discounttextLabel.lineBreakMode = UILineBreakModeTailTruncation;

        
        CGRect leftButtonFrame = CGRectMake(12, 295, 130, 44);
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = leftButtonFrame;
        //[leftButton setTitle:@"立即下载" forState:UIControlStateNormal];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"list-item-button-downloads@2x.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.tag = i;
        
        CGRect rightButtonFrame = CGRectMake(142, 295, 130, 44);
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = rightButtonFrame;
        //[rightButton setTitle:@"查看详细" forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"list-item-button-details@2x.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.tag = i;
        
        [imageView addSubview:discounttextLabel];
        [imageView addSubview:detailtextLabel];
        [imageView addSubview:discountImageView];
        [imageView addSubview:detailImageView];
        [imageView addSubview:wineImageView];
        [imageView addSubview:leftButton];
        [imageView addSubview:rightButton];
        
        [self.scrollView addSubview:imageView];
        i++;
    }
}

- (void)leftButtonClicked:(id)sender
{
    NSLog(@"left");
    UIButton *button = sender;
    NSDictionary *wine = [self.wines objectAtIndex:button.tag];
    NSString *shop_id = [wine objectForKey:@"shop_id"];
    NSString *event_id = [wine objectForKey:@"event_id"];
    NSLog(@"%@ %@",shop_id, event_id);
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [dataHandler DownloadCouponRequestRecord: event_id.intValue:shop_id.intValue :self];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=101;
        [av show];
        [av release];
    }
}

- (void)rightButtonClicked:(id)sender
{
    NSLog(@"right");
    UIButton *button = sender;
    NSDictionary *wine = [self.wines objectAtIndex:button.tag];
    NSString *shop_id = [wine objectForKey:@"shop_id"];
    NSString *event_id = [wine objectForKey:@"event_id"];
    NSLog(@"%@ %@",shop_id, event_id);
    ActivityDetailViewController * temp = [[ActivityDetailViewController alloc]init];
    temp.mShopId = shop_id.intValue;
    temp.mEventId = event_id.intValue;
    [self.navigationController pushViewController:temp animated:YES];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)AllWine:(id)sender
{
    mSelectedView.hidden = YES;
    
    NSLog(@"%@,%i",self.tabBarController,[self.tabBarController retainCount]);
    AllWineViewController * temp = [[AllWineViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)BrandWine:(id)sender
{
    mSelectedView.hidden = YES;
    
    BrandWineViewController*temp = [[BrandWineViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)WineActivity:(id)sender
{
    WineActivityViewController*temp = [[WineActivityViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)WineRecommand:(id)sender
{
    WineRecommandViewController * temp = [[WineRecommandViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)WineShow:(id)sender
{
    if (mSelectedView.hidden)
    {
        mTrigleView.image = [UIImage imageNamed:@"TrigleUp.png"];
        mSelectedView.hidden = NO;
    }
    else
    {
        mTrigleView.image = [UIImage imageNamed:@"TrigleDown.png"];
        mSelectedView.hidden = YES;
    }
}
#pragma mark -
#pragma mark UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mWineActivityArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mWineActivityArray count]>0 ){
        static NSString * tempWineActivityCell = @"WineActivityCell";
        WineActivityCell *cell =(WineActivityCell*)[tableView dequeueReusableCellWithIdentifier:tempWineActivityCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WineActivityCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mActivityInformationDic = [mWineActivityArray objectAtIndex:indexPath.row];
        cell.mIndex=indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        if([self.mWineActivityArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mWineActivityArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无数据",nil);
        }
        if([self.mWineActivityArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mWineActivityArray count]==0)
        return 44;//默认tableView rowHeight=44
    else
        return 96.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mWineActivityArray count];
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
            [dataHandler WineEventIndexRecord:mPageNum*10 :(mPageNum+1)*10 :self];
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
    if ([mWineActivityArray count]>0 ){
        ShopListViewController * temp = [[ShopListViewController alloc]init];
        temp.mEventId = [[(NSDictionary*)[mWineActivityArray objectAtIndex:indexPath.row] objectForKey:@"wine_event_id"] intValue];
        [self.navigationController pushViewController:temp
                                             animated:YES];
        [temp release];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f,%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    int index = scrollView.contentOffset.y/104+2;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshContent" object:[NSNumber numberWithInt:index] userInfo:nil];
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
    [mWineActivityArray addObjectsFromArray:result];
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
    NSString *flag=[[dic objectForKey:@"data"] objectForKey:@"flag"];
    if (flag && flag.length>0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"优惠券已保存到“我的优惠券”"];
        return;
    }
}
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId
{
//    mWineTypeId = windId;
//    [self.navigationController popViewControllerAnimated:YES];
//    [mWineActivityArray removeAllObjects];
//    mPageNum = 0;
//    [dataHandler WineEventListRecord:mPageNum*10 :(mPageNum+1)*10 :mWineTypeId:self];
}
- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}



@end
