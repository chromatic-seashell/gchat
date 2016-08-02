//
//  GDWLoginViewController.m
//  gchat
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWLoginViewController.h"
#import "EMClient.h"
#import "MBProgressHUD+Add.h"
#import "GDWDataBaseTool.h"


@interface GDWLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *usernamefield;
@property (nonatomic, weak) IBOutlet UITextField *passwordfield;

@property (nonatomic, weak) IBOutlet UIButton *registerBtn;
@property (nonatomic, weak) IBOutlet UIButton *loginBtn;
@end

@implementation GDWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernamefield.delegate = self;
    self.passwordfield.delegate = self;
    _usernamefield.text = @"gdw";
    _passwordfield.text = @"123456";
}

- (void)loginBtnClick
{
    [self.view endEditing:YES];
    
    if (!self.usernamefield.text.length) {
        [MBProgressHUD showError:@"请输入用户名"];
        
        return ;
    }else if (!self.passwordfield.text.length) {
        [MBProgressHUD showError:@"请输入密码"];
        return ;
    }
    
    
    
    [MBProgressHUD showMessage:@"登录中"];
    
    if (self.usernamefield.text.length == 0 || self.passwordfield.text.length == 0) {
        NSLog(@"请输入用户名和密码");
        return;
    }
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.usernamefield.text password:self.passwordfield.text];
        if (!error) {
            
            [MBProgressHUD hideHUD];
            
            // 设置自动登录
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            
            [GDWDataBaseTool saveToUserDefaults:self.usernamefield.text key:@"userId"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KSwitchRootViewControllerNotification object:nil];
            NSLog(@"---登录成功");
            
        } else {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showError:@"登录失败"];
             NSLog(@"---登录失败%u",error.code);
            
        }
    }
    [MBProgressHUD hideHUD];
}

- (void)registerBtnClick
{
    if (!self.usernamefield.text.length) {
        [MBProgressHUD showError:@"请输入用户名"];
        return ;
    }else if (!self.passwordfield.text.length) {
        [MBProgressHUD showError:@"请输入密码"];
        return ;
    }
    
    NSString *account = self.usernamefield.text;
    NSString *pwd = self.passwordfield.text;
    EMError *error = [[EMClient sharedClient] registerWithUsername:account password:pwd];
    if (error) {
        NSLog(@"注册失败%@", error.description);
        [MBProgressHUD showError:@"注册失败"];
    } else {
        [MBProgressHUD showSuccess:@"注册成功"];
        
        NSLog(@"注册成功%@", error.description);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"%s",__func__);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //NSLog(@"%s",__func__);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

 
     //NSLog(@"%s",__func__);
    if (self.usernamefield.text.length && self.passwordfield.text.length) {
        
        self.registerBtn.enabled = YES;
        self.loginBtn.enabled = YES;
    }else{
    
        self.registerBtn.enabled = NO;
        self.loginBtn.enabled = NO;
    }
    
    return YES;
}
@end
