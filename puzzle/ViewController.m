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
#import "PassViewController.h"
#import "MenuViewController.h"

@interface ViewController ()<GameViewDelegate>
{
    GameView * gameView;
    
    GADBannerView *_bannerView;
    
    UILabel * _stepLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerCallback:) name:@"notify" object:nil];
    
    //
    [self initControllView];
    
    //
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    rect = CGRectMake(rect.origin.x, rect.origin.y+75, rect.size.width, rect.size.height);
    
    gameView = [[GameView alloc]initWithFrame:rect];
    gameView.delegate = self;
    
    [self.view addSubview:gameView];
    
    [self laytouADVView];
    
    //
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
}

-(void)menuClicked
{
    NSLog(@"menuClicked");
    
    MenuViewController * vc = [[MenuViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}


-(void)registerCallback:(NSNotification*)notification
{
    NSDictionary * data = [notification userInfo];
    
    NSString * str = [data objectForKey:@"change"];
    
    if( [str isEqualToString:@"1"])
    {
        [gameView removeFromSuperview];
        gameView = nil;
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        rect = CGRectMake(rect.origin.x, rect.origin.y+75, rect.size.width, rect.size.height);
        
        gameView = [[GameView alloc]initWithFrame:rect];
        gameView.delegate = self;
        
        [self.view addSubview:gameView];

    }
    
}


-(void)setpIncrease:(int)setp
{
    NSLog(@"-(void)setpIncrease:(int)setp  ---:%d",setp);
    
    _stepLabel.text = [NSString stringWithFormat:@"步数:%d",setp];
    
}

-(void)passClicked
{
    NSLog(@"passClicked");
    
    PassViewController * vc = [[PassViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
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
        _stepLabel = [[UILabel alloc]initWithFrame:rect];
        _stepLabel.text = [NSString stringWithFormat:@"步数:999"];
        _stepLabel.textColor = [UIColor whiteColor];
        _stepLabel.textAlignment = NSTextAlignmentCenter;
        _stepLabel.layer.cornerRadius = 8;
        _stepLabel.layer.masksToBounds = YES;
        _stepLabel.backgroundColor = color;
        
        [self.view addSubview:_stepLabel];
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
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
