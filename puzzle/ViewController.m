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
#import "MenuViewController.h"
#import "PassViewController.h"
#import "BaiduMobAdView.h"
#import "BaiduMobAdDelegateProtocol.h"
#import "BaiduMobAdInterstitial.h"

@interface ViewController ()<GameViewDelegate,BaiduMobAdViewDelegate,BaiduMobAdInterstitialDelegate>
{
    GameView * gameView;
    
    GADBannerView *_bannerView;
    
    UILabel * _stepLabel;
    
    
    UIImageView * _bgImgView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerCallback:) name:@"notify" object:nil];
    
    //
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _bgImgView = [[UIImageView alloc]initWithFrame:rect];
    _bgImgView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:_bgImgView];
    
    //
    [self initControllView];
    //
    rect = CGRectMake(rect.origin.x, rect.origin.y+75, rect.size.width, rect.size.height);
    
    gameView = [[GameView alloc]initWithFrame:rect];
    gameView.delegate = self;
    
    [self.view addSubview:gameView];
    
    [self laytouADVView];
    
    //
    ///self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
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
    
    NSString * strChange = [data objectForKey:@"change"];

    
    if( [strChange isEqualToString:@"1"])
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
        [btn setTitle:@"图片选择" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(passClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


- (NSString *)publisherId
{
    return @"bf498248";
}

/**
 *  应用在union.baidu.com上的APPID
 */
- (NSString*) appSpec
{
    return @"bf498248";
}


-(void)laytouADVView
{
    
    int rand = arc4random()%(3);
    
    NSLog(@"rand:%d",rand);
    
    if( rand == 0 )
    {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        BaiduMobAdView * _baiduView = [[BaiduMobAdView alloc]init];
        _baiduView.AdType = BaiduMobAdViewTypeBanner;
        
        if( rect.size.height == 480 )
        {
            _baiduView.frame = CGRectMake(0, 400, kBaiduAdViewBanner320x48.width, kBaiduAdViewBanner320x48.height);
        }
        else if( rect.size.height == 1136/2 )
        {
            _baiduView.frame = CGRectMake(0, 380, kBaiduAdViewSquareBanner300x250.width, kBaiduAdViewSquareBanner300x250.height);
        }
        else if( rect.size.height == 667 )
        {
            _baiduView.frame = CGRectMake(0, 430, kBaiduAdViewSquareBanner600x500.width, kBaiduAdViewSquareBanner600x500.height);
        }
        else if( rect.size.height == 2208/3 )
        {
            _baiduView.frame = CGRectMake(0, 470, kBaiduAdViewSquareBanner600x500.width, kBaiduAdViewSquareBanner600x500.height);
        }
        
        
        _baiduView.center = CGPointMake(rect.size.width/2, _baiduView.center.y);
        _baiduView.delegate = self;
        [self.view addSubview:_baiduView];
        [_baiduView start];

    }
    else
    {
        CGRect rect = [[UIScreen mainScreen]bounds];
        CGPoint pt ;
        
        if( rect.size.height >= 667 )
        {
            pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeMediumRectangle.size.height+20);
            _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeMediumRectangle origin:pt];
            
        }
        else if( rect.size.height >= 568 )
        {
            pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeMediumRectangle.size.height+60);
            _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeMediumRectangle origin:pt];
        }
        else
        {
            pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeLargeBanner.size.height-1);
            _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLargeBanner origin:pt];
        }
        
        
        
        NSLog(@"rect:%f-%f",rect.size.height,rect.size.width);
        
        
        
        _bannerView.adUnitID = ADMOB_ID;//调用你的id
        
        _bannerView.rootViewController = self;
        
        [_bannerView loadRequest:[GADRequest request]];
        
        
        if( rect.size.height >= 568 )
        {
            pt = _bannerView.center;
            _bannerView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, pt.y);
        }
        
        [self.view addSubview:_bannerView];
        
    }
    
    
    
    /*
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
