//
//  UIWebView+JSBridge.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "UIWebView+JSBridge.h"
#import <objc/runtime.h>
#import "FMJSForward.h"

@implementation UIWebView (JSBridge)

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

- (void)registerJSCallSelector:(SEL)aSelector
                    withTarget:(id)target {
    
    FMJSForward *forward = [[FMJSForward alloc] initWithTarget:target
                                                      selector:aSelector
                                                       webView:self];
    [[self forwards] addObject:forward];
}

- (JSValue *) evaluateScript:(NSString *)javsScript {
    return [self.jsContext evaluateScript:javsScript];
}

@end
