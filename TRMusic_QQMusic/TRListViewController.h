//
//  TRListViewController.h
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-24.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRPlayingViewController.h"
@interface TRListViewController : UITableViewController
@property (nonatomic, strong) NSArray * playingList;
@property (nonatomic, strong) TRPlayingViewController * delegate;
@end
