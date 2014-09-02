//
//  TRListViewController.m
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-24.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRListViewController.h"
#import "TRMusic.h"
#import "TRMusicGroup.h"
@interface TRListViewController ()

@end

@implementation TRListViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%@",self);
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.playingList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TRMusic * music = self.playingList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d %@",indexPath.row, music.name];
    cell.detailTextLabel.text = music.artist;
    if (music.name == nil) {
        cell.textLabel.text = @"未知歌曲";
        cell.detailTextLabel.text = @"未知歌手";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.delegate.currentIndex = indexPath.row;
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
