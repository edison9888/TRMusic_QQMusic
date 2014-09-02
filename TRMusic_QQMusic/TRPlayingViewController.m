//
//  TRPlayingViewController.m
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-19.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "TRPlayingViewController.h"
#import "TRMusic.h"
#import "TRAppDelegate.h"
#import "TRLoopButton.h"
#import "Utils.h"
#import "TRUtils.h"
#import "TRListViewController.h"
#import "NSString+Time.h"
#import "JSON.h"
#define FLAG_MAIN_PAD_STATE_CLOSING     1
#define FLAG_MAIN_PAD_STATE_CLOSED      2
#define FLAG_MAIN_PAD_STATE_OPENING     3
#define FLAG_MAIN_PAD_STATE_OPENED      4

#define FLAG_PROGRESS_SLIDER_STATE_NORMAL           1
#define FLAG_PROGRESS_SLIDER_STATE_MOVING_BY_USER   2

#define FLAG_PLAYING_STATE_PAUSE    0
#define FLAG_PLAYING_STATE_PLAYING  1

#define LRCHTTPADRESS @"http://geci.me/api/lyric/"

@interface TRPlayingViewController ()<AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainPadView;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UIImageView * albumImageReflectionView;

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *controlPadBackground;

@property (weak, nonatomic) IBOutlet TRLoopButton *playButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *playedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *functionPadView;
@property (weak, nonatomic) IBOutlet UIImageView *functionPadBackground;
@property (weak, nonatomic) IBOutlet TRLoopButton *playingModeButton;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

@property (nonatomic, strong) TRMusic * music;
@property (nonatomic) unsigned int flagMainPadState;
@property (nonatomic, strong) TRAppDelegate * app;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSMutableData * jsonData;
@property (nonatomic, strong) NSMutableDictionary * lrcDictionary;
@property (nonatomic, strong) NSArray * timeArray;
@property (nonatomic, strong) NSTimer * checkLrcTimer;
@end

@implementation TRPlayingViewController
- (IBAction)draggedSong {
    
    self.app.player.currentTime = self.progressSlider.value;
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSED;
    self.app = [UIApplication sharedApplication].delegate;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkProgressSlider) userInfo:nil repeats:YES];
    [self setPlayer];
    [self setupSubviews];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.app = [UIApplication sharedApplication].delegate;
    self.app.tabbarController.tabbarView.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.app.tabbarController.tabbarView.hidden = YES;
    [self setPlayer];
}
- (void)setPlayer{
    
    
    if (self.currentIndex == self.app.playingList.count) {
        self.currentIndex = 0;
    }else if (self.currentIndex == -1){
        self.currentIndex = self.app.playingList.count - 1;
    }
    if (self.app.playingList.count) {
        
        self.music = self.app.playingList[self.currentIndex];
        NSURL * url = [NSURL fileURLWithPath:self.music.path];
        if (![self.app.player.url.description isEqualToString:url.description]) {
            self.app.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        }
        self.app.player.delegate = self;
        self.app.currentIndex = self.currentIndex;
        self.progressSlider.maximumValue = self.app.player.duration;
        [self.app.player play];
        self.title = self.music.name;
        self.mainTitleLabel.text = self.music.artist;
        self.subtitleLabel.text = self.music.album;
        self.totalTimeLabel.text = [NSString stringWithMinuteAndSecondTime:self.app.player.duration];
        if ([Utils getArtworkByPath:self.music.path]) {
            self.albumImageReflectionView.image = [Utils getArtworkByPath:self.music.path];
            self.albumImageView.image = [Utils getArtworkByPath:self.music.path];
        }else{
            self.albumImageReflectionView.image = [UIImage imageNamed:@"album_placeholder.jpg"];
            self.albumImageView.image = [UIImage imageNamed:@"album_placeholder.jpg"];
        }
        
        self.lrcDictionary = [NSMutableDictionary dictionary];
        [self.tableView reloadData];
        self.jsonData = [NSMutableData data];
        [self.checkLrcTimer invalidate];
        NSString * lrcPath = [@"http://geci.me/api/lyric/" stringByAppendingFormat:@"%@/%@",self.music.name,self.music.artist];
        lrcPath = [lrcPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * lrcURL = [NSURL URLWithString:lrcPath];
        NSData * data = [NSData dataWithContentsOfURL:lrcURL];
        NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [string JSONValue];
        if ([dic[@"count"] intValue] > 0) {
            NSArray * lrcs = dic[@"result"];
            NSString * path = lrcs[0][@"lrc"];
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
            NSURLConnection * conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            if (!conn) {
                NSLog(@"失败");
            }
        }
    }else{
    
        self.mainTitleLabel.text = @"本地无歌曲";
        self.subtitleLabel.text = @"";
        self.totalTimeLabel.text = @"";
    
    }
}
#pragma mark - NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    [UIImage imageWithData:]
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString * string = [[NSString alloc]initWithData:self.jsonData encoding:NSUTF8StringEncoding];
    self.lrcDictionary = [NSMutableDictionary dictionaryWithDictionary:[TRUtils parseLrcByString:string]];
    [self.tableView reloadData];
    if (self.lrcDictionary.count > 0) {
        self.checkLrcTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(moveLrc) userInfo:Nil repeats:YES];
        self.timeArray = [self.lrcDictionary allKeys];
        self.timeArray = [self.lrcDictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 floatValue]<[obj2 floatValue]) {
                return NSOrderedAscending;
            }else return NSOrderedDescending;
        }];
    }
}

