//
//  WJPCircleProgressView.m
//  环形进度条
//
//  Created by use on 16/4/12.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "WJPCircleProgressView.h"


#define DefaultBackColor [UIColor lightGrayColor]
#define DefaultFinishColor [UIColor greenColor]
#define DefaultUnFinishColor [UIColor greenColor]
#define DefaultCenterColor [UIColor clearColor]

@interface WJPCircleProgressView ()

@property (strong, nonatomic) CAShapeLayer *jp_backgroundLayer;
@property (strong, nonatomic) CAShapeLayer *jp_runningLayer;

@end

@implementation WJPCircleProgressView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _width = 0;
        [self.layer addSublayer:self.jp_backgroundLayer];
        [self.layer addSublayer:self.jp_runningLayer];
        
        CGFloat radius = frame.size.width/2;
        CGFloat x = radius - radius/1.414;
        CGFloat y = x;
        CGFloat width = radius - 2 * x;
        CGFloat height = width;
        
        //中间图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self addSubview:imageView];
    }
    
    return self;
}

- (void)setPercent:(float)percent{
    if (percent > 1) {
        /**
         *  完成操作
         */
        return;
    }
    NSLog(@"_percent-%f;", _percent);
    self.jp_runningLayer.strokeEnd = percent;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(_percent);
    animation.toValue = @(percent);
    animation.duration = 0.3;
    [self.jp_runningLayer addAnimation:animation forKey:@"strokeEnd"];
    _percent = percent;
}

// 画 背景 层
- (CAShapeLayer *)jp_backgroundLayer
{
    if (!_jp_backgroundLayer) {
        _jp_backgroundLayer = [CAShapeLayer layer];
        
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        CGFloat radius = viewSize.width / 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius-5
                                                        startAngle:(-0.5) * M_PI
                                                          endAngle:(1.5) * M_PI
                                                         clockwise:YES];
        _jp_backgroundLayer.borderColor = [UIColor blueColor].CGColor;
        _jp_backgroundLayer.borderWidth = 5.0f;
        _jp_backgroundLayer.lineWidth = 10.f;
        _jp_backgroundLayer.path = path.CGPath;
        _jp_backgroundLayer.fillColor = (_centerColor == nil) ?  DefaultCenterColor.CGColor : _centerColor.CGColor;
        _jp_backgroundLayer.strokeColor = (_arcBackColor == nil) ? DefaultBackColor.CGColor : _arcBackColor.CGColor;
    }
    return _jp_backgroundLayer;
}
// 画 动画层
- (CAShapeLayer *)jp_runningLayer
{
    if (!_jp_runningLayer) {
        _jp_runningLayer = [CAShapeLayer layer];
        
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        CGFloat radius = viewSize.width / 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius-5
                                                        startAngle:(-0.5) * M_PI
                                                          endAngle:(1.5) * M_PI
                                                         clockwise:YES];
        _jp_runningLayer.borderColor = [UIColor blueColor].CGColor;
        _jp_runningLayer.borderWidth = 5.0f;
        _jp_runningLayer.lineWidth = 10.f;
        _jp_runningLayer.path = path.CGPath;
        _jp_runningLayer.fillColor = [UIColor clearColor].CGColor;
        _jp_runningLayer.strokeColor = (_arcUnfinishColor == nil) ? DefaultUnFinishColor.CGColor : _arcUnfinishColor.CGColor;
    }
    return _jp_runningLayer;
}

@end
