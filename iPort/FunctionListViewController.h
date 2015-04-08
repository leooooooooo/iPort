//
//  FunctionListViewController.h
//  iPort
//
//  Created by zhangchao on 15/4/8.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* myTableView;

@end