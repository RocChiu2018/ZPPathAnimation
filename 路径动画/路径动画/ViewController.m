//
//  ViewController.m
//  路径动画
//
//  Created by 赵鹏 on 2019/2/3.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZPDrawView.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ————— 单击“开始动画”按钮 —————
- (IBAction)startAnimation:(id)sender
{
    ZPDrawView *drawView = (ZPDrawView *)self.view;
    [drawView startAnimation];
}

@end
