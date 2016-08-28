//
//  FMJSForward.h
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMJSForward : NSObject
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithTarget:(id)target
                       selector:(SEL)aSelector
                        webView:(UIWebView *)webView NS_DESIGNATED_INITIALIZER;

- (BOOL) methodReturnTypeIsVoid;

@end
