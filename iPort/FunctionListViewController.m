//
//  FunctionListViewController.m
//  iPort
//
//  Created by zhangchao on 15/4/8.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "FunctionListViewController.h"

#import "CLTree.h"

@interface FunctionListViewController ()

@property(strong,nonatomic) NSMutableArray* dataArray; //保存全部数据的数组
@property(strong,nonatomic) NSArray *displayArray;   //保存要显示在界面上的数据的数组

@end

@implementation FunctionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTableView = [[UITableView alloc]init];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    CGRect tableViewFrame = CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height);
    self.myTableView.frame = tableViewFrame;
    [self.view addSubview:self.myTableView];
    [self addTestData];//添加演示数据
    [self reloadDataForDisplayArray];//初始化将要显示的数据
}

//添加演示数据
-(void) addTestData{
    NSMutableArray * data1 = [[NSMutableArray alloc]initWithObjects:@"1",@"第一个功能",@"0",@"0", nil];
    NSMutableArray * data2 = [[NSMutableArray alloc]initWithObjects:@"1",@"第一个功能",@"0",@"0", nil];
    NSMutableArray * data3 = [[NSMutableArray alloc]initWithObjects:@"1",@"第一个功能",@"0",@"0", nil];
    NSMutableArray * data = [[NSMutableArray alloc]initWithObjects:data1,data2,data3, nil];

    for (int i =0; i<data.count; i++) {
        
    }
    CLTreeViewNode *node0 = [[CLTreeViewNode alloc]init];
    node0.nodeLevel = 0;
    node0.type = 0;
    node0.sonNodes = nil;
    CLTreeView_LEVEL0_Model *tmp0 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp0.name = @"收藏";
    node0.nodeData = tmp0;
    
    CLTreeViewNode *node1 = [[CLTreeViewNode alloc]init];
    node1.nodeLevel = 0;
    node1.type = 0;
    node1.sonNodes = nil;
    CLTreeView_LEVEL0_Model *tmp1 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp1.name = @"软件技术";
    node1.nodeData = tmp1;
    
    CLTreeViewNode *node2 = [[CLTreeViewNode alloc]init];
    node2.nodeLevel = 0;
    node2.type = 0;
    node2.sonNodes = nil;
    CLTreeView_LEVEL0_Model *tmp2 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp2.name = @"信息工程";
    node2.nodeData = tmp2;
    
    CLTreeViewNode *node3 = [[CLTreeViewNode alloc]init];
    node3.nodeLevel = 1;
    node3.type = 1;
    node3.sonNodes = nil;
    CLTreeView_LEVEL1_Model *tmp3 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp3.name = @"软件技术1班";
    tmp3.sonCnt = @"3";
    node3.nodeData = tmp3;
    
    CLTreeViewNode *node4 = [[CLTreeViewNode alloc]init];
    node4.nodeLevel = 1;
    node4.type = 1;
    node4.sonNodes = nil;
    CLTreeView_LEVEL1_Model *tmp4 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp4.name = @"软件技术2班";
    tmp4.sonCnt = @"1";
    node4.nodeData = tmp4;
    
    CLTreeViewNode *node5 = [[CLTreeViewNode alloc]init];
    node5.nodeLevel = 2;
    node5.type = 2;
    node5.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp5 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp5.name = @"flywarrior";
    node5.nodeData = tmp5;
    
    CLTreeViewNode *node6 = [[CLTreeViewNode alloc]init];
    node6.nodeLevel = 2;
    node6.type = 2;
    node6.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp6 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp6.name = @"flywarrior2";
    node6.nodeData = tmp6;
    
    CLTreeViewNode *node7 = [[CLTreeViewNode alloc]init];
    node7.nodeLevel = 2;
    node7.type = 2;
    node7.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp7 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp7.name = @"李四";
    node7.nodeData = tmp7;
    
    CLTreeViewNode *node8 = [[CLTreeViewNode alloc]init];
    node8.nodeLevel = 2;
    node8.type = 2;
    node8.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp8 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp8.name = @"田七";
    node8.nodeData = tmp8;
    
    CLTreeViewNode *node9 = [[CLTreeViewNode alloc]init];
    node9.nodeLevel = 2;
    node9.type = 2;
    node9.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp9 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp9.name = @"王大锤";
    node9.nodeData = tmp9;
    
    CLTreeViewNode *node10 = [[CLTreeViewNode alloc]init];
    node10.nodeLevel = 2;
    node10.type = 2;
    node10.sonNodes = nil;
    CLTreeView_LEVEL2_Model *tmp10 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp10.name = @"孔连顺";
    node10.nodeData = tmp10;
    
    node0.sonNodes = [NSMutableArray arrayWithObjects:node8,node9,nil];
    node1.sonNodes = [NSMutableArray arrayWithObjects:node3,node4,nil];
    node3.sonNodes = [NSMutableArray arrayWithObjects:node5,node7,node10,nil];
    node4.sonNodes = [NSMutableArray arrayWithObjects:node6,nil];
    self.dataArray = [NSMutableArray arrayWithObjects:node0,node1,node2, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return self.displayArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"level0cell";
    static NSString *indentifier1 = @"level1cell";
    static NSString *indentifier2 = @"level2cell";
    CLTreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    
    if(node.type == 0){//类型为0的cell
        CLTreeView_LEVEL0_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level0_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];//重新给cell装载数据
        [cell setNeedsDisplay]; //重新描绘cell
        return cell;
    }
    else if(node.type == 1){//类型为1的cell
        CLTreeView_LEVEL1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier1];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level1_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }
    else{//类型为2的cell
        CLTreeView_LEVEL2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier2];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Level2_Cell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }
}

