//
//  ViewController.m
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-28.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"
#import "GADBannerView.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    GameView * gameView;
    
    GADBannerView *_bannerView;
    
    UILabel * stepLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self initControllView];
    
    //
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    rect = CGRectMake(rect.origin.x, rect.origin.y+75, rect.size.width, rect.size.height);
    
    gameView = [[GameView alloc]initWithFrame:rect];
    
    [self.view addSubview:gameView];
    
    [self laytouADVView];
    
    //
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
}

-(void)menuClicked
{
    NSLog(@"menuClicked");
}

-(void)passClicked
{
    NSLog(@"passClicked");
}

-(void)initControllView
{
    CGRect rect;
    
    UIColor * color = [UIColor orangeColor];
    
    {
        rect = CGRectMake(20, 30, 80, 35);
        UIButton * btn  = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = color;
        [btn setTitle:@"菜单" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    {
        rect = CGRectMake(20+80+20, 30, 80, 35);
        stepLabel = [[UILabel alloc]initWithFrame:rect];
        stepLabel.text = [NSString stringWithFormat:@"步数:999"];
        stepLabel.textColor = [UIColor whiteColor];
        stepLabel.textAlignment = NSTextAlignmentCenter;
        stepLabel.layer.cornerRadius = 8;
        stepLabel.layer.masksToBounds = YES;
        stepLabel.backgroundColor = color;
        
        [self.view addSubview:stepLabel];
    }
    
    
    {
        rect = CGRectMake(20+80+20+80+20, 30, 80, 35);
        UIButton * btn  = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = color;
        [btn setTitle:@"关数:1" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(passClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}



-(void)laytouADVView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeLargeBanner.size.height-1);
    
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLargeBanner origin:pt];
    
    _bannerView.adUnitID = ADMOB_ID;//调用你的id
    
    _bannerView.rootViewController = self;
    
    [_bannerView loadRequest:[GADRequest request]];
    
    //_bannerView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, pt.y);
    
    
    
    [self.view addSubview:_bannerView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
