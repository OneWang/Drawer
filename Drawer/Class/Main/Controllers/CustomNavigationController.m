//
//  CustomNavigationController.m
//  PanGestureRecognizer
//
//  Created by LI on 16/3/23.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

/** 存放每一个控制器的全屏截图 */
@property (strong, nonatomic) NSMutableArray *images;

@property (nonatomic, strong) UIImageView *lastVcView;
//@property (nonatomic, strong) UIView *cover;

@end

@implementation CustomNavigationController

#pragma mark 懒加载
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (UIImageView *)lastVcView
{
    if (!_lastVcView) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        UIImageView * image = [[UIImageView alloc] init];
        image.frame = window.bounds;
        self.lastVcView = image;
    }
    return _lastVcView;
}

//- (UIView *)cover
//{
//    if (!_cover) {
//        UIWindow * window = [UIApplication sharedApplication].keyWindow;
//        UIView * cover = [[UIView alloc] init];
//        cover.frame = window.bounds;
//        cover.backgroundColor = [UIColor blackColor];
//        cover.alpha = 0.3;
//        cover.tag = 100;
//        self.cover = cover;
//    }
//    return _cover;
//}
#pragma mark - 懒加载
- (UIButton *)cover
{
    if (!_cover) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        UIButton * cover = [[UIButton alloc] init];
        cover.frame = window.bounds;
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.3;
        self.cover = cover;
        [cover addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

- (void)buttonClick:(UIButton *)btn{
    [self.cover removeFromSuperview];
    [UIView animateWithDuration:0.15 animations:^{
        self.isMenuOpen = NO;
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //拖拽手势
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    [self.view addGestureRecognizer:recognizer];
}

- (void)dragging:(UIPanGestureRecognizer *)recognizer{
    
    //当只有一个控制器的时候不能拖拽
//    if (self.viewControllers.count == 1){
//        [UIView animateWithDuration:.25 animations:^{
//            self.view.transform = CGAffineTransformMakeTranslation(220, 0);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
    CGFloat tx = [recognizer translationInView:self.view].x;

    if (tx < 0) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.cover removeFromSuperview];
            self.isMenuOpen = NO;
            self.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
    }else{
        [UIView animateWithDuration:.25 animations:^{
            [self.view addSubview:self.cover];
            self.isMenuOpen = YES;
            self.view.transform = CGAffineTransformMakeTranslation(180, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    //在x方向上的移动距离
//    CGFloat tx = [recognizer translationInView:self.view].x;
//    if(tx < 0) return;
//    
//    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
//        CGFloat x = self.view.frame.origin.x;
//        if (x > self.view.frame.size.width * 0.5) {
//            [UIView animateWithDuration:.25 animations:^{
//                self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
//            } completion:^(BOOL finished) {
//                [self popViewControllerAnimated:NO];
//                [self.lastVcView removeFromSuperview];
//                [self.cover removeFromSuperview];
//                self.view.transform = CGAffineTransformIdentity;
//                [self.images removeLastObject];
//            }];
//        }else {
//            [UIView animateWithDuration:0.25 animations:^{
//                self.view.transform = CGAffineTransformIdentity;
//            }];
//        }
//        
//    }else{
//        // 移动view
//        self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
//        
//        // 添加截图到最后面
//        self.lastVcView.image = self.images[self.images.count - 2];
//        [self.tabBarController.view.superview insertSubview:self.lastVcView atIndex:0];
//        [self.tabBarController.view.superview insertSubview:self.cover aboveSubview:self.lastVcView];
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.images.count > 0) return;
    
    [self createScreenShot];
}

/**
 *  产生截图
 */
- (void)createScreenShot
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    //将图层渲染到屏幕上
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //拿到图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
//    NSData * data = UIImagePNGRepresentation(image);
//    [data writeToFile:[NSString stringWithFormat:@"/Users/li/Desktop/%zd.png",self.viewControllers.count] atomically:YES];
    
    [self.images addObject:image];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (self.images.count == 0) return;
    
    [self createScreenShot];
}


@end
