//
//  RootViewController.m
//  iPort
//
//  Created by zhangchao on 15/4/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "UITableGridViewCell.h"
#import "UIImageButton.h"
#import "FunctionListViewController.h"

#define kImageWidth  self.view.bounds.size.width/4 //UITableViewCell里面图片的宽度
#define kImageHeight  self.view.bounds.size.width/4  //UITableViewCell里面图片的高度
@interface RootViewController()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *image;
@end


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    // Here self.navigationController is an instance of NavigationViewController (which is a root controller for the main window)
    //

    //返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    //导航栏按钮文字颜色+返回按钮颜色
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    //导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    
    //导航栏标题颜色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    //导航栏标题
    self.navigationItem.title =@"首页";//[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName];
    //导航栏左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[self reSizeImage:[UIImage imageNamed:@"登录_07"] toSize:CGSizeMake(20, 24)] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"登录"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    //中央ViewController名
    /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 500, 40)];
    label.text = NSStringFromClass(self.class);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:21];
    label.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:label];
    */
    
    UILabel *welcome =[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16, self.view.bounds.size.width/8, self.view.bounds.size.width, 200)];
    welcome.numberOfLines = 4;
    welcome.text=[NSString stringWithFormat:@"你好,%@\n欢迎使用iPort移动版\n当前位置 %@\n今天是2015年4月15日，气温4～18℃，晴天",[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName],[(AppDelegate *)[[UIApplication sharedApplication]delegate]Department]];
    [self.view addSubview:welcome];
    
    UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"登录"]];
    self.image = [self reSizeImage:[UIImage imageNamed:@"contacts_collect@2x.png"] toSize:CGSizeMake(kImageWidth, kImageHeight)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width*2/3, self.view.bounds.size.width, self.view.bounds.size.height*2/3) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView= back;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NavigationViewController *navigationController = (NavigationViewController *)self.navigationController;
    [navigationController.menu setNeedsLayout];
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

#pragma mark UITable datasource and delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    //自定义UITableGridViewCell，里面加了个NSArray用于放置里面的3个图片按钮
    UITableGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIView alloc] init];
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            //自定义继续UIButton的UIImageButton 里面只是加了2个row和column属性
            UIImageButton *button = [UIImageButton buttonWithType:UIButtonTypeCustom];
            button.bounds = CGRectMake(0, 0, kImageWidth, kImageHeight);
            button.center = CGPointMake((1 + i) * (self.view.bounds.size.width/16 + kImageWidth) - kImageWidth * 0.5 ,  self.view.bounds.size.width/4 );
            //button.column = i;
            [button setValue:[NSNumber numberWithInt:i] forKey:@"column"];
            [button addTarget:self action:@selector(imageItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:self.image forState:UIControlStateNormal];
            [cell addSubview:button];
            [array addObject:button];
        }
        [cell setValue:array forKey:@"buttons"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //获取到里面的cell里面的3个图片按钮引用
    NSArray *imageButtons =cell.buttons;
    //设置UIImageButton里面的row属性
    [imageButtons setValue:[NSNumber numberWithInt:(int)indexPath.row] forKey:@"row"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return kImageHeight *2.5;
    }
    return kImageHeight *1.25;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)imageItemClick:(UIImageButton *)button{
    NSArray *list = [[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"商务",@"生产",@"库场",nil],[NSArray arrayWithObjects:@"财务" ,@"物流" ,@"设备" , nil],[NSArray arrayWithObjects:@"物资" ,@"能源" ,@"船调" , nil], nil];
    /*
    NSString *msg = [NSString stringWithFormat:[[list objectAtIndex:button.row]objectAtIndex:button.column],nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"好"
                                          otherButtonTitles:nil, nil];
    [alert show];
     */
    FunctionListViewController *FunctionList =  [self.storyboard instantiateViewControllerWithIdentifier:@"FunctionList"];
    FunctionList.navigationItem.title =[[list objectAtIndex:button.row]objectAtIndex:button.column];
    [self.navigationController pushViewController:FunctionList animated:YES];
}

@end
