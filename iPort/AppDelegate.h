//
//  AppDelegate.h
//  iPort
//
//  Created by leo on 15/3/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(retain,nonatomic) NSString *ID;
@property(retain,nonatomic) NSString *UserName;
@property(retain,nonatomic) NSString *Department;
@property(retain,nonatomic) NSString *DeviceToken;
@property(retain,nonatomic) NSString *Code_User;
@property(retain,nonatomic) NSString *DeviceBinding;
@property(retain,nonatomic) NSString *Code_Company;
@property(retain,nonatomic) NSString *Code_Department;
@property(retain,nonatomic) NSString *RealName;
@property(retain,nonatomic) NSString *AvatarID;
@property(retain,nonatomic) NSString *SelfOrgCode;
@property(retain,nonatomic) NSString *SelfOrgName;
@property(retain,nonatomic) NSString *ConfigVersion;
@property(retain,nonatomic) NSString *Update;
@property(retain,nonatomic) NSString *Version;
@property(retain,nonatomic) NSString *Url;
@property(retain,nonatomic) NSDictionary *Authority;
@property(retain,nonatomic) NSArray *FunctionList;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

