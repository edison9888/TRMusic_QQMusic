//
//  FindSongs.m
//  TRMusic
//
//  Created by forever on 14-2-18.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "FindSongs.h"

@implementation FindSongs
+ (NSMutableArray *)listFileWithPath:(NSString *)directoryPath{
    NSMutableArray * filePaths = [NSMutableArray array];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * fileNames = [fm contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString * fileName in fileNames) {
        
        NSString * path = [directoryPath stringByAppendingPathComponent:fileName];
        if ([fileName hasSuffix:@"mp3"]) {
            [filePaths addObject:path];
        }
    }
    return filePaths;
}
@end
