//
//  AboutUsViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-26.
//
//

#import "AboutUsViewController.h"

#define ABOUTTEXT @"　　M9M10食全酒美出品，觅酒觅食最佳法宝！"\
"\r\n"\
"\r\n"\
"　　M9M10(觅酒觅食)必须向吃货们推荐的一站式美酒美食搭配软件，让爱美酒的你更轻松、便捷、迅速地挖掘到你最中意的餐厅。"\
"\r\n"\
"　　M9M10(美酒美食)舔舔美酒，逛逛餐厅，看看风景是社交达人的必备产品！每天带给你新鲜的葡萄酒信息，每周带你吃喝玩乐IN上海，每月带你领略各种不同PARTY。拥有了“她”让你不想变成“万人迷”都很难噢~"\
"\r\n"\
"　　M9M10我们为亲爱的您精心挑选了最入流的餐厅，最精致的美酒搭配，全上海最值得一偿的美味佳肴与最诱惑的餐酒活动优惠。全面为你解决每次为了约会、聚餐、商务宴请喝什么要去哪里的“纠结综合症”！"\
"\r\n"\
"\r\n"\
"　　悄悄带你进入食全酒美的大门，从食全才会酒美开始！"\
"\r\n"\
"　　食全十美？我们更爱食全酒美! "

@implementation AboutUsViewController

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
    self.title = @"关于我们";
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

#pragma mark Table view methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutCell *cell = nil;//[self.tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    switch (indexPath.row) {
        case 0://"0":人人猎头介绍
        {
            if (cell == nil) {
                NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:nil options:nil];
                cell = (AboutCell *)[nibArray objectAtIndex:0];
            }
            
            CGSize size = [ABOUTTEXT sizeWithFont:cell.tipLabel.font constrainedToSize:CGSizeMake(cell.tipLabel.frame.size.width, 99999999.0f) lineBreakMode:UILineBreakModeWordWrap];
            CGRect frame = cell.tipLabel.frame;
            frame.size.height=size.height;
            cell.tipLabel.frame = frame;
            cell.tipLabel.text=ABOUTTEXT;
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case 1://"1":版本
        {
            if (cell == nil) {
                NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:nil options:nil];
                cell = (AboutCell *)[nibArray objectAtIndex:0];
            }
            
            cell.tipLabel.text=@"版本:1.0.1";
            //cell.tipLabel.text=[NSString stringWithFormat:@"版本:%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case 2://"2":全国客服电话
        default:
        {
            if (cell == nil) {
                NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:nil options:nil];
                cell = (AboutCell *)[nibArray objectAtIndex:0];
            }
            
            cell.tipLabel.text=@"全国客服电话:400-086-0910";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            break;
        }
        case 3://"3":网址
        {
            if (cell == nil) {
                NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:nil options:nil];
                cell = (AboutCell *)[nibArray objectAtIndex:0];
            }
            
            cell.tipLabel.text=@"网址:http://www.m9m10.cn";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            break;
        }
        case 4://"4":服务条款
        {
            if (cell == nil) {
                NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:nil options:nil];
                cell = (AboutCell *)[nibArray objectAtIndex:0];
            }
            
            cell.tipLabel.text=@"服务条款";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            break;
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0://"0":人人猎头介绍
        {
            CGSize size = [ABOUTTEXT sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, 99999999.0f) lineBreakMode:UILineBreakModeWordWrap];
            
            return size.height+22;
            break;
        }
        default:
            return 44;
            break;
    }
}

/*
 - (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
 return UITableViewCellAccessoryDisclosureIndicator;
 }
 */

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 2://"2":全国客服电话
        {
            NSString* urlPath = @"tel:4000860910";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
            break;
        }
        case 3://"3":网址
        {
            //打开safari浏览器
            NSString* urlPath = @"http://www.m9m10.cn";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
            break;
        }
        case 4://"4":服务条款
        {
            PrivacyViewController * temp = [[PrivacyViewController alloc]init];
            [self.navigationController pushViewController:temp animated:YES];
            [temp release];
            break;
        }
        default:
            break;
    }
}

/*
 // Override to support conditional editing of the table view.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	return NO;
}
@end
