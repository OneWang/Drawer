//
//  CustomNavigationController.h
//  PanGestureRecognizer
//
//  Created by LI on 16/3/23.
//  Copyright © 2016年 LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController
/** 覆盖在视图上的一层 */
@property (nonatomic, strong) UIButton *cover;
/** 标记当前菜单是否打开还是关闭状态 */
@property (assign, nonatomic) BOOL isMenuOpen;
@end
