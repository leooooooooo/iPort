//
//  RootViewController.m
//  iPort
//
//  Created by zhangchao on 15/4/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "RootViewController.h"
#import "IndexViewController.h"
#import "NavigationViewController.h"
#import "Header.h"
#import "AppDelegate.h"

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
    self.navigationItem.title =[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName];
    //导航栏左按钮
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[self reSizeImage:[UIImage imageNamed:@"登录_07"] toSize:CGSizeMake(20, 24)] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"登录"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    // Demo label to show current controller class
    //
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = NSStringFromClass(self.class);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:21];
    label.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:label];
     
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

@end
