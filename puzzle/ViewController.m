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
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    gameView = [[GameView alloc]init];
    
    [self.view addSubview:gameView];
    
    //[self laytouADVView];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [self laytouADVView];
    
    [super viewDidAppear:animated];
}

-(void)laytouADVView
{
    
    _bannerView = [[GADBannerView alloc]initWithFrame:CGRectMake(0.0,0,320,100)];//设置位置
    
    _bannerView.adUnitID = ADMOB_ID;//调用你的id
    
    _bannerView.rootViewController = self;
    
    
    [_bannerView loadRequest:[GADRequest request]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
