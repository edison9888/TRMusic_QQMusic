//
//  TRAllSongsViewController.m
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-19.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRAllSongsViewController.h"
#import "TRPlayingViewController.h"
#import "TRAppDelegate.h"
#import "TRMusic.h"

@interface TRAllSongsViewController ()
@property (nonatomic, strong) TRAppDelegate * app;
@end

@implementation TRAllSongsViewController

- (TRAppDelegate *)app{
    if (!_app) {
        _app = [UIApplication sharedApplication].delegate;
    }
    return _app;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.app.playingList.count) {
        
        return self.app.playingList.count+1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.row < self.app.playingList.count) {
    
        TRMusic * music = self.app.playingList[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%d %@",indexPath.row, music.name];
        cell.detailTextLabel.text = music.artist;
        if (music.name == nil) {
            cell.textLabel.text = @"未知歌曲";
            cell.detailTextLabel.text = @"未知歌手";
        }
    }else{
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
    
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}
- (IBAction)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"cellTouch"]) {
        UITableViewCell * cell = sender;
        TRPlayingViewController * play = segue.destinationViewController;
        play.currentIndex = [self.tableView indexPathForCell:cell].row;
    }else if([segue.identifier isEqualToString:@"allsongsnowplaying"]){
        TRPlayingViewController *play = segue.destinationViewController;
        play.currentIndex = self.app.currentIndex;
        
    }
}

@end
