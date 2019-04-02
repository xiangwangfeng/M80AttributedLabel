//
//  M80AttributedLabelURLDetector.m
//  M80AttributedLabel
//
//  Created by amao on 2019/4/2.
//

#import "M80AttributedLabelURLDetector.h"
#import "M80AttributedLabelURL.h"

@implementation M80AttributedLabelURLDetector
+ (instancetype)shared
{
    static M80AttributedLabelURLDetector *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [M80AttributedLabelURLDetector new];
    });
    return instance;
}

- (void)detectLinks:(nullable NSString *)plainText
         completion:(M80LinkDetectCompletion)completion
{
    if (completion == nil)
    {
        return;
    }
    
    if (self.detector)
    {
        [self.detector detectLinks:plainText
                        completion:completion];
    }
    else
    {
        NSMutableArray *links = nil;
        if ([plainText length])
        {
            links = [NSMutableArray array];
            NSDataDetector *detector = [self linkDetector];
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
        completion(links);
    }
}

- (NSDataDetector *)linkDetector
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
