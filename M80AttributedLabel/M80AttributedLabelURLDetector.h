//
//  M80AttributedLabelURLDetector.h
//  M80AttributedLabel
//
//  Created by amao on 2019/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class M80AttributedLabelURL;

typedef void(^M80LinkDetectCompletion)(NSArray<M80AttributedLabelURL *> * _Nullable links);

@protocol M80AttributedLabelCustomURLDetector <NSObject>
- (void)detectLinks:(nullable NSString *)plainText
         completion:(M80LinkDetectCompletion)completion;
@end

@interface M80AttributedLabelURLDetector : NSObject
@property (nonatomic,strong)    id<M80AttributedLabelCustomURLDetector> detector;

+ (instancetype)shared;

- (void)detectLinks:(nullable NSString *)plainText
         completion:(M80LinkDetectCompletion)completion;
@end

NS_ASSUME_NONNULL_END
