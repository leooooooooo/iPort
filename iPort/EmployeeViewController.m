//
//  EmployeeViewController.m
//  iPort
//
//  Created by zhangchao on 15/9/25.
//  Copyright © 2015年 leo. All rights reserved.
//

#import "EmployeeViewController.h"
#import <Leo/Leo.h>
#import "Header.h"
#import "AppDelegate.h"



@interface EmployeeViewController ()
{
}
@end

@implementation EmployeeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.delegate = [[UIApplication sharedApplication]delegate];
    
    
    //初始化二级菜单
    
    //self.delegate.FunctionList =
    // Do any additional setup after loading the view.
    //[Header NavigationConifigInitialize:self];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getList];
}

-(void)getList
{
    NSDictionary *data = [Post getSynchronousRequestDataJSONSerializationWithURL:[NSString stringWithFormat:BasicServer,@"App/GetAppList.aspx"] withHTTPBody:@"DeviceType=iOS&AppType=0"];
    self.List = [data valueForKey:@"Data"];
    //self.List = [[NSDictionary alloc]initWithObjectsAndKeys:@"http://boea.cn/MobilePlatform/Install.aspx?AppName=MYLYGPORT",@"MyLygport", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self customCellByXib:tableView withIndexPath:indexPath];
    
    //通过nib自定义cell
    
    
    
    //default:assert(cell !=nil);
    //break;
    
    
    
    return cell;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = 2;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
        
        //发送者
        CGPoint i =imageRect.origin;
        CGSize j = imageRect.size;
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+8, WIDTH/1.5, 20);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *name = [[self.List objectAtIndex:indexPath.row]objectAtIndex:1];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [[self.List objectAtIndex:indexPath.row]objectAtIndex:2];
    
    NSString *path = [[NSString stringWithFormat:@"Mobile_App/AppIcon/%@.png",name]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *URL =[NSString stringWithFormat:Server,path];
    NSLog(URL);
    UIImage *Icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = Icon;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *FunctionName =[[self.List objectAtIndex:indexPath.row]objectAtIndex:0];
    NSLog(FunctionName,nil);
    
    NSString *URL = [self.List valueForKey:FunctionName];
    
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    UIView *view =[[UIView alloc]init];
    for (UIWindow *window in frontToBackWindows)
        if (window.windowLevel == UIWindowLevelNormal) {
            view = window.viewForBaselineLayout;
            break;
        }
    
    
    UIWebView *up = [[UIWebView alloc]init];
    NSURL *url =[NSURL URLWithString:URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [up loadRequest:request];
    [view addSubview:up];
    NSLog(@"开始更新%@",URL,nil);
    
}
@end
