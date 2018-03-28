//
//  ContainerViewController.m
//  Drawer
//
//  Created by LI on 16/6/14.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "CustomNavigationController.h"

/** 子控制器 */
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "NewsViewController.h"

@interface ContainerViewController ()<MenuViewControllerDelegate>

/** 菜单控制器 */
@property (strong, nonatomic) MenuViewController *menuViewController;
/** 用来存放和记录当前呈现的主控制器界面 */
@property (strong, nonatomic) UIViewController *contentViewController;
/** 记录容器控制器中要管理几个这个界面 */
@property (strong, nonatomic) NSArray *viewControllers;
/** 记录视图控制器在数组中的位置 */
@property (assign, nonatomic) NSUInteger controllerIndex;
/** 判断动画是否在执行 */
@property (assign, nonatomic) BOOL isAnimating;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加菜单控制器
    [self addMenuViewController];
    
    //添加子控制器
    [self addContentControllers];
}

//封装菜单界面
- (void)addMenuViewController{
    //添加菜单控制器
    self.menuViewController = [[MenuViewController alloc] init];
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    self.menuViewController.delegate = self;
}

//添加子控制器对象
- (void)addContentControllers{
    //完成两个主控制器的添加
    HomeViewController *home = [[HomeViewController alloc] init];
    CustomNavigationController *homeNav = [[CustomNavigationController alloc] initWithRootViewController:home];
    
    MessageViewController *message = [[MessageViewController alloc] init];
    CustomNavigationController *messageNav = [[CustomNavigationController alloc] initWithRootViewController:message];
    
    NewsViewController *news = [[NewsViewController alloc] init];
    CustomNavigationController *newNav = [[CustomNavigationController alloc] initWithRootViewController:news];
    
    self.viewControllers = @[homeNav,messageNav,newNav];
    self.contentViewController = homeNav;
}

//完成控制器的添加和移除
- (void)setContentViewController:(UIViewController *)contentViewController{
    if (_contentViewController == contentViewController) return;

    //解决内容控制器起始坐标不一致
    if (_contentViewController) {
        contentViewController.view.transform = _contentViewController.view.transform;
    }
    
    [_contentViewController willMoveToParentViewController:nil];
    //移除旧的视图
    [_contentViewController.view removeFromSuperview];
    //解除父子关系
    [_contentViewController removeFromParentViewController];
    
    //增添传进来的视图
    _contentViewController = contentViewController;
    [self addChildViewController:contentViewController];
    [self.view addSubview:contentViewController.view];
}

//侧边按钮的动画
- (void)openCloseMenu{
    CustomNavigationController *custom = (CustomNavigationController *)self.contentViewController;
    [custom.cover removeFromSuperview];
    if (self.isAnimating) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.isAnimating = YES;
        if (!custom.isMenuOpen) {
            self.contentViewController.view.transform = CGAffineTransformMakeTranslation(180, 0);
            [self.contentViewController.view addSubview:custom.cover];
            
        }else{
            self.contentViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        custom.isMenuOpen = !custom.isMenuOpen;
        //根据角标设置控制器
        self.contentViewController = self.viewControllers[self.controllerIndex];
        if (!custom.isMenuOpen) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.contentViewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.isAnimating = NO;
            }];
        }else{
            self.isAnimating = NO;
        }
//        self.isAnimating = NO;
    }];
}

#pragma mark - MenuViewControllerDelegate
- (void)menuViewController:(MenuViewController *)controller didSelectItemAtIndex:(NSUInteger)index
{
    self.controllerIndex = index;
    [self openCloseMenu];
}

@end
