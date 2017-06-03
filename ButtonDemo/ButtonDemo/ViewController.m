//
//  ViewController.m
//  ButtonDemo
//
//  Created by Mistletoe on 2017/6/3.
//  Copyright © 2017年 Mistletoe. All rights reserved.
//

#import "ViewController.h"

#import "UIButton+MISClickDuration.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    button.mis_clickDuration = 3.0f;
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction {
    NSLog(@"button Action");
}
@end
