//
//  FindSongs.h
//  TRMusic
//
//  Created by forever on 14-2-18.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindSongs : NSObject
+ (NSMutableArray *)listFileWithPath:(NSString *)directoryPath;
@end
