//
//  UIButton+MISClickDuration.m
//  ButtonDemo
//
//  Created by Mistletoe on 2017/6/3.
//  Copyright © 2017年 Mistletoe. All rights reserved.
//

#import "UIButton+MISClickDuration.h"
#import <objc/runtime.h>

static char *const mis_clickDurationKey = "mis_clickDurationKey";
static char *const mis_ignoreEventKey   = "mis_ignoreEventKey";

@interface UIButton()

@property (nonatomic, assign) BOOL mis_ignoreEvent; // 忽略事件

@end

@implementation UIButton (MISClickDuration)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [self class];
        
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(mis_sendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)mis_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.mis_ignoreEvent) return;
    
    self.mis_ignoreEvent = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.mis_clickDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mis_ignoreEvent = NO;
    });
    
    [self mis_sendAction:action to:target forEvent:event];
}

- (void)setMis_ignoreEvent:(BOOL)mis_ignoreEvent {
    objc_setAssociatedObject(self, mis_ignoreEventKey, @(mis_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)mis_ignoreEvent {
    return [objc_getAssociatedObject(self, mis_ignoreEventKey) boolValue];
}

- (void)setMis_clickDuration:(NSTimeInterval)mis_clickDuration {
    objc_setAssociatedObject(self, mis_clickDurationKey, @(mis_clickDuration), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)mis_clickDuration {
    return [objc_getAssociatedObject(self, mis_clickDurationKey) doubleValue];
}
@end
