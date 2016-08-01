//
//  GDWTabBarController.m
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTabBarController.h"
#import "GDWNavigationController.h"

#import "GDWConversationController.h"
#import "GDWContactController.h"
#import "GDWDiscoverController.h"
#import "GDWMeViewController.h"

@interface GDWTabBarController ()

@end

@implementation GDWTabBarController

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor  cyanColor];
    [self addChildViewController:[[GDWConversationController alloc] init] title:@"微信" imageName:@"tabbar_mainframe"];
    [self addChildViewController:[[GDWContactController alloc] init] title:@"通讯录" imageName:@"tabbar_contacts"];
    [self addChildViewController:[[GDWDiscoverController alloc] init] title:@"发现" imageName:@"tabbar_discover"];
    [self addChildViewController:[[GDWMeViewController alloc] init] title:@"我" imageName:@"tabbar_me"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    
    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSString *selectedImageName = [NSString stringWithFormat:@"%@HL", imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = KColor(14, 180, 0);
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    GDWNavigationController *nav = [[GDWNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


@end
