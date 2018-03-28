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
    UIButton *item1 = [self createItemTitle:@"按钮1" withFrame:CGRectMake(0, 100, 180, 44) withFontSize:20 withAction:@selector(menuItemSelected:) withTag:1];
    self.selectedButton = item1;
    item1.selected = YES;
    
    [self addItemTitle:@"按钮2" withFrame:CGRectMake(0, 144, 180, 44) withFontSize:20 withAction:@selector(menuItemSelected:) withTag:2];
    
    [self addItemTitle:@"按钮3" withFrame:CGRectMake(0, 188, 180, 44) withFontSize:20 withAction:@selector(menuItemSelected:) withTag:3];
}

- (UIButton *)createItemTitle:(NSString *)title withFrame:(CGRect)frame withFontSize:(CGFloat)size withAction:(SEL)sel withTag:(NSUInteger)tag{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = frame;
    item.backgroundColor = [UIColor lightGrayColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:size];
    [self.view addSubview:item];
    item.tag = tag;
    [item addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return item;
}

- (void)addItemTitle:(NSString *)title withFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withAction:(SEL)sel withTag:(NSUInteger)tag{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = frame;
    item.backgroundColor = [UIColor lightGrayColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:item];
    item.tag = tag;
    [item addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
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
