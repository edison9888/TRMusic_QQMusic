//
//  TRMoreViewController.m
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRMoreViewController.h"
#import "TRPlayingViewController.h"
#import "TRAppDelegate.h"
@interface TRMoreViewController ()

@end

@implementation TRMoreViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"morenowplaying"]){
        TRPlayingViewController *play = segue.destinationViewController;
        play.currentIndex = ((TRAppDelegate*)[UIApplication sharedApplication].delegate).currentIndex;
    }
}

@end
