//
//  ViewController.m
//  CarouselDemo
//
//  Created by caoshuaikun on 2017/9/5.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import "ViewController.h"
#import "SK_CarouselView.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface ViewController () <SK_CarouselDelegate>

@property (nonatomic, strong) SK_CarouselView * carouseView;

@end

@implementation ViewController

- (SK_CarouselView *)carouseView {
    if (!_carouseView) {
        _carouseView = [[SK_CarouselView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
        _carouseView.backgroundColor = [UIColor whiteColor];
        _carouseView.carouseDelegate = self;
    }
    return _carouseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.carouseView];
    self.carouseView.imageMutableArray = [NSMutableArray arrayWithArray:@[@"huazai1",
                                                                          @"huazai2",
                                                                          @"huazai3",
                                                                          @"huazai4",
                                                                          @"huazai5",
                                                                          @"huazai6",
                                                                          @"huazai7"
                                                                          ]];
}

#pragma mark - SK_CarouselViewDelegate
- (void)clickImageViewNumber:(NSInteger)number {
    NSLog(@" 选择的当前的第几条 %zd",number);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
