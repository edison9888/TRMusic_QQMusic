//
//  TRTabBarViewController.m
//  TMusic
//
//  Created by forever_ on 14-1-15.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRTabBarViewController.h"
#import "TRAppDelegate.h"
@interface TRTabBarViewController ()

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@end

@implementation TRTabBarViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    TRAppDelegate * app = [UIApplication sharedApplication].delegate;
    app.tabbarController = self;

    self.tabBar.hidden = YES;
    self.tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, 519, 320, 51)];
    self.tabbarView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tabbarView];
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame = CGRectMake(0, 1, 80, 50);
    self.btn1.tag = 0;
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"mymusicSelected"] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(choseViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbarView addSubview:self.btn1];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame = CGRectMake(80, 1, 80, 50);
    self.btn2.tag = 1;
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tuijian_h"] forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(choseViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbarView addSubview:self.btn2];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3.frame = CGRectMake(160, 1, 80, 50);
    self.btn3.tag = 2;
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"icon_find_h"] forState:UIControlStateNormal];
    [self.btn3 addTarget:self action:@selector(choseViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbarView addSubview:self.btn3];
    
    self.btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn4.frame = CGRectMake(240, 1, 80, 50);
    self.btn4.tag = 3;
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"more_h"] forState:UIControlStateNormal];
    [self.btn4 addTarget:self action:@selector(choseViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbarView addSubview:self.btn4];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"channel_subscribe_cell_separate_line.png"]];
    imageView.frame = CGRectMake(0, 0, 320, 1);
    [self.tabbarView addSubview:imageView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)choseViewController:(UIButton*)sender{

    switch (sender.tag) {
        case 0:
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"mymusicSelected"] forState:UIControlStateNormal];
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tuijian_h"] forState:UIControlStateNormal];
            [self.btn3 setBackgroundImage:[UIImage imageNamed:@"icon_find_h"] forState:UIControlStateNormal];
            [self.btn4 setBackgroundImage:[UIImage imageNamed:@"more_h"] forState:UIControlStateNormal];
            self.selectedIndex = 0;
            break;
        case 1:
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tuijianSelected"] forState:UIControlStateNormal];
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"mymusic_h"] forState:UIControlStateNormal];
            [self.btn3 setBackgroundImage:[UIImage imageNamed:@"icon_find_h"] forState:UIControlStateNormal];
            [self.btn4 setBackgroundImage:[UIImage imageNamed:@"more_h"] forState:UIControlStateNormal];
            
            self.selectedIndex = 1;
            break;
        case 2:
            [self.btn3 setBackgroundImage:[UIImage imageNamed:@"icon_find_click"] forState:UIControlStateNormal];
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"mymusic_h"] forState:UIControlStateNormal];
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tuijian_h"] forState:UIControlStateNormal];
            [self.btn4 setBackgroundImage:[UIImage imageNamed:@"more_h"] forState:UIControlStateNormal];
            self.selectedIndex = 2;
            break;
        case 3:
            [self.btn4 setBackgroundImage:[UIImage imageNamed:@"moreSelected"] forState:UIControlStateNormal];
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"mymusic_h"] forState:UIControlStateNormal];
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tuijian_h"] forState:UIControlStateNormal];
            [self.btn3 setBackgroundImage:[UIImage imageNamed:@"icon_find_h"] forState:UIControlStateNormal];
            self.selectedIndex = 3;
            break;
            
    }
    



}
@end
