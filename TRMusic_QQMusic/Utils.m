//
//  Utils.m
//  Day19MusicPlayer
//
//  Created by Tarena on 13-5-2.
//  Copyright (c) 2013年 tarena. All rights reserved.
//

#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
@implementation Utils

//获取专辑封面
+(UIImage *)getArtworkByPath:(NSString *)path{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            if ([metadataItem.commonKey isEqualToString :@"artwork"]) {
                NSData *data = [(NSDictionary*)metadataItem.value objectForKey:@"data"];
                return [UIImage imageWithData:data];
                break;
            }
        }
    }
    
    return nil;
}

//获取歌曲信息
+(NSMutableDictionary*)getMusicInfoByPath:(NSString *)directoryPath{
    


    NSURL * fileURL=[NSURL fileURLWithPath:directoryPath];
    NSString *fileExtension = [[fileURL path] pathExtension];
    if ([fileExtension isEqual:@"mp3"]||[fileExtension isEqual:@"m4a"])
    {
        AudioFileID fileID  = nil;
        OSStatus err        = noErr;
        
        err = AudioFileOpenURL( (CFURLRef) fileURL, kAudioFileReadPermission, 0, &fileID );
        if( err != noErr ) {
            NSLog( @"AudioFileOpenURL failed" );
        }
        UInt32 id3DataSize  = 0;
        err = AudioFileGetPropertyInfo( fileID,   kAudioFilePropertyID3Tag, &id3DataSize, NULL );
        
        if( err != noErr ) {
            NSLog( @"AudioFileGetPropertyInfo failed for ID3 tag" );
        }
        NSDictionary *piDict = nil;
        UInt32 piDataSize   = sizeof( piDict );
        err = AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
        if( err != noErr ) {
       [piDict release];
            NSLog( @"AudioFileGetProperty failed for property info dictionary" );
        }

        UInt32 picDataSize = sizeof(picDataSize);
        err =AudioFileGetProperty( fileID,   kAudioFilePropertyAlbumArtwork, &picDataSize, nil);
        if( err != noErr ) {
            NSLog( @"Get picture failed" );
        }



        NSString * Album = [(NSDictionary*)piDict objectForKey:
                            [NSString stringWithUTF8String: kAFInfoDictionary_Album]];
        NSString * Artist = [(NSDictionary*)piDict objectForKey:
                             [NSString stringWithUTF8String: kAFInfoDictionary_Artist]];
        NSString * Title = [(NSDictionary*)piDict objectForKey:
                            [NSString stringWithUTF8String: kAFInfoDictionary_Title]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (Title) {
            [dic setObject:Title forKey:@"Title"];
        }
        if (Artist) {
            [dic setObject:Artist forKey:@"Artist"];
        }
        if (Album) {
            [dic setObject:Album forKey:@"Album"];
        }
        NSLog(@"%@",Title);
        
        NSLog(@"%@",Artist);
        
        NSLog(@"%@",Album);

        return dic;
    }
    
    return nil;
    

}
@end
