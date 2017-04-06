//
//  WKWebView+JSBridge.h
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/12/30.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WKWebView (JSBridge)
- (instancetype) initWithFrame:(CGRect)frame jsCallMethods:(NSDictionary *(^)())jsCallSelectorHandler;
- (void)registerJSCallSelector:(SEL)aSelector
                    withTarget:(id)target;
@end
