//
//  ViewController.m
//  WebViewAndJS
//
//  Created by zhangpenghui on 2018/11/28.
//  Copyright © 2018年 zph. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.\
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    WKPreferences *preferences = [[WKPreferences alloc]init];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10.0;
    configuration.preferences = preferences;
    
    WKUserContentController *userContent = [[WKUserContentController alloc]init];
    [userContent addScriptMessageHandler:self name:@"JSBridge"];
    configuration.userContentController = userContent;
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/webTest/webTest.html"]]];
    [self.view addSubview:_webView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSBridge"];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    NSLog(@"webView finish");
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"exit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark --WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"%@",message.body);
    
    [self updateSave];
}

-(void)updateSave {
    
    NSString *script = @"change_state(true)";

    [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable msg, NSError * _Nullable error) {
        
    }];
}

@end
