//
//  MenuViewController.h
//  Drawer
//
//  Created by LI on 16/6/14.
//  Copyright © 2016年 LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

@required
- (void)menuViewController:(MenuViewController *)controller didSelectItemAtIndex:(NSUInteger)index;

@end

@interface MenuViewController : UIViewController

@property (weak, nonatomic) id<MenuViewControllerDelegate> delegate;

@end
