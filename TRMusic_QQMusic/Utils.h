//
//  Utils.h
//  Day19MusicPlayer
//
//  Created by Tarena on 13-5-2.
//  Copyright (c) 2013年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface Utils : NSObject
+(UIImage *)getArtworkByPath:(NSString *)path;
+(NSMutableDictionary*)getMusicInfoByPath:(NSString *)directoryPath;
@end
