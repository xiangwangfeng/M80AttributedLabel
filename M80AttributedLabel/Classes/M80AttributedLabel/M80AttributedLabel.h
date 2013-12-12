//
//  M80AttributedLabel.h
//  M80AttributedLabel
//
//  Created by amao on 13-9-1.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "M80AttributedLabelDefines.h"
#import "NSMutableAttributedString+M80.h"


@class M80AttributedLabelURL;

@interface M80AttributedLabel : UIView


@property (nonatomic,assign)    id<M80AttributedLabelDelegate> delegate;
@property (nonatomic,retain)    UIFont *font;                   //字体
@property (nonatomic,retain)    UIColor *textColor;             //文字颜色
@property (nonatomic,retain)    UIColor *highlightColor;        //链接点击时背景高亮色
@property (nonatomic,retain)    UIColor *linkColor;             //链接色
@property (nonatomic,assign)    BOOL    underLineForLink;       //链接是否带下划线
@property (nonatomic,assign)    BOOL    autoDetectLinks;        //自动检测
@property (nonatomic,assign)    NSInteger   numberOfLines;      //行数
@property (nonatomic,assign)    BOOL    truncatesLastLine;      //最后一行添加...
@property (nonatomic,assign)    CTTextAlignment textAlignment;  //文字排版样式
@property (nonatomic,assign)    CTLineBreakMode linkBreadMode;  //LineBreakMode



//普通文本
- (void)setText:(NSString *)text;
- (void)appendText: (NSString *)text;

//属性文本
- (void)setAttributedText:(NSAttributedString *)attributedText;
- (void)appendAttributedText: (NSAttributedString *)attributedText;

//图片
- (void)appendImage: (UIImage *)image;
- (void)appendImage: (UIImage *)image
            maxSize: (CGSize)maxSize;
- (void)appendImage: (UIImage *)image
            maxSize: (CGSize)maxSize
             margin: (UIEdgeInsets)margin;
- (void)appendImage: (UIImage *)image
            maxSize: (CGSize)maxSize
             margin: (UIEdgeInsets)margin
          alignment: (M80ImageAlignment)alignment;

//UI控件
- (void)appendView: (UIView *)view;
- (void)appendView: (UIView *)view
            margin: (UIEdgeInsets)margin;
- (void)appendView: (UIView *)view
            margin: (UIEdgeInsets)margin
         alignment: (M80ImageAlignment)alignment;


//添加自定义链接
- (void)addCustomLink: (id)linkData
             forRange: (NSRange)range;

- (void)addCustomLink: (id)linkData
             forRange: (NSRange)range
            linkColor: (UIColor *)color;


//大小
- (CGSize)sizeThatFits:(CGSize)size;

@end
