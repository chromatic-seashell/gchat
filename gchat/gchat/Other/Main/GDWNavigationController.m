//
//  GDWNavigationController.m
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWNavigationController.h"

@interface GDWNavigationController ()

@end

@implementation GDWNavigationController


+ (void)initialize
{
    //1.设置导航条的外观属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:att];
    
    //2.设置UIBarButtonItem的外观属性.
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    //itemAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    itemAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:itemAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        NSString *title = @"返回";
        if (self.childViewControllers.count == 1) {
            title = self.childViewControllers.firstObject.title;
        }
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

@end
