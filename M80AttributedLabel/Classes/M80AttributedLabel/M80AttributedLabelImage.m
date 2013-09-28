//
//  M80AttributedLabelImage.m
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import "M80AttributedLabelImage.h"

void deallocCallback(void* ref)
{
    [(id)ref release];
}

CGFloat ascentCallback(void *ref)
{
    M80AttributedLabelImage *image = (M80AttributedLabelImage *)ref;
    CGFloat ascent = 0;
    CGFloat height = [image boxSize].height;
    switch (image.alignment)
    {
        case M80ImageAlignmentTop:
            ascent = image.fontAscent;
            break;
        case M80ImageAlignmentCenter:
        {
            CGFloat fontAscent  = image.fontAscent;
            CGFloat fontDescent = image.fontDescent;
            CGFloat baseLine = (fontAscent + fontDescent) / 2 - fontDescent;
            ascent = height / 2 + baseLine;
        }
            break;
        case M80ImageAlignmentBottom:
            ascent = height - image.fontDescent;
            break;
        default:
            break;
    }
    return ascent;
}

CGFloat descentCallback(void *ref)
{
    M80AttributedLabelImage *image = (M80AttributedLabelImage *)ref;
    CGFloat descent = 0;
    CGFloat height = [image boxSize].height;
    switch (image.alignment)
    {
        case M80ImageAlignmentTop:
        {
            descent = height - image.fontAscent;
            break;
        }
        case M80ImageAlignmentCenter:
        {
            CGFloat fontAscent  = image.fontAscent;
            CGFloat fontDescent = image.fontDescent;
            CGFloat baseLine = (fontAscent + fontDescent) / 2 - fontDescent;
            descent = height / 2 - baseLine;
        }
            break;
        case M80ImageAlignmentBottom:
        {
            descent = image.fontDescent;
            break;
        }
        default:
            break;
    }
    
    return descent;

}

CGFloat widthCallback(void* ref)
{
    M80AttributedLabelImage *image  = (M80AttributedLabelImage *)ref;
    return [image boxSize].width;
}

#pragma mark - M80AttributedLabelImage
@interface M80AttributedLabelImage ()
- (CGSize)calculateContentSize;
@end

@implementation M80AttributedLabelImage

- (void)dealloc
{
    [_image release];
    [super dealloc];
}

+ (M80AttributedLabelImage *)imageWithImage: (UIImage *)image
                                     margin: (UIEdgeInsets)margin
                                  alignment: (M80ImageAlignment)alignment
                                    maxSize: (CGSize)maxSize
{
    M80AttributedLabelImage *attributedImage    = [[M80AttributedLabelImage alloc]init];
    attributedImage.image                       = image;
    attributedImage.margin                      = margin;
    attributedImage.alignment                   = alignment;
    attributedImage.maxSize                     = maxSize;
    
    return [attributedImage autorelease];
}


- (CGSize)boxSize
{
    CGSize contentSize = _image.size;
    if (_maxSize.width > 0 &&_maxSize.height > 0 &&
        contentSize.width > 0 && contentSize.height > 0)
    {
        contentSize = [self calculateContentSize];
    }
    return CGSizeMake(contentSize.width + _margin.left + _margin.right,
                      contentSize.height+ _margin.top  + _margin.bottom);
}


#pragma mark - 辅助方法
- (CGSize)calculateContentSize
{
    CGFloat width = self.image.size.width;
    CGFloat height= self.image.size.height;
    CGFloat newWidth = _maxSize.width;
    CGFloat newHeight= _maxSize.height;
    if (width <= newWidth &&
        height<= newHeight)
    {
        return self.image.size;
    }
    CGSize size;
    if (width / height > newWidth / newHeight)
    {
        size = CGSizeMake(newWidth, newWidth * height / width);
    }
    else
    {
        size = CGSizeMake(newHeight * width / height, newHeight);
    }
    return size;
}
@end
