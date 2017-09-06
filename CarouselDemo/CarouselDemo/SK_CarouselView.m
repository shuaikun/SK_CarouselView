//
//  CarouselView.m
//  CarouselDemo
//
//  Created by caoshuaikun on 2017/9/5.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import "SK_CarouselView.h"
//#define SK_CarouselView_Width self.frame.size.width
//#define SK_CarouselView_Height self.frame.size.height

@interface SK_CarouselView ()

@property (nonatomic, strong) UIImageView * leftImageView;//第一个imageview
@property (nonatomic, strong) UIImageView * cureentImageView;//当前选中的imageview
@property (nonatomic, strong) UIImageView * rightImageView;//最后那个imageview

@property (nonatomic, assign) NSInteger selectCurrentIndext;//点击选择当前的imageview

@end

@implementation SK_CarouselView
@synthesize imageMutableArray = _imageMutableArray;

- (NSMutableArray *)imageMutableArray {
    if (!_imageMutableArray) {
        _imageMutableArray = [NSMutableArray array];
    }
    return _imageMutableArray;
}
- (UIPageControl *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] init];
        _pageController.pageIndicatorTintColor = [UIColor whiteColor];
        _pageController.currentPageIndicatorTintColor = [UIColor redColor];
        _pageController.userInteractionEnabled = NO;
    }
    return _pageController;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction)];
        [_scrollView addGestureRecognizer:ges];
        
        
        //创建三个imageview
        {
            _leftImageView = [self imageViewMake];
            _cureentImageView = [self imageViewMake];
            _rightImageView = [self imageViewMake];
            
            [_scrollView addSubview:_leftImageView];
            [_scrollView addSubview:_cureentImageView];
            [_scrollView addSubview:_rightImageView];
        }
        
    }
    return _scrollView;
}
- (UIImageView *)imageViewMake {
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}
- (void)setImageMutableArray:(NSMutableArray *)imageMutableArray {
    _imageMutableArray = imageMutableArray;
    self.pageController.numberOfPages = imageMutableArray.count;
    
    //当只有一张图片的时候只需要显示一个图片就可以了如果还按照之前的样式的话会出现bug，崩溃
    if (imageMutableArray.count < 2) {
        
        [self stopTimer];
        self.scrollView.scrollEnabled = NO;
        self.cureentImageView.image = [UIImage imageNamed:imageMutableArray[0]];
    } else {
        
        self.scrollView.scrollEnabled = YES;
        self.leftImageView.image = [UIImage imageNamed:imageMutableArray[imageMutableArray.count - 1]];
        self.cureentImageView.image = [UIImage imageNamed:imageMutableArray[0]];
        self.rightImageView.image = [UIImage imageNamed:imageMutableArray[1]];
        [self startTimer];
    }
}//设置image

- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)height {
    return self.frame.size.height;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.selectCurrentIndext = 0;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageController];
    }
    return self;
}

#pragma mark - 添加定时器
- (void)setTimeInterval:(NSInteger)timeInterval {
    _timeInterval = timeInterval;
    [self startTimer];
}
- (void)startTimer {
    
    //如果已开启定时器，需要先关闭再打开
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                  target:self
                                                selector:@selector(carouselAction)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)carouselAction {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2.0f animations:^{
        [weakSelf.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
    }];
}

//点击图片选择
- (void)imageClickAction {
    if ([self.carouseDelegate respondsToSelector:@selector(clickImageViewNumber:)]) {
        [self.carouseDelegate clickImageViewNumber:self.selectCurrentIndext];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置scrollView
    {
        self.scrollView.frame = self.bounds;
        self.scrollView.contentSize = CGSizeMake(self.width * 3, self.height);
        self.scrollView.contentOffset = CGPointMake(self.width, 0);
    }
    
    //设置三个ImageView
    {
        self.leftImageView.frame = CGRectMake(0, 0, self.width, self.height);
        self.cureentImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
        self.rightImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
    }
    
    self.pageController.frame = CGRectMake(0, self.height - 30, self.width, 30);
}

#pragma mark - scrollviewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //侧滑但是滑动的很小
    if (scrollView.contentOffset.x == self.width) {
        return;
    }
    
    CGFloat scrollCount = scrollView.contentOffset.x / self.width;
    //左滑
    if (scrollCount == 0) {
        //当前本身是第一个
        if (self.selectCurrentIndext == 0) {
            
            self.selectCurrentIndext = self.imageMutableArray.count - 1;
            self.leftImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext - 1]];
            self.rightImageView.image = [UIImage imageNamed:self.imageMutableArray[0]];
        } else {
            
            if (self.selectCurrentIndext == 1) {
                self.selectCurrentIndext = 0;
                self.leftImageView.image = [UIImage imageNamed:self.imageMutableArray.lastObject];
            } else {
                self.selectCurrentIndext = self.selectCurrentIndext - 1;
                self.leftImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext - 1]];
            }
            
            self.rightImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext + 1]];
        }
        
    //又滑
    } else {
        
        if (self.selectCurrentIndext == self.imageMutableArray.count - 1) {
            
            self.selectCurrentIndext = 0;
            self.leftImageView.image = [UIImage imageNamed:self.imageMutableArray.lastObject];
            self.rightImageView.image = [UIImage imageNamed:self.imageMutableArray[1]];
            
        } else {
            
            if (self.selectCurrentIndext == self.imageMutableArray.count - 2) {
                self.selectCurrentIndext = self.imageMutableArray.count - 1;
                self.rightImageView.image = [UIImage imageNamed:self.imageMutableArray.firstObject];
            } else {
                self.selectCurrentIndext = self.selectCurrentIndext + 1;
                self.rightImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext + 1]];
            }
            
            self.leftImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext - 1]];
        }
    }
    
    self.cureentImageView.image = [UIImage imageNamed:self.imageMutableArray[self.selectCurrentIndext]];
    self.pageController.currentPage = self.selectCurrentIndext;
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
}

@end
