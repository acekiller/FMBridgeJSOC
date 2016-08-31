//
//  NSInvocation+JSBridge.m
//  FMBridgeJSOC
//
//  Created by Fantasy on 16/8/28.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NSInvocation+JSBridge.h"

#define ISARGUMENTYPE(T,V) (*V == *@encode(T))
#define ISBLOCK(T) ((strcmp(type, "@?") == 0) || (*T == '^'))

@implementation NSInvocation (JSBridge)

- (void) setValue:(JSValue *)jsValue
          atIndex:(NSInteger)index
{
    const char *type = [self.methodSignature getArgumentTypeAtIndex:index];
    if (ISBLOCK(type)) {
        void *block = (__bridge void *)(jsValue);
        [self setArgument:&block
                  atIndex:index];
    }
    else if (ISARGUMENTYPE(BOOL, type))
    {
        BOOL value = [jsValue toBool];
        [self setArgument:&value atIndex:index];
    }
    else if (ISARGUMENTYPE(char, type))
    {
        char value = [[jsValue toNumber] charValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(unsigned char, type)) {
        unsigned char value = [[jsValue toNumber] unsignedCharValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(short, type))
    {
        short value = [[jsValue toNumber] shortValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(unsigned short, type))
    {
        unsigned short value = [[jsValue toNumber] unsignedShortValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(int, type))
    {
        int value = [[jsValue toNumber] intValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(unsigned int, type))
    {
        unsigned int value = [[jsValue toNumber] unsignedIntValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(long, type))
    {
        long value = [[jsValue toNumber] longValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(unsigned long, type))
    {
        unsigned long value = [[jsValue toNumber] unsignedLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(long long, type))
    {
        long long value = [[jsValue toNumber] longLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(unsigned long long, type))
    {
        unsigned long long value = [[jsValue toNumber] unsignedLongLongValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(double, type))
    {
        double value = [jsValue toDouble];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(float, type))
    {
        float value = [[jsValue toNumber] floatValue];
        [self setArgument:&value
                        atIndex:index];
    }
    else if (ISARGUMENTYPE(id, type))
    {
        id value = [jsValue toObject];
        [self setArgument:&value
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
    if (ISBLOCK(type)) {
        void *block;
        [self getReturnValue:&block];
        jsValue = [JSValue valueWithObject:(__bridge id)(block) inContext:context];
    }
    else if (ISARGUMENTYPE(BOOL, type))
    {
        BOOL value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithBool:value
                               inContext:context];
    }
    else if (ISARGUMENTYPE(char, type))
    {
        char value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(unsigned char, type)) {
        unsigned char value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithUnsignedChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(short, type))
    {
        short value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithShort:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(unsigned short, type))
    {
        unsigned short value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(int, type))
    {
        int value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(unsigned int, type))
    {
        unsigned int value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(long, type))
    {
        long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(unsigned long, type))
    {
        unsigned long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(long long, type))
    {
        long long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithChar:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(unsigned long long, type))
    {
        unsigned long long value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithUnsignedLongLong:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(double, type))
    {
        double value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:[NSNumber numberWithDouble:value]
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(float, type))
    {
        float value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithDouble:value
                                 inContext:context];
    }
    else if (ISARGUMENTYPE(id, type))
    {
        id value;
        [self getReturnValue:&value];
        jsValue = [JSValue valueWithObject:value
                                 inContext:context];
    }
    else
    {
        jsValue = [JSValue valueWithUndefinedInContext:context];
    }
    
    return jsValue;
}

@end
