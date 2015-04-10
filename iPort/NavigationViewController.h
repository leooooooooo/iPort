//
//  NavigationViewController.h
//  iPort
//
//  Created by zhangchao on 15/4/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"

@interface NavigationViewController : UINavigationController

@property (strong, readonly, nonatomic) REMenu *menu;

- (void)toggleMenu;

@end
