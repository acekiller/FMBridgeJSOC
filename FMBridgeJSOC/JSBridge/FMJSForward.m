//
//  FMJSForward.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "FMJSForward.h"
#import "UIWebView+JSBridge.h"
#import "NSInvocation+JSBridge.h"

@interface FMJSForward ()
@property (nonatomic, strong) NSInvocation *invocation;
@property (nonatomic,assign) UIWebView *webView;
@end

@implementation FMJSForward

- (instancetype) initWithTarget:(id)target
                       selector:(SEL)aSelector
                        webView:(UIWebView *)webView
{
    self = [super init];
    if (self) {
        self.invocation = [self invocationWithTarget:target
                                            selector:aSelector];
        [self bindInvocation:self.invocation
                  forWebView:webView];
    }
    return self;
}

- (void) bindInvocation:(NSInvocation *)invocation
             forWebView:(UIWebView *)webView
{
    NSMutableString *jsMethod = [NSStringFromSelector(invocation.selector) mutableCopy];
    [jsMethod replaceOccurrencesOfString:@":"
                              withString:@""
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange(0, [jsMethod length])];
    __weak typeof(self) weakSelf = self;
    __weak typeof(webView) weakWebView = webView;
    webView.jsContext[jsMethod] = ^JSValue *() {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        __strong typeof(weakWebView) strongWebView = weakWebView;
        return [strongSelf forwardInvocationWithArguments:[JSContext currentArguments]
                                               invocation:invocation
                                                jsContext:strongWebView.jsContext];
    };
    
}

- (NSInvocation *)invocationWithTarget:(id)target
                              selector:(SEL)selector
{
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    if (signature == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    return invocation;
}

- (JSValue *) forwardInvocationWithArguments:(NSArray *)arguments
                                  invocation:(NSInvocation *)invocation
                                   jsContext:(JSContext *)jsContext;
{
    NSInteger methodArgumentCount = [self.invocation.methodSignature numberOfArguments];
    for (NSInteger i = 0; i < [arguments count]; i++) {
        if (i < methodArgumentCount - 2) {
            [invocation setValue:[arguments objectAtIndex:i]
                         atIndex:i+2];
        }
    }
    [invocation invoke];
    JSValue *jsValue = [invocation methodReturnJSValue:jsContext];
    return jsValue;
}

- (BOOL) methodReturnTypeIsVoid {
    const char *type = [self.invocation.methodSignature methodReturnType];
    return *type == *@encode(void);
}

@end
