//
//  WKWebView+JSBridge.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/12/30.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "WKWebView+JSBridge.h"
#import <objc/runtime.h>
#import "FMJSForward.h"

@interface WKWebView (WKScriptMessageHandler)
<
    WKScriptMessageHandler
>
@end

@implementation WKWebView (JSBridge)

- (NSMutableArray *)forwards {
    NSMutableArray *forwards = objc_getAssociatedObject(self, _cmd);
    if (forwards == nil) {
        forwards = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, _cmd, forwards, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return forwards;
}

- (JSContext *)jsContext {
    JSContext *jsContext = objc_getAssociatedObject(self, _cmd);
    if (jsContext == nil) {
        jsContext = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        objc_setAssociatedObject(self, _cmd, jsContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return jsContext;
}

//- (JSValue *) evaluateScript:(NSString *)javsScript {
//    return [self.jsContext evaluateScript:javsScript];
//}
//
//- (NSString *)methodString:(SEL)aSelector {
//    NSMutableString *jsMethod = [NSStringFromSelector(aSelector) mutableCopy];
//    [jsMethod replaceOccurrencesOfString:@":"
//                              withString:@""
//                                 options:NSCaseInsensitiveSearch
//                                   range:NSMakeRange(0, [jsMethod length])];
//    
//    return jsMethod;
//}

- (WKWebViewConfiguration *)configurationWithJSMethods:(NSDictionary *)methods {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"webViewApp"];
    return config;
}

- (instancetype) initWithFrame:(CGRect)frame jsCallMethods:(NSDictionary *(^)())jsCallSelectorHandler {
    NSDictionary *jsCallSelector = nil;
    if (jsCallSelectorHandler) {
        jsCallSelector = jsCallSelectorHandler();
    }
    WKWebViewConfiguration *config = [self configurationWithJSMethods:jsCallSelector];
    return [self initWithFrame:frame configuration:config];
}

- (void)registerJSCallSelector:(SEL)aSelector
                    withTarget:(id)target {
    
}

@end

@implementation WKWebView (WKScriptMessageHandler)

- (void) userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.body);
//    WKUserScript *script = [[WKUserScript alloc] init];
//    [userContentController addUserScript:script];
}

@end
