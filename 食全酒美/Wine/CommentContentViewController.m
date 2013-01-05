//
//  CommentContentViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "CommentContentViewController.h"

@interface CommentContentViewController ()

@end

@implementation CommentContentViewController
@synthesize mShopId;
@synthesize mWineId;
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
    self.title = @"写评论";
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    
    [rightBtn setImage:[UIImage imageNamed:@"SendUnClicked.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"SendClicked.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(Send) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style=UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn release];
    [rightBarBtn release];
    
    mTextView.placeholder=@"输入评论文字";
    [mTextView setInputAccessoryView:editInputView];
    [mTextView becomeFirstResponder];
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
-(IBAction)XClicked:(id)sender{
    mTextView.text=@"";
}
#pragma mark UITextFieldDelegate Methods

- (void)textViewDidChange:(UITextView *)textView{
    numLabel.text=[NSString stringWithFormat:@"%i", 140-[mTextView.text length]];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([newText length]>140) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"评论文字最多140字!"];
        return NO;
    }
    
    return YES;
}
-(void)Send
{
    if (mShopId)
    {
        [dataHandler EventCommentRequestRecord:mShopId: mTextView.text:self];
    }
    else if(mWineId)
    {
        [dataHandler WineCommentRecord:mWineId :mTextView.text :self];
    }
    else
    {
        
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
    NSDictionary *dataDic = (NSDictionary*)[dic objectForKey:@"data"];
    NSString *flag=[dataDic objectForKey:@"flag"];
    if (flag) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"评论发送成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
@end
