//
//  SomeAWineViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-6.
//
//

#import "SomeAWineViewController.h"
#import "PertainToShopViewController.h"
#import "CommentForWineViewController.h"
#import "AppDelegate.h"
#import "TCWBEngine.h"
#import "SDWebDownLoadObject.h"
@interface SomeAWineViewController ()

@end

@implementation SomeAWineViewController
@synthesize mWineId;
@synthesize mWineDetail;
@synthesize mDownLoadObjectArray;
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
    self.title = @"美酒详情";
    mScrollView.contentSize = CGSizeMake(320, 700);
    self.mWineDetail = [NSDictionary dictionary];
    self.mDownLoadObjectArray = [NSArray array];
    [dataHandler WineDetailRecord:mWineId :self];
    // Do any additional setup after loading the view from its nib.
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
-(void)dealloc
{
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)reloadData
{
    self.title = [mWineDetail objectForKey:@"wine_name"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    NSArray * tempArray = [mWineDetail objectForKey:@"wine_logos"];
    self.mDownLoadObjectArray = [NSMutableArray arrayWithCapacity:tempArray.count];
    for (int i=0; i<tempArray.count; i++) {
        SDWebDownLoadObject * downobject = [[SDWebDownLoadObject alloc]init];
        downobject.delegate = self;
        downobject.index = i;
        [self.mDownLoadObjectArray addObject:downobject];
        [tempDownLoader downloadWithURL:[NSURL URLWithString:[[tempArray objectAtIndex:i] objectForKey:@"wine_logo" ]] delegate:downobject];
    }
    mWineScrollView.contentSize = CGSizeMake(tempArray.count*100, 100);
    pageControl.numberOfPages = tempArray.count;
    pageControl.currentPage = 0;
    
    int height = 43;
    mBrandStoryLabel.text = [mWineDetail objectForKey:@"wine_brandstory"];
    mBrandStoryLabel.numberOfLines = 0;
    CGSize size = [mBrandStoryLabel.text sizeWithFont:[mBrandStoryLabel font] constrainedToSize:CGSizeMake(mBrandStoryLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mBrandStoryLabel.frame = [self ReSizeView:mBrandStoryLabel :size:height];
    
    height+= size.height+8;
    
    mVillageIntroduceTitleView.frame = CGRectMake(mVillageIntroduceTitleView.frame.origin.x, height,mVillageIntroduceTitleView.frame.size.width , mVillageIntroduceTitleView.frame.size.height);
    
    height += mVillageIntroduceTitleView.frame.size.height+2;
    
    mVillageIntroductionLabel.text = [mWineDetail objectForKey:@"wine_introduce"];
    size = [mVillageIntroductionLabel.text sizeWithFont:mVillageIntroductionLabel.font constrainedToSize:CGSizeMake(mVillageIntroductionLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mVillageIntroductionLabel.frame = [self ReSizeView:mVillageIntroductionLabel :size :height];
    
    height +=size.height+8;
    
    mTestNoteTitleView.frame = CGRectMake(mTestNoteTitleView.frame.origin.x, height,mTestNoteTitleView.frame.size.width , mTestNoteTitleView.frame.size.height);
    
    height +=mTestNoteTitleView.frame.size.height+2;
    
    mTestNoteLabel.text = [mWineDetail objectForKey:@"wine_name"];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n产地:%@",[mWineDetail objectForKey:@"wine_country"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n颜色:%@",[mWineDetail objectForKey:@"wine_color"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n酒香:%@",[mWineDetail objectForKey:@"wine_smell"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n口味:%@",[mWineDetail objectForKey:@"wine_taste"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n葡萄品种:%@",[mWineDetail objectForKey:@"wine_breed"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n窖藏潜力:%@",[mWineDetail objectForKey:@"wine_potentia"]];
    mTestNoteLabel.text = [mTestNoteLabel.text stringByAppendingFormat:@"\r\n配餐建议:%@",[mWineDetail objectForKey:@"wine_foodmatches"]];
    mTestNoteLabel.numberOfLines = 0;
    size = [mTestNoteLabel.text sizeWithFont:mTestNoteLabel.font constrainedToSize:CGSizeMake(mTestNoteLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mTestNoteLabel.frame = [self ReSizeView:mTestNoteLabel :size :height];
    
    height +=size.height;
    
    mContentView.frame=CGRectMake(mContentView.frame.origin.x,mContentView.frame.origin.y,mContentView.frame.size.width,height);
    mScrollView.contentSize = CGSizeMake(320, height+169);
    
    
    mCommentNumberLabel.text = [mWineDetail objectForKey:@"wine_comment_count"];
    mCollectNumberLabel.text = [mWineDetail objectForKey:@"wine_collect_count"];
    mPraiseNumberLabel.text = [mWineDetail objectForKey:@"wine_praisecount"];
    
    size = [mPraiseNumberLabel.text sizeWithFont:mPraiseNumberLabel.font constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame=mPraiseNumberLabel.frame;
    frame.origin.x = 310-size.width;
    mPraiseNumberLabel.frame=frame;
    
    frame=mPraiseIV.frame;
    frame.origin.x=mPraiseNumberLabel.frame.origin.x-mPraiseIV.frame.size.width-8;
    mPraiseIV.frame=frame;
    
    mPriceLabel.text = [@"餐厅指导价：" stringByAppendingString:[mWineDetail objectForKey: @"wine_pricearea"]];
    mCountryLabel.text = [@"产　　地：" stringByAppendingString:[mWineDetail objectForKey:@"wine_country"]];
    mBreedLabel.text = [@"葡萄品种：" stringByAppendingString:[mWineDetail objectForKey:@"wine_breed"]];
    [self reloadStarLevel];
}
-(CGRect)ReSizeView:(UIView *)view:(CGSize)size:(int)locationY
{
    return CGRectMake(view.frame.origin.x,locationY, size.width, size.height);
}
-(void)reloadStarLevel
{
    int starlevel = [[mWineDetail objectForKey:@"wine_starlevel"] intValue];
    NSArray * tempImageArray = [NSArray arrayWithObjects:mStarLevel1,mStarLevel2,mStarLevel3,mStarLevel4,mStarLevel5,nil];
    for (int i = 0; i<starlevel; i++)
    {
        ((UIImageView*)[tempImageArray objectAtIndex:i]).image = [UIImage imageNamed:@"StarLevelLight.png"];
    }
}
-(IBAction)SeeShop:(id)sender
{
    PertainToShopViewController * temp = [[PertainToShopViewController alloc]init];
    temp.mwineId = mWineId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)TabBar1Clicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [dataHandler WineCollectRecord:mWineId :self];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=104;
        [av show];
        [av release];
    }
}
-(IBAction)TabBar2Clicked:(id)sender
{
    [dataHandler PraiseWineListRecord:mWineId :self];
}
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
- (TCWBEngine *)tencentweibo
{
    AppDelegate * delegate = (AppDelegate * )[UIApplication sharedApplication].delegate;
    return delegate.tencentweibo;
}
-(IBAction)TabBar4Clicked:(id)sender
{
    NSString *shareText=[NSString stringWithFormat:@"我在@M9M10食全酒美 发现一款美酒：%@，产自%@。口味%@，分享一下，http://www.m9m10.cn/appdown/app.html",[mWineDetail objectForKey:@"wine_name"],[mWineDetail objectForKey:@"wine_country"],[mWineDetail objectForKey:@"wine_taste"]];
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        switch ([[dataHandler.userInfoDic objectForKey:@"usersource"]intValue])
        {
            case 1:
            {
                SinaWeibo *sinaweibo = [self sinaweibo];
                [sinaweibo requestWithURL:@"statuses/update.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:shareText, @"status", nil]
                               httpMethod:@"POST"
                                 delegate:self];
            }
                break;
            case 2:
            {
                [[self tencentweibo] setRootViewController:self];
                [[self tencentweibo] postTextTweetWithFormat:@"json"
                                                     content:shareText
                                                    clientIP:@"10.10.1.31"
                                                   longitude:nil
                                                 andLatitude:nil
                                                 parReserved:nil
                                                    delegate:self
                                                   onSuccess:@selector(successCallBack:)
                                                   onFailure:@selector(failureCallBack:)];
            }
                break;
            default:
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"不能分享" message:@"非微博账号，请用微博登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
                alert.delegate = self;
                alert.tag=104;
                [alert show];
                [alert release];
            }
                break;
        }
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请用微博登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=104;
        [av show];
        [av release];
    }
}
-(IBAction)TabBar5Clicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        CommentForWineViewController * temp = [[CommentForWineViewController alloc]init];
        temp.mWineId = mWineId;
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=105;
        [av show];
        [av release];
    }
}
- (void)successCallBack:(id)result
{
    UIAlertView * malertView = [[UIAlertView alloc]initWithTitle:@"发送成功" message:@"恭喜您，您已经成功分享了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [malertView show];
    [malertView release];
}
- (void)failureCallBack:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败"
                                                        message:[NSString stringWithFormat:@"发送失败了!"]
                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:[NSString stringWithFormat:@"您已经分享过了!"]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    NSLog(@"Post status failed with error : %@", error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                            message:@"分享成功"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
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
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络出错" message:@"网络无响应，请检查网络并稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
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
    
    
    if([[dic objectForKey:@"data"]objectForKey:@"flag"])
    {
        if ([[dic objectForKey:@"data"]objectForKey:@"praise_count"])
        {
            NSString *flag=[[dic objectForKey:@"data"] objectForKey:@"flag"];
            if (flag && flag.length>0) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"赞酒成功"];
            }
        }
        else
        {
            NSString *flag=[[dic objectForKey:@"data"] objectForKey:@"flag"];
            if (flag && flag.length>0) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"美酒收藏成功"];
            }
        }
    }
    else
    {
        self.mWineDetail = (NSDictionary*)[dic objectForKey:@"data"];
        [self reloadData];
    }
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
-(void)ImagefromWebAtIndex:(NSData*)imageDate index:(int)index
{
    UIImageView *tempimageView;
    if (imageDate) {
        tempimageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imageDate]];
    }
    else{
        tempimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defaultWine.png"]];
    }
    
    tempimageView.frame = CGRectMake(index*100, 0, 100, 100);
    [mWineScrollView addSubview:tempimageView];
}
#pragma mark PageControl
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // update the scroll view to the appropriate page
    CGRect frame = mWineScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [mWineScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark UIScrollViewDelegate
//滚动中
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = mWineScrollView.frame.size.width;
    int page = floor((mWineScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    CGFloat pageWidth = mWineScrollView.frame.size.width;
    int page = floor((mWineScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    CGRect frame = mWineScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [mWineScrollView scrollRectToVisible:frame animated:YES];
}
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
	}
    
    LoginViewController * temp = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
@end
