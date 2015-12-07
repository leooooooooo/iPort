//
//  SettingTableViewController.h
//  iPort
//
//  Created by zhangchao on 15/9/25.
//  Copyright © 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) NSArray *stuArray;//学生资料
@property (retain,nonatomic) NSArray *teaArray;//老师资料
@end
