//
//  HomeViewController.m
//  Drawer
//
//  Created by LI on 16/6/14.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "HomeViewController.h"
#import "ContainerViewController.h"
#import "SettingViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self customNavigation];
    
}

- (void)customNavigation{
    //设置标题背景
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    //投影颜色,偏移显示,投影透明度,投影半径
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.5;
    self.navigationController.view.layer.shadowRadius = 5;
    
    //菜单按钮的设置
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    //下一页按钮的设置
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage:)];
    self.navigationItem.rightBarButtonItem = nextItem;
}

/** 侧边栏的展开和关闭 */
- (void)openCloseMenu:(UIBarButtonItem *)sender{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

/** 下一页按钮 */
- (void)nextPage:(UIBarButtonItem *)sender{
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

@end
