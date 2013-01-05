//
//  ShopDetailFoodWineViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-10.
//
//

#import "ShopDetailFoodWineViewController.h"
#import "SDWebDownLoadObject.h"
@interface ShopDetailFoodWineViewController ()

@end

@implementation ShopDetailFoodWineViewController
@synthesize mFoodInfo;
@synthesize mWineInfo;
@synthesize mShopId;
@synthesize mWineId;
@synthesize mArrangeNum;
@synthesize mWineContentView;
@synthesize mScrollView;
@synthesize mFoodScrollView;
@synthesize pageControl;
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
    self.title = @"美酒美食搭配";
    mArrangeNumLabel.text = [NSString stringWithFormat:@"%i",mArrangeNum];
    mWineNameLabel.text = [mWineInfo objectForKey:@"wine_name"];
    mWineContentLabel.text = [mWineInfo objectForKey:@"wine_food"];
    CGSize size = [mWineContentLabel.text sizeWithFont:mWineContentLabel.font constrainedToSize:CGSizeMake(mWineContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mWineContentLabel.frame = CGRectMake(mWineContentLabel.frame.origin.x, mWineContentLabel.frame.origin.y, mWineContentLabel.frame.size.width, size.height);
    
    mScrollView.contentSize = CGSizeMake(320, mWineContentLabel.frame.origin.y+mWineContentLabel.frame.size.height);
    
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineInfo objectForKey:@"wine_logo"]] delegate:self];
    self.mFoodInfo = [NSMutableArray arrayWithCapacity:0];
    [dataHandler ShopInCateListRequestRecord:mShopId :mWineId :self];
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
-(void)initTheFoodImageScrollView:(int)pagenum
{
    self.mFoodScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(200, 49, 100, 100)];
    mFoodScrollView.contentSize = CGSizeMake(pagenum*100, 100);
    mFoodScrollView.pagingEnabled = YES;
    mFoodScrollView.showsHorizontalScrollIndicator=NO;
    mFoodScrollView.delegate = self;
    [self.view addSubview:mFoodScrollView];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(200, 144, 100, 36)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = pagenum;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    self.mDownLoadObjectArray = [NSMutableArray arrayWithCapacity:pagenum];
    for (int i = 0; i<pagenum; i++)
    {
        SDWebDownLoadObject * downobject = [[SDWebDownLoadObject alloc]init];
        downobject.delegate = self;
        downobject.index = i;
        [self.mDownLoadObjectArray addObject:downobject];
        [tempDownLoader downloadWithURL:[NSURL URLWithString:[[mFoodInfo objectAtIndex:i] objectForKey:@"cate_logo" ]] delegate:downobject];
    }
}
-(void)refreshFoodlabel:(int)index
{
    mFoodTitleLabel.text = [[mFoodInfo objectAtIndex:index] objectForKey:@"cate_name"];
    mFoodContentLabel.text = [[mFoodInfo objectAtIndex:index]objectForKey:@"cate_introduce"];
    
    CGSize size = [mFoodTitleLabel.text sizeWithFont:mFoodTitleLabel.font constrainedToSize:CGSizeMake(mFoodTitleLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mFoodTitleLabel.frame = CGRectMake(mFoodTitleLabel.frame.origin.x, mFoodTitleLabel.frame.origin.y, mFoodTitleLabel.frame.size.width, size.height);
    
    int height = mFoodTitleLabel.frame.origin.y+mFoodTitleLabel.frame.size.height;
    height+= 10;
    
    size = [mFoodContentLabel.text sizeWithFont:mFoodContentLabel.font constrainedToSize:CGSizeMake(mFoodContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mFoodContentLabel.frame = CGRectMake(mFoodContentLabel.frame.origin.x, height, mFoodContentLabel.frame.size.width, size.height);
    
    height+=size.height +10;
    mWineContentView.frame = CGRectMake(mWineContentView.frame.origin.x, height, mWineContentView.frame.size.width, mWineContentView.frame.size.height);
    
    height+=mWineContentView.frame.size.height +10;
    size = [mWineContentLabel.text sizeWithFont:mWineContentLabel.font constrainedToSize:CGSizeMake(mWineContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mWineContentLabel.frame = CGRectMake(mWineContentLabel.frame.origin.x, height, mWineContentLabel.frame.size.width, size.height);
    
    mScrollView.contentSize = CGSizeMake(320, mWineContentLabel.frame.origin.y+mWineContentLabel.frame.size.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    [self refreshFoodlabel:scrollView.contentOffset.x/100];
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
    NSArray * result = (NSArray*)[dic objectForKey:@"data"];
    [mFoodInfo addObjectsFromArray:result];
    [self initTheFoodImageScrollView:[mFoodInfo count]];
    [self refreshFoodlabel:0];
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    mWineImageView.image = [UIImage imageWithData:aData];
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
    
    [mFoodScrollView addSubview:tempimageView];
    tempimageView.frame = CGRectMake(index*100, 0, 100, 100);
}

#pragma mark PageControl
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // update the scroll view to the appropriate page
    CGRect frame = mFoodScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [mFoodScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark UIScrollViewDelegate
//滚动中
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = mFoodScrollView.frame.size.width;
    int curentScrollPage = floor((mFoodScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = curentScrollPage;
}
@end
