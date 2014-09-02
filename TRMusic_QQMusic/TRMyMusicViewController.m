//
//  TRMyMusicViewController.m
//  TMusic
//
//  Created by forever_ on 14-1-16.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRMyMusicViewController.h"
#import "MyMusicCell.h"
#import "TRAllSongsViewController.h"
#import "Utils.h"
#import "TRMusicGroup.h"
#import "TRAppDelegate.h"
#import "TRPlayingViewController.h"
@interface TRMyMusicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray * groups;
@property (nonatomic) int locaMusic;
@end

@implementation TRMyMusicViewController


- (NSArray *)groups{

    if (!_groups) {
        _groups = [[NSArray alloc]init];
    }
    return _groups;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    TRAppDelegate * app = [UIApplication sharedApplication].delegate;
    app.tabbarController.tabbarView.hidden = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMusicCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg@2x.png"]];
  
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    


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
    }else {
        
        return 3;
        
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
        cell.cellbg.headImageView.image = [UIImage imageNamed:@"allsongs.png"];
        cell.cellbg.cellTitle.text = @"全部歌曲";
        cell.cellbg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
        cell.selebg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
        cell.cellbg.numberLable.text = [NSString stringWithFormat:@"%d首",self.locaMusic];
        cell.selebg.numberLable.text = [NSString stringWithFormat:@"%d首",self.locaMusic];

        cell.selebg.headImageView.image = [UIImage imageNamed:@"allsongsSelected.png"];
        cell.selebg.cellTitle.text = @"全部歌曲";
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"cell_auto_down_closed.png"];
            cell.cellbg.cellTitle.text = @"我喜欢";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"cell_auto_down_closed_hilighted.png"];
            cell.selebg.cellTitle.text = @"我喜欢";
            cell.cellbg.numberLable.hidden = YES;
            cell.selebg.numberLable.hidden = YES;
            
        }else if (indexPath.row == 1){
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"userFolder.png"];
            cell.cellbg.cellTitle.text = @"我的歌曲";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"userFolderSelected.png"];
            cell.selebg.cellTitle.text = @"我的歌曲";
            cell.cellbg.numberLable.hidden = YES;
            cell.selebg.numberLable.hidden = YES;
            
        }else if (indexPath.row == 2){
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"discover_icon_chirrup.png"];
            cell.cellbg.cellTitle.text = @"点歌记录";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"discover_icon_chirrup_pressed.png"];
            cell.selebg.cellTitle.text = @"点歌记录";
            cell.cellbg.numberLable.hidden = YES;
            cell.selebg.numberLable.hidden = YES;
            
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"down.png"];
            cell.cellbg.cellTitle.text = @"下载歌曲";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"downSelected"];
            cell.selebg.cellTitle.text = @"下载歌曲";
            cell.cellbg.numberLable.text = [NSString stringWithFormat:@"0首"];
            cell.selebg.numberLable.text = [NSString stringWithFormat:@"0首"];
            cell.cellbg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            cell.selebg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            
        }else if (indexPath.row == 1){
            
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"recent_listen_icon.png"];
            cell.cellbg.cellTitle.text = @"最近播放";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"recent_listen_icon_h.png"];
            cell.selebg.cellTitle.text = @"最近播放";
            cell.cellbg.numberLable.text = [NSString stringWithFormat:@"0首"];
            cell.selebg.numberLable.text = [NSString stringWithFormat:@"0首"];
            cell.cellbg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            cell.selebg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            
        }else if (indexPath.row == 2){
            cell.cellbg.headImageView.image = [UIImage imageNamed:@"dlna_ip.png"];
            cell.cellbg.cellTitle.text = @"iPod歌曲";
            cell.selebg.headImageView.image = [UIImage imageNamed:@"dlna_ip_h.png"];
            cell.selebg.cellTitle.text = @"iPod歌曲";
            cell.cellbg.numberLable.text = [NSString stringWithFormat:@"%d首",self.locaMusic];
            cell.selebg.numberLable.text = [NSString stringWithFormat:@"%d首",self.locaMusic];
            cell.cellbg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            cell.selebg.cellTitle.frame = CGRectMake(65, 8, 117, 26);
            
        }
    }
    cell.backgroundView = cell.cellbg;
    cell.selectedBackgroundView = cell.selebg;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        [self performSegueWithIdentifier:@"list" sender:indexPath];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

     if([segue.identifier isEqualToString:@"mymusicnowplaying"]){
        TRPlayingViewController *play = segue.destinationViewController;
        play.currentIndex = ((TRAppDelegate*)[UIApplication sharedApplication].delegate).currentIndex;
        
    }
}

@end
