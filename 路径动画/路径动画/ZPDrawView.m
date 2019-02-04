//
//  ZPDrawView.m
//  路径动画
//
//  Created by 赵鹏 on 2019/2/4.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPDrawView.h"

@interface ZPDrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation ZPDrawView

#pragma mark ————— 懒加载 —————
- (UIBezierPath *)path
{
    if (_path == nil)
    {
        _path = [UIBezierPath bezierPath];
    }
    
    return _path;
}

#pragma mark ————— 手指触摸屏幕 —————
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取UITouch对象
    UITouch *touch = [touches anyObject];
    
    //获取当前手指触摸的点
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.path moveToPoint:currentPoint];
}

#pragma mark ————— 手指在屏幕上移动 —————
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.path addLineToPoint:currentPoint];
    
    /**
     重绘：
     调用系统的"drawRect:"方法。
     */
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.path stroke];
}

#pragma mark ————— 绘制动画 —————
- (void)startAnimation
{
    //获得跟绘制的图形一样的图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = self.path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;  //设置绘制的颜色
    
    /**
     绘制之前绘制的图形的比例：
     比如0就是不绘制，0.5就绘制一半，1就绘制全部。
     */
    layer.strokeEnd = 1;
    
    [self.layer addSublayer:layer];
    
    //用“核心动画”来制作动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = [NSNumber numberWithInt:0];
    animation.toValue = [NSNumber numberWithInt:1];
    animation.duration = 3;
    [layer addAnimation:animation forKey:nil];
    
    //清空之前的画线
    [self.path removeAllPoints];
    
    //重绘
    [self setNeedsDisplay];
}

@end
