//
//  ViewController.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "IndexViewController.h"
#import "MainNavigationController.h"
#import "MainTabBarViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.ID.layer.cornerRadius=5;
    self.ID.borderStyle=UITextBorderStyleRoundedRect;
    self.PW.layer.cornerRadius=5;
    self.PW.borderStyle=UITextBorderStyleRoundedRect;
    self.signin.layer.cornerRadius=5;
    
    //keychain
    self.keepkeyswitch.on = NO;
    self.autologinswitch.on = NO;
    
    //自动更新
    Update *up = [[Update alloc]init];
    [self.view addSubview:[up GetUpdateInfo:AppName showVersionMarkAnchorPoint:CGPointMake(20, HEIGHT-85) NowVersionColor:UUBlack NewVersionColor:UUBlack]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //从keychain里取出帐号密码状态
    KeyChain = [NSUserDefaults standardUserDefaults];
    
    self.keepkeyswitch.on = [KeyChain boolForKey:@"KeepKey"];
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];
    self.ID.text = [KeyChain objectForKey:@"UserName"];
    self.PW.text = [KeyChain objectForKey:@"Password"];
    
    
    if ([KeyChain boolForKey:@"AutoLogin"]) {
        [self signinbt];
    }
    
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];
    
}


-(IBAction)signinbt{
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:Server,@"MobilePlatform/Login.aspx"];
    
    NSString *bodyStr = [NSString stringWithFormat:@"Logogram=%@&Password=%@&DeviceToken=%@&DeviceType=iOS&AppName=%@", self.ID.text, self.PW.text,[(AppDelegate *)[[UIApplication sharedApplication]delegate]DeviceToken],AppName];
    
    id Info = [Post getSynchronousRequestDataJSONSerializationWithURL:urlString withHTTPBody:bodyStr Delegate:self];

    if (isValid(Info))
    {
        
        NSLog(@"%@", Info);
        
        UIAlertView *alert;
        if(!isValid([Info objectForKey:@"Message"]))
        {
            
            //保存登录信息
            AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            delegate.ID=[Info objectForKey:@"ID"];
            delegate.UserName=[Info objectForKey:@"UserName"];
            
            delegate.RealName=[Info objectForKey:@"RealName"];
            delegate.AvatarID=[Info objectForKey:@"AvatarID"];
            delegate.SelfOrgCode=[Info objectForKey:@"SelfOrgCode"];
            delegate.SelfOrgName=[Info objectForKey:@"SelfOrgName"];
            delegate.ConfigVersion=[Info objectForKey:@"ConfigVersion"];
            
            MainTabBarViewController *index = [[MainTabBarViewController alloc]init];
            MainNavigationController *mainViewController=[[MainNavigationController alloc]initWithRootViewController:index];
            
            [self presentViewController:mainViewController animated:YES completion:nil];
            
            
            
            //保存按钮状态
            [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
            [KeyChain setBool:self.keepkeyswitch.isOn forKey:@"KeepKey"];
            [KeyChain synchronize];
            
            if (self.keepkeyswitch.isOn) {
                [KeyChain setObject:self.ID.text forKey:@"UserName"];
                [KeyChain setObject:self.PW.text forKey:@"Password"];
                [KeyChain synchronize];
            }
        }
        else
        {
            alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[Info objectForKey:@"Message"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)keepkey:(id)sender {
    if (![sender isOn]){
        [KeyChain removeObjectForKey:@"Password"];
    }
}

- (IBAction)autologin:(id)sender {
    [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
}

- (IBAction)keyboarddisapper:(id)sender {
    [self.ID resignFirstResponder];
    [self.PW resignFirstResponder];
}

- (IBAction)topassword:(id)sender {
    [self.PW becomeFirstResponder];
}

- (IBAction)dis:(id)sender {
    [sender resignFirstResponder];
}
@end

