//
//  ViewController.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "ViewController.h"
#import "WKWebView+JSBridge.h"

@interface ViewController ()
<
    WKUIDelegate,
    WKNavigationDelegate,
    WKScriptMessageHandler
>
@property (nonatomic, strong, readonly) WKWebView *webView;
@end

@implementation ViewController

@synthesize webView=_webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
//    [self.webView registerJSCallSelector:@selector(hello:welcome:)
//                              withTarget:self];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *(^)(BOOL isLocal)) hello:(NSString *)hello welcome:(NSString *)welcome {
    return ^NSString *(BOOL isLocal){
        return [NSString stringWithFormat:@"%@",isLocal ? welcome : hello];
    };
}

- (WKWebView *)webView {
    if (_webView == nil) {
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//        [config.userContentController addScriptMessageHandler:self name:@"webViewApp"];
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      jsCallMethods:^NSDictionary *{
                                          return @{NSStringFromClass(self.class) : NSStringFromSelector(@selector(hello:welcome:))};
                                      }];
        [self.view addSubview:_webView];
        [self testWebView:_webView];
    }
    return _webView;
}

- (void) testWebView:(WKWebView *)webview {
    id webkit = [webview valueForKeyPath:@"window"];
    NSLog(@"%@",webkit);
}

- (void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void) webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s -> %@",__PRETTY_FUNCTION__, error);
}

//- (void) userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSLog(@"%@",message.body);
//}

@end
