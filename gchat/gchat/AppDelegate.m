//
//  AppDelegate.m
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDKFull.h"
#import "GDWTabBarController.h"
#import "GDWLoginViewController.h"
#import "EMAlertView.h"


/*
应用标识(AppKey):	gdwchat#gdwchat
Client Id: YXA6yB4VMJvsEeWQwAUtP7f3qQ
Client Secret: YXA6tCTu71vzgySxWVEmMORJKVhomDY
 */
#define EMAppkey  @"gdwchat#gdwchat"

@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (instancetype)init
{
    //NSLog(@"%s",__func__);
    self = [super init];
    if (self) {
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchRootViewController:) name:KSwitchRootViewControllerNotification object:nil];

    }
    return self;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //1.创建窗口
    self.window = [[UIWindow alloc]  initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.选择窗口根控制器
    [self chooseRootViewControllerWithVersion];
    
    //3.让窗口成为主窗口,并显示.
    [self.window makeKeyAndVisible];
    
    
    //1设置环信相关信息.
    EMOptions *options = [EMOptions optionsWithAppkey:EMAppkey];
    options.enableConsoleLog = NO;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient  sharedClient]  addDelegate:self delegateQueue:nil];
    
    return YES;
}
- (void)chooseRootViewControllerWithVersion
{
    [self switchRootViewController:nil];
}

- (void)switchRootViewController:(NSNotification *)note
{
    //NSLog(@"%s",__func__);
   NSString *userId =  [GDWDataBaseTool  getUserDefaultsWithKey:@"userId"];
    NSString *userName = [[EMClient sharedClient] currentUsername];
    NSLog(@"%@--%@--%s",userName,userId,__func__);
    if (userName.length) {
        GDWTabBarController *tabBarVC = [[GDWTabBarController alloc] init];
        self.window.rootViewController = tabBarVC;
    }else {
        GDWLoginViewController *loginVC = [[GDWLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
}


#pragma mark - <EMClientDelegate>
/* !自动登录返回结果 @param aError 错误信息*/
- (void)didAutoLoginWithError:(EMError *)aError {

     //NSLog(@"%s",__func__);
    if (!aError) {//自动登录没有错误
        [[NSNotificationCenter defaultCenter] postNotificationName:KSwitchRootViewControllerNotification object:nil];
    } else {
         NSLog(@"%@",aError);
    }
}

/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState
{
    
}

/* 当前登录账号在其它设备登录时会接收到该回调 */
- (void)didLoginFromOtherDevice
{
    [self didGoToLoginVC];
}

/* 当前登录账号已经被从服务器端删除时会收到该回调 */
- (void)didRemovedFromServer
{
    [self didGoToLoginVC];
}

- (void)didGoToLoginVC
{
    [[EMClient sharedClient] logout:NO];
    GDWLoginViewController* loginVC = [[GDWLoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    
    [EMAlertView showAlertWithTitle:@"警告" message:@"您被T下线了" completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
