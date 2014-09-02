//
//  TRMusicGroup.m
//  TMusic
//
//  Created by Alex Zhao on 13-8-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRMusicGroup.h"
#import "FindSongs.h"
#import "Utils.h"
@implementation TRMusicGroup

+ (NSArray *) fakeData
{
    NSMutableArray * musics = nil;
    TRMusic * music = nil;
    
    musics = [NSMutableArray array];
    music = [[TRMusic alloc] init];
    
    NSArray  * array= [FindSongs listFileWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
    if (array.count) {
        
        [Utils getArtworkByPath:array[0]];
        for (int i = 0; i < array.count; i++) {
            
            
            
            NSMutableDictionary * dic = [Utils getMusicInfoByPath:array[i]];
            music = [[TRMusic alloc] init];
            music.name          = [dic objectForKey:@"Title"];
            music.album         = [dic objectForKey:@"Album"];
            music.artist        = [dic objectForKey:@"Artist"];
            music.duration      = [self durationWithMinutes:2 andSeconds:47];
            music.downloaded    = YES;
            music.highQuality   = NO;
            music.path          = array[i];
            [musics addObject:music];
            
        }
    }
    
    
    

    
    return musics;
}

+ (NSTimeInterval) durationWithMinutes:(int)minutes andSeconds:(int)seconds
{
    return minutes * 60 + seconds;
}

@end
