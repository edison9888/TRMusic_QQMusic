//
//  TRUtils.m
//  Day14ParseLrc
//
//  Created by apple on 14-2-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRUtils.h"

@implementation TRUtils
+(NSMutableDictionary *)parseLrcByString:(NSString *)string{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSArray *lines = [string componentsSeparatedByString:@"\n"];
    
    for (NSString *line in lines) {
        if ([line hasPrefix:@"[0"]) {
            NSArray *timeAndTexts = [line componentsSeparatedByString:@"]"];
            for (int i=0; i<timeAndTexts.count-1; i++) {
                NSString *timeString = [timeAndTexts[i] substringFromIndex:1];
                NSString *text = [timeAndTexts lastObject];
                NSArray *times = [timeString componentsSeparatedByString:@":"];
                float time = [times[0] intValue]*60+[times[1] floatValue];
                
                [md setObject:text forKey:[NSString stringWithFormat:@"%f",time]];
            }
        }
    }
    return md;
}
@end
