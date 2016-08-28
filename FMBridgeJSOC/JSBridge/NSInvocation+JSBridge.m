//
//  NSInvocation+JSBridge.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NSInvocation+JSBridge.h"

@implementation NSInvocation (JSBridge)

- (void) setValue:(JSValue *)jsValue
          atIndex:(NSInteger)index
{
    const char *type = [self.methodSignature getArgumentTypeAtIndex:index];
    if (*type == *@encode(BOOL))
    {
        BOOL value = [jsValue toBool];
        [self setArgument:&value atIndex:index];
    }
    else if (*type == *@encode(char))
    {
        char value = [[jsValue toNumber] charValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(unsigned char)) {
        unsigned char value = [[jsValue toNumber] unsignedCharValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(short))
    {
        short value = [[jsValue toNumber] shortValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(unsigned short))
    {
        unsigned short value = [[jsValue toNumber] unsignedShortValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(int))
    {
        int value = [[jsValue toNumber] intValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(unsigned int))
    {
        unsigned int value = [[jsValue toNumber] unsignedIntValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(long))
    {
        long value = [[jsValue toNumber] longValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(unsigned long))
    {
        unsigned long value = [[jsValue toNumber] unsignedLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(long long))
    {
        long long value = [[jsValue toNumber] longLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(unsigned long long))
    {
        unsigned long long value = [[jsValue toNumber] unsignedLongLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(double))
    {
        double value = [jsValue toDouble];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == *@encode(float))
    {
        float value = [[jsValue toNumber] floatValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == '@')
    {
        id value = [jsValue toObject];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (*type == '^')
    {
        void *block = (__bridge void *)(jsValue);
        [self setArgument:&block
                        atIndex:index];
    }
    else
    {
        NSLog(@"Argument Not Support in Method : %@",NSStringFromSelector([self selector]));
    }
}

- (JSValue *)methodReturnJSValue:(JSContext *)context {
    JSValue *jsValue;
    
    const char *type = [self.methodSignature methodReturnType];
    if (*type == *@encode(BOOL))
    {
        BOOL value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithBool:value
                               inContext:context];
    }
    else if (*type == *@encode(char))
    {
        char value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(unsigned char)) {
        unsigned char value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithUnsignedChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(short))
    {
        short value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithShort:value]
                                 inContext:context];
    }
    else if (*type == *@encode(unsigned short))
    {
        unsigned short value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(int))
    {
        int value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(unsigned int))
    {
        unsigned int value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(long))
    {
        long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(unsigned long))
    {
        unsigned long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(long long))
    {
        long long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (*type == *@encode(unsigned long long))
    {
        unsigned long long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithUnsignedLongLong:value]
                                 inContext:context];
    }
    else if (*type == *@encode(double))
    {
        double value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithDouble:value]
                                 inContext:context];
    }
    else if (*type == *@encode(float))
    {
        float value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithDouble:value
                                 inContext:context];
    }
    else if (*type == '@')
    {
        id value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:value
                                 inContext:context];
    }
    else if (*type == '^')
    {
        jsValue = [JSValue valueWithUndefinedInContext:context];
    }
    else
    {
        jsValue = [JSValue valueWithUndefinedInContext:context];
    }
    
    return jsValue;
}

@end
