//
//  MenuViewController.m
//  Drawer
//
//  Created by LI on 16/6/14.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
/** 记录当前选中按钮 */
@property (nonatomic,strong) UIButton * selectedButton;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加菜单按钮
    [self addMenuItems];
}

- (void)addMenuItems{
    
    //创建菜单栏上面的按钮
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.frame = CGRectMake(0, 100, 180, 44);
    item1.backgroundColor = [UIColor lightGrayColor];
    [item1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [item1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    item1.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:item1];
    item1.tag = 1;
    [item1 addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.selectedButton = item1;
    item1.selected = YES;
    
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.frame = CGRectMake(0, 144, 180, 44);
    item2.backgroundColor = [UIColor lightGrayColor];
    [item2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [item2 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    item2.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:item2];
    item2.tag = 2;
    [item2 addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
}

//选中菜单
- (void)menuItemSelected:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(menuViewController:didSelectItemAtIndex:)]) {
        self.selectedButton.selected = NO;
        btn.selected = YES;
        self.selectedButton = btn;
        [self.delegate menuViewController:self didSelectItemAtIndex:btn.tag - 1];
    }
}

@end
