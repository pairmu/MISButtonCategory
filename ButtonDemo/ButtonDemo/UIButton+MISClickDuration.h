//
//  UIButton+MISClickDuration.h
//  ButtonDemo
//
//  Created by Mistletoe on 2017/6/3.
//  Copyright © 2017年 Mistletoe. All rights reserved.
//  防止按钮的频繁点击

#import <UIKit/UIKit.h>

@interface UIButton (MISClickDuration)

/**
 按钮点击间隔（设置为3S表示第一次点击3S后才响应下次点击操作）
 */
@property (nonatomic, assign) NSTimeInterval mis_clickDuration;

@end
