//
//  TRFoundViewController.m
//  TMusic
//
//  Created by forever_ on 14-1-17.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRFoundViewController.h"
#import "TRAppDelegate.h"
#import "TRPlayingViewController.h"
#import "CellSubviews.h"
#import "MyMusicCell.h"
@interface TRFoundViewController ()<UIGestureRecognizerDelegate>


@end

@implementation TRFoundViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMusicCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg@2x.png"]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        
        return 3;
        
    }else{
        return 2;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.cellbg.bottomRow.image = [UIImage imageNamed:@"bottomRow"];
    cell.cellbg.arrow.image = [UIImage imageNamed:@"arrow.png"];
    cell.selebg.bottomRow.image = [UIImage imageNamed:@"middleRowSelected"];
    cell.selebg.arrow.image = [UIImage imageNamed:@"arrowSelected.png"];
    if (indexPath.section == 0) {
        cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_singers.png"];
        cell.cellbg.cellTitle.text = @"歌手";
        cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_singers_pressed.png"];
        cell.selebg.cellTitle.text = @"歌手";
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_recognizer.png"];
            cell.cellbg.cellTitle.text = @"听歌识曲";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_recognizer_pressed.png"];
            cell.selebg.cellTitle.text = @"听歌识曲";
            

            
        }else if (indexPath.row == 1){
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_chirrup.png"];
            cell.cellbg.cellTitle.text = @"笛音传歌";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_chirrup_pressed.png"];
            cell.selebg.cellTitle.text = @"笛音传歌";
            
        }else if (indexPath.row == 2){
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_trend.png"];
            cell.cellbg.cellTitle.text = @"身边流行";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_trend_pressed.png"];
            cell.selebg.cellTitle.text = @"身边流行";
            
            
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_guess_your_favor.png"];
            cell.cellbg.cellTitle.text = @"猜你喜欢";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_guess_your_favor_pressed.png"];
            cell.selebg.cellTitle.text = @"猜你喜欢";
            
        }else if (indexPath.row == 1){
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_friends_sharing.png"];
            cell.cellbg.cellTitle.text = @"好友分享";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_friends_sharing_pressed.png"];
            cell.selebg.cellTitle.text = @"好友分享";
            
        }
    }
    cell.backgroundView = cell.cellbg;
    cell.selectedBackgroundView = cell.selebg;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyMusicCell * cell = (MyMusicCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"foundnowplaying"]){
        TRPlayingViewController *play = segue.destinationViewController;

        play.currentIndex = ((TRAppDelegate*)[UIApplication sharedApplication].delegate).currentIndex;
    }
}
@end
