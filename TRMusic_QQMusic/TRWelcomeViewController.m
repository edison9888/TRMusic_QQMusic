//
//  TRViewController.m
//  TMusic
//
//  Created by forever_ on 14-1-15.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRWelcomeViewController.h"
#import "TRTabBarViewController.h"
@interface TRWelcomeViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *welcomeScrollView;
@property (strong, nonatomic) NSArray * pictures;
@property (strong, nonatomic) UIPageControl * pageControl;
@end

@implementation TRWelcomeViewController
- (NSArray *)pictures{

    if (!_pictures) {
        _pictures = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
    }
    return _pictures;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setImageToScrollView];
}
- (void)setImageToScrollView{
    
    self.welcomeScrollView.contentSize = CGSizeMake(self.pictures.count*320, 0);
    self.welcomeScrollView.bounces = NO;
    self.welcomeScrollView.pagingEnabled = YES;
    self.welcomeScrollView.showsHorizontalScrollIndicator = NO;
    self.welcomeScrollView.delegate = self;
    for (int i = 0; i < self.pictures.count; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.pictures[i]]];
       
        imgView.frame = CGRectMake(i*320, 0, 320, 568);
        [self.welcomeScrollView addSubview:imgView];
        
        
        
    }
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapComeIn)];
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.welcomeScrollView addGestureRecognizer:tapGestureRecognizer];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 500, 60, 20)];
    self.pageControl.numberOfPages = self.pictures.count;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:self.pageControl];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.pageControl.currentPage = scrollView.contentOffset.x/320;

}
- (void)tapComeIn{
    

}

@end
