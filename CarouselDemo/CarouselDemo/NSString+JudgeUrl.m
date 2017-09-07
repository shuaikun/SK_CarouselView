//
//  NSString+JudgeUrl.m
//  CarouselDemo
//
//  Created by caoshuaikun on 2017/9/7.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import "NSString+JudgeUrl.h"

@implementation NSString (JudgeUrl)

- (BOOL)isUrl {
    
    if(self == nil) {
        return NO;
    }
    
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = self;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

@end
