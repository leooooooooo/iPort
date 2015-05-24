//
//  NavigationViewController.m
//  iPort
//
//  Created by zhangchao on 15/4/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "NavigationViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangePersonInfoViewController.h"
#import "DeviceBindingViewController.h"
#import "Header.h"
#import "AppDelegate.h"

@interface NavigationViewController () <REMenuDelegate>

@property (strong, readwrite, nonatomic) REMenu *menu;

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*if (REUIKitIsFlatMode()) {
        [self.navigationBar performSelector:@selector(setBarTintColor:) withObject:[UIColor colorWithRed:0/255.0 green:213/255.0 blue:161/255.0 alpha:1]];
        self.navigationBar.tintColor = [UIColor whiteColor];
    } else {
        self.navigationBar.tintColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
    }*/
    

    
    __typeof (self) __weak weakSelf = self;
    REMenuItem *Index = [[REMenuItem alloc] initWithTitle:@"首页"
                                                       subtitle:@"iPort功能模块"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             RootViewController *controller = [[RootViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    REMenuItem *ChangePersonInfo = [[REMenuItem alloc] initWithTitle:@"个人信息维护"
                                                    subtitle:@"修改邮箱，手机号，工作电话"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                          ChangePersonInfoViewController *controller = [[ChangePersonInfoViewController alloc] init];
                                                          [weakSelf setViewControllers:@[controller] animated:NO];
                                                      }];
    

    
    REMenuItem *ChangePassword = [[REMenuItem alloc] initWithTitle:@"修改密码"
                                                        subtitle:@"修改密码"
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                              ChangePasswordViewController *controller = [[ChangePasswordViewController alloc] init];
                                                              [weakSelf setViewControllers:@[controller] animated:NO];
                                                          }];
    
    //activityItem.badge = @"12";
    
    REMenuItem *DeviceBinding = [[REMenuItem alloc] initWithTitle:@"设备绑定"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             DeviceBindingViewController *controller = [[DeviceBindingViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    REMenuItem *LoginOut = [[REMenuItem alloc] initWithTitle:@"登出"
                                                            image:[UIImage imageNamed:@"Icon_Profile"]
                                                 highlightedImage:nil
                                                      action:^(REMenuItem *item) {[self Logout];}];
    
    // You can also assign a custom view for any particular item
    // Uncomment the code below and add `customViewItem` to `initWithItems` array, for example:
    // self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]]
    //
    /*
     UIView *customView = [[UIView alloc] init];
     customView.backgroundColor = [UIColor blueColor];
     customView.alpha = 0.4;
     REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
     NSLog(@"Tap on customView");
     }];
     */
    
    Index.tag = 0;
    ChangePersonInfo.tag = 1;
    ChangePassword.tag = 2;
    DeviceBinding.tag = 3;
    LoginOut.tag =4;
    
    self.menu = [[REMenu alloc] initWithItems:@[Index, ChangePersonInfo, ChangePassword, DeviceBinding,LoginOut]];
    
    // Background view
    //
    //self.menu.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //self.menu.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.menu.backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.600];
    
    //self.menu.imageAlignment = REMenuImageAlignmentRight;
    //self.menu.closeOnSelection = NO;
    //self.menu.appearsBehindNavigationBar = NO; // Affects only iOS 7
    if (!REUIKitIsFlatMode()) {
        self.menu.cornerRadius = 4;
        self.menu.shadowRadius = 4;
        self.menu.shadowColor = [UIColor blackColor];
        self.menu.shadowOffset = CGSizeMake(0, 1);
        self.menu.shadowOpacity = 1;
    }
    
    // Blurred background in iOS 7
    //
    //self.menu.liveBlur = YES;
    //self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleDark;
    
    self.menu.separatorOffset = CGSizeMake(15.0, 0.0);
    self.menu.imageOffset = CGSizeMake(5, -1);
    self.menu.waitUntilAnimationIsComplete = NO;
    self.menu.badgeLabelConfigurationBlock = ^(UILabel *badgeLabel, REMenuItem *item) {
        badgeLabel.backgroundColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        badgeLabel.layer.borderColor = [UIColor colorWithRed:0.000 green:0.648 blue:0.507 alpha:1.000].CGColor;
    };
    self.menu.delegate = self;
    
    
    [self.menu setClosePreparationBlock:^{
        //NSLog(@"Menu will close");
    }];
    
    [self.menu setCloseCompletionHandler:^{
        //NSLog(@"Menu did close");
    }];
    
}

-(void)Logout
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.DeviceToken = nil;
    delegate.Code_User= nil;
    delegate.DeviceBinding= nil;
    delegate.Code_Company= nil;
    delegate.Code_Department= nil;
    delegate.UserName= nil;
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Logout Success!");
}

- (void)toggleMenu
{
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showFromNavigationController:self];
}

#pragma mark - REMenu Delegate Methods

-(void)willOpenMenu:(REMenu *)menu
{
    //NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didOpenMenu:(REMenu *)menu
{
    //NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)willCloseMenu:(REMenu *)menu
{
    //NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didCloseMenu:(REMenu *)menu
{
    //NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

@end
