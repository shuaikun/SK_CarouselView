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
    // Do any additional setup after loading the view, typically from a nib.7
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.carouseView];
    self.carouseView.imageMutableArray = [NSMutableArray arrayWithArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504773959115&di=1b8594910333bab3ea54a44b4b350408&imgtype=0&src=http%3A%2F%2Fent.scol.com.cn%2Fschlw%2Fimg%2Fattachement%2Fjpg%2Fsite2%2F20101212%2Fb8ac6f30e5ac0e6e1b0411.jpg",
                                                                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504773959110&di=b41fe67abdae35a1c9f9b38717b66d25&imgtype=0&src=http%3A%2F%2Ft1.niutuku.com%2F960%2F36%2F36-312566.jpg",
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
