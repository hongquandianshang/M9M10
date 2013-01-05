//
//  CommentForActivityViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "CommentForActivityViewController.h"
#import "CommentForActivityCell.h"
#import "CommentContentViewController.h"
@interface CommentForActivityViewController ()

@end

@implementation CommentForActivityViewController
@synthesize mCommentArray;
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
    self.title = @"全部评论";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    mPagnum = 0;
    self.mCommentArray = [NSMutableArray arrayWithCapacity:0];
    isLoading = YES;
    mlogoBgView.hidden=YES;
    [dataHandler EventCommentListRequestRecord:mShopId :mPagnum*10 :(mPagnum+1)*10 :self];
    
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
-(IBAction)CommentClicked:(id)sender
{
    CommentContentViewController *temp = [[CommentContentViewController alloc]init];
    temp.mShopId = mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.mCommentArray count];
    if (count == 0)
    {
        count = 1;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.mCommentArray count]>0 ){
        static NSString * tempCommentForActivityViewCell = @"CommentForActivityCell";
        CommentForActivityCell *cell =nil;//(CommentForActivityCell*)[tableView dequeueReusableCellWithIdentifier:tempCommentForActivityViewCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CommentForActivityCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mCommentDic = (NSDictionary*)[mCommentArray objectAtIndex:indexPath.row];
        [cell refreshData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        if([self.mCommentArray count]==0 && isLoading ){
            cell.detailTextLabel.text = NSLocalizedString(@"正在获取数据",nil);
        }
        if([self.mCommentArray count]==0 && !isLoading && mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"暂无评论",nil);
        }
        if([self.mCommentArray count]==0 && !isLoading && !mlogoBgView.hidden ){
            cell.detailTextLabel.text = NSLocalizedString(@"无法连接到网络，请检查网络配置",nil);
        }
		return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mCommentArray count]==0)
        return 44;//默认tableView rowHeight=44
    else{
        NSDictionary *mCommentDic = (NSDictionary*)[mCommentArray objectAtIndex:indexPath.row];
        NSString *comment_content=[mCommentDic objectForKey:@"comment_content"];
        CGSize size = [comment_content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(260, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        return 69+size.height+8;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int total=[self.mCommentArray count];
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
            [dataHandler EventCommentListRequestRecord:mShopId :mPagnum*10 :(mPagnum+1)*10 :self];
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
    [mCommentArray addObjectsFromArray:result];
    isLoading = NO;
    [mTableView reloadData];
    mPagnum ++;
    if ([result count]<10)
    {
        isEnding = YES;
    }
    
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    mlogoBgView.hidden=YES;
}
@end
