//
//  EmployeeViewController.m
//  iPort
//
//  Created by zhangchao on 15/9/25.
//  Copyright © 2015年 leo. All rights reserved.
//

#import "IndexViewController.h"
#import <Leo/Leo.h>
#import "Header.h"
#import "AppDelegate.h"


#define TileBaseX               3
#define TileBaseY               100 - 100

#define PageSeparatorInset      100

#define BaseTag                 120

#define ColumnMaxTileCount      3
#define BaseButtonSize          2
#define NewsNumber              9


@interface IndexViewController ()
{
    UIScrollView *main;
    NSMutableDictionary *m_listTiles;
    
}
@end

@implementation IndexViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[Header NavigationConifigInitialize:self];
    
    //self.title = @"云港海运";
    
    m_listTiles = [[NSMutableDictionary alloc] init];
    
    main = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [self.view addSubview:main];
    [self addBaseTileButton];
    [self getMessageClassList];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
}


- (void) addBaseTileButton
{
    CGRect tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5, WIDTH*11/32);
    
    //今日待办
    [self createBaseTileButtonWithBtnIcon:1 withBtnTitle:@"待办事项" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset*2+((WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5), TileBaseY + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5, WIDTH*11/32);
    
    //今日待办
    [self createBaseTileButtonWithBtnIcon:10 withBtnTitle:@"已办查询" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset*3+((WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5)*2, TileBaseY + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*1/5-TileSeparatorInset, WIDTH*11/32);
    
    //今日待办
    [self createBaseTileButtonWithBtnIcon:11 withBtnTitle:@"协同审批" withFrame:tileFrame];
    
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + (WIDTH*9/16-TileSeparatorInset)/3+ TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5, (WIDTH*9/16-TileSeparatorInset)/3);
    
    //未读邮件
    [self createBaseTileButtonWithBtnIcon:2 withBtnTitle:@"企业邮箱" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset, (WIDTH*2/5-TileBaseX-TileSeparatorInset), (WIDTH*9/16-TileSeparatorInset)/3);
    
    
    //未读通告
    [self createBaseTileButtonWithBtnIcon:3 withBtnTitle:@"今日工作" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset + (WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5 + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*3/5, (WIDTH*9/32)*2+TileSeparatorInset);
    
    //RTX消息
    [self createBaseTileButtonWithBtnIcon:4 withBtnTitle:@"新闻中心" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + (WIDTH*9/16-TileSeparatorInset)*2/3+ 2*TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*3)*2/5, (WIDTH*9/16-TileSeparatorInset)/3);
    
    //网上公文
    [self createBaseTileButtonWithBtnIcon:5 withBtnTitle:@"通讯录" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*4)/3, WIDTH*11/32);
    
    //集团新闻
    [self createBaseTileButtonWithBtnIcon:6 withBtnTitle:@"今日快报" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset*2 + (WIDTH-TileBaseX*2-TileSeparatorInset*4)/3, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*4)/3, WIDTH*11/32);
    
    //集团新闻
    [self createBaseTileButtonWithBtnIcon:8 withBtnTitle:@"服务" withFrame:tileFrame];
    
    tileFrame = CGRectMake(TileBaseX + TileSeparatorInset*3 + (WIDTH-TileBaseX*2-TileSeparatorInset*4)*2/3, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset, (WIDTH-TileBaseX*2-TileSeparatorInset*4)/3, WIDTH*11/32);
    
    //集团新闻
    [self createBaseTileButtonWithBtnIcon:9 withBtnTitle:@"社交" withFrame:tileFrame];
    
    //tileFrame = CGRectMake(TileBaseX + TileSeparatorInset, TileBaseY + TileSeparatorInset + WIDTH*11/32 + TileSeparatorInset + WIDTH*9/32 + TileSeparatorInset + TileSeparatorInset +WIDTH*9/32 + TileSeparatorInset + WIDTH*11/32, WIDTH-(TileBaseX + TileSeparatorInset)*2, WIDTH*11/32);
    
    //待定
    //[self createBaseTileButtonWithBtnIcon:7 withBtnTitle:@"登出" withFrame:tileFrame];
    
    
    main.contentSize = CGSizeMake(WIDTH,tileFrame.origin.y+tileFrame.size.height+TileBaseX);
}