-(void)moveLrc{
    
    for (int i=0; i<self.timeArray.count; i++) {
        float time = [self.timeArray[i] floatValue];
        if (time>self.app.player.currentTime) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            break;
        }
    }
}
- (void)setupSubviews{
    
    self.albumImageReflectionView.transform = CGAffineTransformMakeScale(1, -1);
    self.albumImageReflectionView.alpha = 0.8;
    
    UIImage * backgroundImageForFunctionPad = [[UIImage imageNamed:@"playing_toolbar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeTile];
    self.functionPadBackground.image = backgroundImageForFunctionPad;
    
    UIImage * imageForProgressNow = [[UIImage imageNamed:@"playing_slider_play_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 2, 1)];
    [self.progressSlider setMinimumTrackImage:imageForProgressNow forState:UIControlStateNormal];
    UIImage * imageForProgressTotal = [[UIImage imageNamed:@"playing_slider_buf_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 2, 1)];
    [self.progressSlider setMaximumTrackImage:imageForProgressTotal forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"playing_slider_thumb.png"] forState:UIControlStateNormal];
    
    [self.playButton setLoopImages:@[[UIImage imageNamed:@"playing_btn_play_n.png"],
                                     [UIImage imageNamed:@"playing_btn_pause_n.png"]]
              andHighlightedImages:@[[UIImage imageNamed:@"playing_btn_play_h.png"],
                                     [UIImage imageNamed:@"playing_btn_pause_h.png"]]];
    
    [self.playingModeButton setLoopImages:@[[UIImage imageNamed:@"playing_circle_btn.png"],
                                            [UIImage imageNamed:@"playing_single_btn.png"],
                                            [UIImage imageNamed:@"playing_random_btn.png"]]
                     andHighlightedImages:@[[UIImage imageNamed:@"playing_circle_btn_h.png"],
                                            [UIImage imageNamed:@"playing_single_btn_h.png"],
                                            [UIImage imageNamed:@"playing_random_btn_h.png"]]];
    
    UIImage * imageForVolumeNow = [[UIImage imageNamed:@"playing_volumn_slide_foreground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    [self.volumeSlider setMinimumTrackImage:imageForVolumeNow forState:UIControlStateNormal];
    UIImage * imageForVolumeTotal = [[UIImage imageNamed:@"playing_volumn_slide_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    [self.volumeSlider setMaximumTrackImage:imageForVolumeTotal forState:UIControlStateNormal];
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"playing_volumn_slide_sound_icon.png"] forState:UIControlStateNormal];
    
}
- (IBAction)toggleMainPad:(id)sender {
    NSLog(@"---");
    if (self.flagMainPadState == FLAG_MAIN_PAD_STATE_CLOSED || self.flagMainPadState == FLAG_MAIN_PAD_STATE_CLOSING) {
        
        self.flagMainPadState = FLAG_MAIN_PAD_STATE_OPENING;
        
        CGRect frame = self.mainPadView.frame;
        frame.origin.y -= self.functionPadView.frame.size.height;
        
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.mainPadView.frame = frame;
                             self.progressSlider.alpha   = 0.0;
                             self.playedTimeLabel.alpha  = 0.0;
                             self.totalTimeLabel.alpha   = 0.0;
                         } completion:^(BOOL finished){
                             if (finished == YES) {
                                 self.flagMainPadState = FLAG_MAIN_PAD_STATE_OPENED;
                             }
                         }];
    } else if (self.flagMainPadState == FLAG_MAIN_PAD_STATE_OPENED ||
               self.flagMainPadState == FLAG_MAIN_PAD_STATE_OPENING     ) {
        
        self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSING;
        
        CGRect frame = self.mainPadView.frame;
        if ([self respondsToSelector:@selector(topLayoutGuide)]) {
            frame.origin.y = [self.topLayoutGuide length];
        } else {
            frame.origin.y = 0;
        }
        
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.mainPadView.frame = frame;
                             self.progressSlider.alpha   = 1.0;
                             self.playedTimeLabel.alpha  = 1.0;
                             self.totalTimeLabel.alpha   = 1.0;
                         } completion:^(BOOL finished){
                             if (finished == YES) {
                                 self.flagMainPadState = FLAG_MAIN_PAD_STATE_CLOSED;
                             }
                         }];
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)checkProgressSlider{
    self.progressSlider.value = self.app.player.currentTime;
    self.playedTimeLabel.text = [NSString stringWithMinuteAndSecondTime:self.app.player.currentTime];
}
- (IBAction)jumpSong:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
        
            self.currentIndex --;
            [self setPlayer];
        }
            break;
        case 2:{
            if (self.app.player.isPlaying) {
                [self.app.player pause];
            }else{
                [self.app.player play];
            }
        }
            break;
        case 3:{
        
            self.currentIndex ++;
            [self setPlayer];
        }
            break;
    }

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Playing List Segue"]) {
        UINavigationController * navigationController = segue.destinationViewController;
        TRListViewController * playingListViewController = (TRListViewController *)navigationController.topViewController;
        playingListViewController.playingList = self.app.playingList;
        playingListViewController.delegate = self;
    }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"%d",self.playingModeButton.currentIndex);
    switch (self.playingModeButton.currentIndex) {
        case 0:{
            self.currentIndex ++;
            [self setPlayer];
        }
            break;
        case 1:{
            self.app.player.currentTime = 0;
            [self setPlayer];
        }
            break;
        case 2:{
            self.currentIndex = arc4random()%self.app.playingList.count;
            [self setPlayer];
        }
            break;
        default:
            break;
    }
}
- (IBAction)volumSlider {
    self.app.player.volume = self.volumeSlider.value;
}

#pragma mark - tableView协议
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *key = self.timeArray[indexPath.row];
    NSString *text = [self.lrcDictionary objectForKey:key];
    cell.textLabel.text = text;
    cell.textLabel.font =  [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcDictionary.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


@end
