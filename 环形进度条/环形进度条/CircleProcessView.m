//
//  CircleProcessView.m
//  环形进度条
//
//  Created by use on 16/4/12.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "CircleProcessView.h"

#define DefaultBackColor [UIColor lightGrayColor]
#define DefaultFinishColor [UIColor greenColor]
#define DefaultUnFinishColor [UIColor greenColor]
#define DefaultCenterColor [UIColor whiteColor]



@implementation CircleProcessView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _width = 0;
        
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
    _percent = percent;
    [self setNeedsDisplay];
}
/*
- (void)setProgressState:(NSInteger)progressState
{
    _progressState = progressState;
    switch (_progressState) {
        case 0:
        {
            
        }
            break;
        case 1:
            <#statements#>
            break;
        case 2:
            <#statements#>
            break;
        default:
            break;
    }
}
*/

- (void)drawRect:(CGRect)rect{
    [self addArcBackColor];
    [self drawArc];
    [self addCenterBack];
//    [self addCenterLabel];
}

// 画 背景 层
- (void)addArcBackColor{
    CGColorRef color = (_arcBackColor == nil) ? DefaultBackColor.CGColor : _arcBackColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    // Draw the slices.
    CGFloat radius = viewSize.width / 2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, -M_PI_2, M_PI*3/2, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

// 画 进度 层
- (void)drawArc{
    NSLog(@"%f", _percent);
    if (_percent == 0 || _percent > 2) {
        return;
    }
    
    if (_percent >= 1) {
        CGColorRef color = (_arcFinishColor == nil) ? DefaultFinishColor.CGColor : _arcFinishColor.CGColor;
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        // Draw the slices.
        CGFloat radius = viewSize.width / 2;
        CGContextBeginPath(contextRef);
        CGContextMoveToPoint(contextRef, center.x, center.y);
        CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
        CGContextSetFillColorWithColor(contextRef, color);
        CGContextFillPath(contextRef);
        
        
    }else{
        
        float endAngle = 2*M_PI*_percent - M_PI_2;
        
        CGColorRef color = (_arcUnfinishColor == nil) ? DefaultUnFinishColor.CGColor : _arcUnfinishColor.CGColor;
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        // Draw the slices.
        CGFloat radius = viewSize.width / 2;
        CGContextBeginPath(contextRef);
        CGContextMoveToPoint(contextRef, center.x, center.y);
        CGContextAddArc(contextRef, center.x, center.y, radius,-M_PI_2,endAngle, 0);
        CGContextSetFillColorWithColor(contextRef, color);
        CGContextFillPath(contextRef);
    }
    
}

// 画 中心 覆盖 层
-(void)addCenterBack{
    float width = (_width == 0) ? 5 : _width;
    
    CGColorRef color = (_centerColor == nil) ? DefaultCenterColor.CGColor : _centerColor.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    // Draw the slices.
    CGFloat radius = viewSize.width / 2 - width;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}
/*
- (void)addCenterLabel{
    NSString *percent = @"";
    
    float fontSize = 14;
    UIColor *arcColor = [UIColor blueColor];
    if (_percent == 1) {
        percent = @"100%";
        fontSize = 14;
        arcColor = (_arcFinishColor == nil) ? [UIColor greenColor] : _arcFinishColor;
        
    }else if(_percent < 1 && _percent >= 0){
        
        fontSize = 13;
        arcColor = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
    }
    
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
}
*/

@end