/*---------------------------------------
 为不同类型cell填充数据
 --------------------------------------- */
-(void) loadDataForTreeViewCell:(UITableViewCell*)cell with:(CLTreeViewNode*)node{
    if(node.type == 0){
        CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL0_Cell*)cell).name.text = nodeData.name;
    }
    
    else if(node.type == 1){
        CLTreeView_LEVEL1_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL1_Cell*)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL1_Cell*)cell).sonCount.text = nodeData.sonCnt;
    }
    
    else{
        CLTreeView_LEVEL2_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL2_Cell*)cell).name.text = nodeData.name;
    }
}

/*---------------------------------------
 cell高度默认为50
 --------------------------------------- */
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}

/*---------------------------------------
 处理cell选中事件，需要自定义的部分
 --------------------------------------- */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];//修改cell的状态(关闭或打开)
    if(node.type == 2){
        //处理叶子节点选中，此处需要自定义
        CLTreeView_LEVEL2_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSLog(cell.name.text,nil);
    }
    else{
        CLTreeView_LEVEL0_Cell *cell = (CLTreeView_LEVEL0_Cell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.node.isExpanded ){
            [self rotateArrow:cell with:M_PI_2];
        }
        else{
            [self rotateArrow:cell with:0];
        }
    }
}

/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(CLTreeView_LEVEL0_Cell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.arrowView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

/*---------------------------------------
 初始化将要显示的cell的数据
 --------------------------------------- */
-(void) reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (CLTreeViewNode *node in self.dataArray) {
        [tmp addObject:node];
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                    }
                }
            }
        }
    }
    self.displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}

/*---------------------------------------
 修改cell的状态(关闭或打开)
 --------------------------------------- */
-(void) reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt=0;
    for (CLTreeViewNode *node in self.dataArray) {
        [tmp addObject:node];
        if(cnt == row){
            node.isExpanded = !node.isExpanded;
        }
        ++cnt;
        if(node.isExpanded){
            for(CLTreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(cnt == row){
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if(node2.isExpanded){
                    for(CLTreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    self.displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}
@end
