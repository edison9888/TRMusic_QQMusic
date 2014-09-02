//
//  TRCellbg.m
//  TMusic
//
//  Created by forever_ on 14-1-17.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "CellSubviews.h"

@implementation CellSubviews

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSub];
        
    }
    return self;
}

-(void)addSub{
    
    self.bottomRow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    [self addSubview:self.bottomRow];
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 30, 50, 15)];
    self.numberLable.textColor = [UIColor grayColor];
    self.numberLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.numberLable];
    self.cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(65, 12, 117, 26)];
    [self addSubview:self.cellTitle];
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self addSubview:self.headImageView];
    self.arrow = [[UIImageView alloc]initWithFrame:CGRectMake(262, 20, 13, 11)];
    [self addSubview:self.arrow];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
