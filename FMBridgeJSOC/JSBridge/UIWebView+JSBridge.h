//
//  UIWebView+JSBridge.h
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebView (JSBridge)
@property (nonatomic, strong, readonly) JSContext *jsContext;

- (void)registerJSCallSelector:(SEL)aSelector
                    withTarget:(id)target;

- (JSValue *) evaluateScript:(NSString *)javsScript;

@end
