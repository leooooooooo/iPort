//
//  ViewController.m
//  iPort
//
//  Created by leo on 15/3/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *test = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 29, 29)];
    test.image = [UIImage imageNamed:@"29x29"];
    [self.view addSubview:test];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
