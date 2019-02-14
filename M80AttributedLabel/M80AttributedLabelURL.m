//
//  M80AttributedLabelURL.m
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 www.xiangwangfeng.com. All rights reserved.
//

#import "M80AttributedLabelURL.h"
#import "M80AttributedLabelConfig.h"


@implementation M80AttributedLabelURL

+ (M80AttributedLabelURL *)urlWithLinkData:(id)linkData
                                     range:(NSRange)range
                                     color:(UIColor *)color
{
    M80AttributedLabelURL *url  = [[M80AttributedLabelURL alloc]init];
    url.linkData                = linkData;
    url.range                   = range;
    url.color                   = color;
    return url;
    
}


+ (NSArray *)detectLinks:(NSString *)plainText
{
    M80LinkDetector detector = M80AttributedLabelConfig.shared.detector;
    if (detector)
    {
        return detector(plainText);
    }
    else
    {
        NSMutableArray *links = nil;
        if ([plainText length])
        {
            links = [NSMutableArray array];
            NSDataDetector *detector = [M80AttributedLabelURL linkDetector];
            [detector enumerateMatchesInString:plainText
                                       options:0
                                         range:NSMakeRange(0, [plainText length])
                                    usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                        NSRange range = result.range;
                                        NSString *text = [plainText substringWithRange:range];
                                        M80AttributedLabelURL *link = [M80AttributedLabelURL urlWithLinkData:text
                                                                                                       range:range
                                                                                                       color:nil];
                                        [links addObject:link];
                                    }];
        }
        return links;
    }
}

+ (NSDataDetector *)linkDetector
{
    static NSString *M80LinkDetectorKey = @"M80LinkDetectorKey";
    
    NSMutableDictionary *dict = [[NSThread currentThread] threadDictionary];
    NSDataDetector *detector = dict[M80LinkDetectorKey];
    if (detector == nil)
    {
        detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber
                                                   error:nil];
        if (detector)
        {
            dict[M80LinkDetectorKey] = detector;
        }
    }
    return detector;
}

@end
