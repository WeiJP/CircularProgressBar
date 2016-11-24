//
//  ViewController.m
//  环形进度条
//
//  Created by use on 16/4/12.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "ViewController.h"
#import "CircleProcessView.h"

#import "WJPCircleProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) WJPCircleProgressView *cpv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WJPCircleProgressView *progress = [[WJPCircleProgressView alloc]initWithFrame:CGRectMake(30, 100, 300, 300)];
    progress.arcFinishColor = [UIColor orangeColor];
    progress.arcUnfinishColor = [UIColor greenColor];
    progress.arcBackColor = [UIColor lightGrayColor];
    progress.percent = 0;
    progress.width = 3;
    [self.view addSubview:progress];
    self.cpv = progress;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.01f target:self selector:@selector(gogogo:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)gogogo:(NSTimer *)timer
{
    self.cpv.percent += 0.001;
    if (self.cpv.percent >= 0.7) {
        [timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
