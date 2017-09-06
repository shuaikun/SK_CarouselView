//
//  CarouselView.h
//  CarouselDemo
//
//  Created by caoshuaikun on 2017/9/5.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SK_CarouselDelegate <NSObject>

//必须实现的协议方法
@required

//选择实现的协议方法
@optional

- (void)clickImageViewNumber:(NSInteger)number;

@end

@interface SK_CarouselView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView * scrollView;//轮播scrollView
@property (nonatomic, strong) NSMutableArray * imageMutableArray;//图片的数组
@property (nonatomic, strong) UIPageControl * pageController;//页码标志 
@property (nonatomic, assign) id<SK_CarouselDelegate> carouseDelegate;//轮播协议
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger timeInterval;

@end
