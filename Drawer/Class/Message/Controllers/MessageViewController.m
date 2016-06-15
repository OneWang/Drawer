//
//  MessageViewController.m
//  Drawer
//
//  Created by LI on 16/6/14.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "MessageViewController.h"
#import "ContainerViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self customNavigation];
}

- (void)customNavigation{
    //设置标题背景
    self.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    //投影颜色,偏移显示,投影透明度,投影半径
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
    
    //菜单按钮的设置
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
}

/** 侧边栏的展开和关闭 */
- (void)openCloseMenu:(UIBarButtonItem *)sender{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

- (void)dealloc
{
    NSLog(@"MessageViewController----dealloc");
}

@end
