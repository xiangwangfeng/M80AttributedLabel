//
//  M80AttributedLabelConfig.h
//  M80AttributedLabel
//
//  Created by amao on 2019/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSArray * _Nullable (^M80LinkDetector)(NSString * _Nullable text);
typedef BOOL (^M80SyncLinkChecker)(NSString * _Nullable text);


@interface M80AttributedLabelConfig : NSObject
@property (nonatomic,copy,nullable) M80LinkDetector detector;

@property (nonatomic,copy,nullable) M80SyncLinkChecker checker;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
