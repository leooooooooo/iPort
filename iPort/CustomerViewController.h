//
//  CustomerViewController.h
//  iPort
//
//  Created by zhangchao on 15/9/25.
//  Copyright © 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIWebViewDelegate>
@property(nonatomic,retain)NSMutableArray *List;
@property(nonatomic,retain)UICollectionView *collectionView;

@end
