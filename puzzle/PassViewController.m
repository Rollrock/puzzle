//
//  PassViewController.m
//  puzzle
//
//  Created by zhuang chaoxiao on 14-12-16.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "PassViewController.h"

@interface PassViewController ()

@end

@implementation PassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutView];
    
    [self layoutBackView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)layoutBackView
{
    CGRect rect = CGRectMake(20, 20, 45, 45);
    UIButton * btn = [[UIButton alloc]initWithFrame:rect];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)backClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)layoutView
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:rect];
    scrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrView];
    
    CGFloat imgWidth = (rect.size.width - 10 - 10 - 10)/2;
    
    for( int i = 0; i < 7; ++ i )
    {
        for( int j = 0; j < 2; ++ j )
        {
            rect = CGRectMake(10+(imgWidth+10)*j, 20 + (imgWidth + 10)*i, imgWidth, imgWidth);
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
            imgView.layer.cornerRadius = 8;
            imgView.layer.masksToBounds = YES;
            imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"s_%d.jpg",i*2+j]];//[UIImage imageNamed:@"%d.jpg"];
            imgView.tag = i*2+j;
            imgView.userInteractionEnabled = YES;
            
            [scrView addSubview:imgView];
            
            NSLog(@"rect:%f-%f-%f-%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
            
            
            //
            UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClicked:)];
            [imgView addGestureRecognizer:g];
        }
    }
    
    scrView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, rect.origin.y + rect.size.height+20);
}


-(void)imageClicked:(UITapGestureRecognizer*)g
{
    UIImageView * imgView = (UIImageView*)g.view;
    
    NSLog(@"tag:%d",imgView.tag);
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:imgView.tag forKey:@"picName"];
    
    [def synchronize];
    
    //
    NSDictionary * dict = [NSDictionary dictionaryWithObject:@"1" forKey:@"change"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil userInfo:dict];
    //
    [self backClicked];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
