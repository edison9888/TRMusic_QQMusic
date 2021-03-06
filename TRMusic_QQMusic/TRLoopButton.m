//
//  TRLoopButton.m
//  TMusic
//
//  Created by Alex Zhao on 13-10-30.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRLoopButton.h"

@interface TRLoopButton()

@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * highlightedImages;

@end

@implementation TRLoopButton

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tap:(id)sender
{
    NSUInteger index = self.currentIndex;
    index += 1;
    index %= self.images.count;
    self.currentIndex = index;
}

- (void)setLoopImages:(NSArray *)images
{
    self.images = images;
    self.currentIndex = 1;
}

- (void)setLoopImages:(NSArray *)images andHighlightedImages:(NSArray *)highlightedImages
{
    self.images = images;
    self.highlightedImages = highlightedImages;
    self.currentIndex = 1;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    UIImage * image = self.images[self.currentIndex];
    [self setImage:image forState:UIControlStateNormal];
    
    UIImage * highlightedImage = self.highlightedImages[self.currentIndex];
    if (highlightedImage) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
}




@end
