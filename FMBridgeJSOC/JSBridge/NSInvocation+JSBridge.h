//
//  NSInvocation+JSBridge.h
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSInvocation (JSBridge)
- (void) setValue:(JSValue *)jsValue
          atIndex:(NSInteger)index;

- (JSValue *)methodReturnJSValue:(JSContext *)context;

@end