- (void) createBaseTileButtonWithBtnIcon : (NSInteger) index
                            withBtnTitle : (NSString *) btnTitle
                               withFrame : (CGRect) frame
{
    MessageButton *baseBtn = nil;
    
    if ([btnTitle isEqualToString:@"企业邮箱"] ||
        [btnTitle isEqualToString:@"登出"] ||
        [btnTitle isEqualToString:@"通讯录"] ||
        [btnTitle isEqualToString:@"协同审批"] ||
        [btnTitle isEqualToString:@"服务"] ||
        [btnTitle isEqualToString:@"社交"]) {
        
        baseBtn = [[MessageClassButton alloc] initWithFrame:frame];
        
    }else if ([btnTitle isEqualToString:@"今日工作"]) {
        baseBtn = [[MessageClassButton alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
    }else  if ([btnTitle isEqualToString:@"新闻中心"] ||
               [btnTitle isEqualToString:@"今日快报"]) {
        baseBtn = [[MessageListButtonnNoCount alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
    }else {
        baseBtn = [[MessageListButton alloc] initWithFrame:frame];
        [m_listTiles setObject:baseBtn forKey:btnTitle];
        
    }
    
    NSString *iconName = [NSString stringWithFormat:@"xx_%ld.png",(long)index];
    
    baseBtn.appIcon = [UIImage imageNamed:iconName];
    
    [main addSubview:baseBtn];
    
    [baseBtn addTarget:self action:@selector(clickMsgTileButton:) forControlEvents:UIControlEventTouchUpInside];
    
    baseBtn.strBtnTitle = btnTitle;
    
    baseBtn.tag = index + BaseTag;
    
}

- (void) getMessageClassList
{
    NSArray *names = [m_listTiles allKeys];
    for (NSString *name in names) {
        int mark = (int)[[[NSArray alloc]initWithObjects:@"新闻中心",@"待办事项",@"今日工作",@"今日快报",@"已办查询", nil] indexOfObject:name];
        
        NSString *URL = @"";
        
        
        switch (mark) {
            case 0://news
                URL = @"http://218.92.115.55/yghy/Service/News/GetAllNewsList.aspx?Pages=1";
                break;
            case 1://work
                URL = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/OA/GetTodayDealList.aspx?Logogram=%@",@"xuehui"];
                break;
            case 2://publish
                URL =  @"http://218.92.115.55/yghy/Service/GetNoticeList.aspx?Pages=1";
                break;
            case 3://ship
                URL =  @"http://218.92.115.55/yghy/Service/GetShipMovementList.aspx?Pages=1";
                break;
            case 4://worked
                URL = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/OA/GetTodayDealedList.aspx?Logogram=%@",@"xuehui"];
                break;
            default:
                break;
        }
        
        NSError *error;
        //加载一个NSURL对象
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
        [request setTimeoutInterval:60.0f];
        //将请求的url数据放到NSData对象中
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        NSObject *object = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        switch (mark) {
            case 0:
            {
                for (NSArray *arr in [((NSDictionary *)object) objectForKey:@"NewsList"]) {
                    [array addObject:[arr objectAtIndex:1]];
                }
            }
                break;
            case 1:[array addObjectsFromArray:(NSArray *)object];
                break;
            case 2:
            {
                for (NSArray *arr in [((NSDictionary *)object) objectForKey:@"NoticeList"]) {
                    [array addObject:[arr objectAtIndex:1]];
                }
            }
                break;
            case 3:
            {
                for (NSArray *arr in [((NSDictionary *)object) objectForKey:@"ShipList"]) {
                    [array addObject:[arr objectAtIndex:1]];
                }
            }
                break;
            case 4:[array addObjectsFromArray:(NSArray *)object];
                break;
            default:array = nil;
                break;
        }
        if (array.count>NewsNumber) {
            NSRange range = NSMakeRange(NewsNumber,array.count-NewsNumber);
            [array removeObjectsInRange:range];
        }
        NSMutableArray *tmpTitleArr = [[NSMutableArray alloc] initWithArray:array];
        
        
        [self setNewsTitle:tmpTitleArr withClassName:name];
        
    }
    
}

- (void) clickMsgTileButton : (id) sender
{
    MessageButton *appBtn = (MessageButton *)sender;
    NSLog(@"%d",(int)(appBtn.tag - BaseTag));
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = UUCloudWhite;
    switch (appBtn.tag - BaseTag) {
            /*
             case 1:
             case 2:
             case 10:
             case 11:{
             vc = [[OAViewController alloc]init];
             }
             break;
             case 3:{
             NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
             news.mark = (int)(appBtn.tag - BaseTag);
             news.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             vc=news;
             }
             break;
             case 4:{
             NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
             news.mark = (int)(appBtn.tag - BaseTag);
             news.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             vc=news;
             }
             break;
             case 5:{
             vc = [[ContactsViewController alloc]init];
             vc.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             }
             break;
             case 6:{
             vc = [[ExcelListTableViewController alloc]init];
             vc.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             }
             break;
             case 7:[self logout];
             break;
             case 8:{
             //vc = [[ExcelListTableViewController alloc]init];
             vc.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             }
             break;
             case 9:{
             //vc = [[ExcelListTableViewController alloc]init];
             vc.title = [[appBtn.strBtnTitle componentsSeparatedByString:@" "]objectAtIndex:0];
             }
             break;
             */
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) setNewsTitle : (NSArray *)titleList withClassName : (NSString *)className
{
    NSString *keyName = className;
    
    
    id tmpBtn = [m_listTiles objectForKey:keyName];
    
    if ([tmpBtn isKindOfClass:[MessageListButton class]]) {
        MessageListButton *msgButton = [m_listTiles objectForKey:keyName];
        msgButton.newsArr = titleList;
    }else if ([tmpBtn isKindOfClass:[MessageListButtonnNoCount class]]) {
        MessageListButtonnNoCount *msgButton = [m_listTiles objectForKey:keyName];
        msgButton.newsArr = titleList;
    }else if ([tmpBtn isKindOfClass:[MessageClassButton class]]) {
        if ([((MessageClassButton *)tmpBtn).strBtnTitle isEqualToString:@"今日工作"]) {
            ((MessageClassButton *)tmpBtn).strBtnTitle = [NSString stringWithFormat:@"%@ %lu",((MessageClassButton *)tmpBtn).strBtnTitle,(unsigned long)titleList.count];
        }
    }else {
        
    }
    
}
@end
