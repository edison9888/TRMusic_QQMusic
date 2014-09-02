//
//  TRCell_MyMusic.m
//  TMusic
//
//  Created by forever_ on 14-1-16.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "MyMusicCell.h"

@implementation MyMusicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
    }
    return self;
}
- (CellSubviews *)cellbg{
    
    if (!_cellbg) {
        _cellbg = [[CellSubviews alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    }
    return _cellbg;
    
}
- (CellSubviews *)selebg{
    
    if (!_selebg) {
        _selebg = [[CellSubviews alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    }
    return _selebg;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect  rect = CGRectMake(10, self.frame.origin.y, 300, 50);
    self.frame = rect;
//    UIImageView *img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_mody_bg.png"]];
//    img.frame = CGRectMake(0, 0, 300, 50);
//    self.backgroundView = img;
    
}

//- (void)load
//{
//    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TRCellbg" owner:self options:nil];
//    TRCellbg *cellbg = array[0];
//}

@end
