//
//  GameView.m
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-28.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "GameView.h"
#import "MyImageView.h"
#import "SVProgressHUD.h"

#define IMG_NAME_PREFIX @"game"


#define BG_H_DIS  10


#define IMAGE_BADE_TAG   10086


@interface GameView()<imageDelegate>
{
    CGRect jugeRect;
    CGSize imgSize;
    int setp;
    
    
    int rowNum;
    int colNum;
}
@end


@implementation GameView

-(id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(BG_H_DIS, frame.origin.y, frame.size.width-BG_H_DIS*2, frame.size.width-BG_H_DIS*2);
    
    self = [super initWithFrame:frame];
    
    if( self )
    {
        [self initSetting];
        //
        self.backgroundColor = [UIColor lightGrayColor];
        [self initSeparateImage];
    }
    
    return self;
}


-(void)initSetting
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    int value = [def integerForKey:@"row_col_num"];
    
    if( value == 0 )
    {
        rowNum = 4;
        colNum = 4;
        
        [def setInteger:4 forKey:@"row_col_num"];
        
        [def synchronize];
    }
    else
    {
        rowNum = value;
        colNum = value;
    }
}

-(void)initSeparateImage
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    int value = [def integerForKey:@"picName"];
    

    
    NSArray * array = [self separateImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",value]]];
    
    for( int i = 0; i < rowNum; ++ i )
    {
        for( int j = 0; j < colNum; ++ j )
        {
            MyImageView * imgView = [array objectAtIndex:i * colNum + j];
            imgView.delegate = self;
            
            [self addSubview:imgView];
        }
    }
    
    ///随机打碎图片
    for( int i = 0; i < rowNum*colNum; ++ i )
    {
        int rand = arc4random()%(rowNum*colNum);
        
        MyImageView * imgView1 = [array objectAtIndex:rand];
        MyImageView * imgView2 = [array objectAtIndex:rowNum*colNum-rand-1];
        
        CGRect rect = imgView1.frame;
        imgView1.frame = imgView2.frame;
        imgView2.frame = rect;
    }
    
    
    for( int i = 0; i < rowNum*colNum; ++ i )
    {
        int rand = arc4random()%(rowNum*colNum);
        
        MyImageView * imgView1 = [array objectAtIndex:rand];
        MyImageView * imgView2 = [array objectAtIndex:i];
        
        CGRect rect = imgView1.frame;
        imgView1.frame = imgView2.frame;
        imgView2.frame = rect;
    }
    
    //
    MyImageView * imgView = (MyImageView*)[self viewWithTag:rowNum*colNum-1 + IMAGE_BADE_TAG];
    imgView.hidden = YES;
    
    jugeRect = imgView.frame;
    
    [imgView removeFromSuperview];
    //
}


-(void)leftMove:(UIImageView *)imageView
{
    NSLog(@"leftMove");
    
    CGRect rect = imageView.frame;
    
    [UIView animateWithDuration:0.2 animations:^(void){
        imageView.frame = CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }];
}

-(void)rightMove:(UIImageView*)imageView
{
    NSLog(@"rightMove");
    
    CGRect rect = imageView.frame;
    
    [UIView animateWithDuration:0.2 animations:^(void){
        imageView.frame = CGRectMake(rect.origin.x - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }];
}

-(void)upMove:(UIImageView*)imageView
{
    NSLog(@"upMove");
    
    CGRect rect = imageView.frame;
    
    [UIView animateWithDuration:0.2 animations:^(void){
        imageView.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height, rect.size.width, rect.size.height);
    }];
}

-(void)downMove:(UIImageView*)imageView
{
    NSLog(@"downMove");
    
    CGRect rect = imageView.frame;
    
    [UIView animateWithDuration:0.2 animations:^(void){
        imageView.frame = CGRectMake(rect.origin.x, rect.origin.y-rect.size.height, rect.size.width, rect.size.height);
    }];
}


-(BOOL)checkGameOvew
{
    int index = 0;
    
    for( UIImageView * subView  in [self subviews] )
    {
        CGRect frame = subView.frame;
        CGRect rect = CGRectMake(index%colNum * imgSize.width, index/colNum*imgSize.height,0,0);
        
        ++ index;
        
        NSLog(@"==%f-%f====%f-%f",frame.origin.x,frame.origin.y,rect.origin.x,rect.origin.y);
        
        if( !(((int)frame.origin.x == (int)rect.origin.x) && ((int)frame.origin.y == (int)rect.origin.y)))
        {
            return NO;
        }
    }
    
    NSLog(@"success");
    
    
    [SVProgressHUD showWithStatus:@"恭喜，拼图成功~！"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
       
        
        sleep(3.0);
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [SVProgressHUD dismiss];
        });
        
    });
    
    
    return YES;
}


-(void)setpIncrease
{
    if( [_delegate respondsToSelector:@selector(setpIncrease:)])
    {
        [_delegate setpIncrease:++setp];
    }
}


-(void)moveDection:(MOVE_DIR)movDir
{
    for( MyImageView * imageView in [self subviews] )
    {
        CGRect frame = imageView.frame;
        
        NSLog(@"rollrock-%f-%f==%f-%f==%f-%f",frame.origin.x,frame.origin.y,jugeRect.origin.x,jugeRect.origin.y,imgSize.width,imgSize.height);
        
        if( (int)(jugeRect.origin.x) == (int)(frame.origin.x + imgSize.width) && (int)(jugeRect.origin.y) == (int)(frame.origin.y) && (MOVE_DIR_LEFT == movDir))
        {
            jugeRect = imageView.frame;
            
            [self leftMove:imageView];
            
            [self setpIncrease];
            break;
        }
        
        if ( ((int)(jugeRect.origin.x +imgSize.width) == (int)(frame.origin.x))  && ((int)(jugeRect.origin.y) == (int)(frame.origin.y)) &&( MOVE_DIR_RIGHT == movDir ))
        {
            jugeRect = imageView.frame;
            [self rightMove:imageView];
            
            [self setpIncrease];
            break;
        }
        
        if ( ((int)(jugeRect.origin.x)  == (int)(frame.origin.x) ) && ((int)(jugeRect.origin.y +imgSize.height) == (int)(frame.origin.y) )&&( MOVE_DIR_DOWN == movDir ))
        {
            jugeRect = imageView.frame;
            [self downMove:imageView];
            [self setpIncrease];
            break;
        }
        
        if ( ((int)(jugeRect.origin.x)  == (int)(frame.origin.x )) && ((int)(jugeRect.origin.y)  == (int)(frame.origin.y +imgSize.height) )&&( MOVE_DIR_UP == movDir ))
        {
            jugeRect = imageView.frame;
            [self upMove:imageView];
            [self setpIncrease];
            break;
        }
    }
    
    [self checkGameOvew];
    
}


-(NSArray*)separateImage:(UIImage*)image
{
    if( ![image isKindOfClass:[UIImage class]])
    {
        return nil;
    }
    
    NSMutableArray * mutArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGSize size;
    size.width = (image.size.width <= (bounds.size.width -BG_H_DIS*2))? image.size.width:(bounds.size.width-BG_H_DIS*2);
    
    float xSep = image.size.width * 1.0 / rowNum;
    float ySep = xSep;
    
    imgSize.width = size.width * 1.0 / rowNum;
    imgSize.height = imgSize.width;
    
    for( int i = 0; i < rowNum; ++ i )
    {
        for( int j = 0; j < colNum; ++ j )
        {
            CGRect rect = CGRectMake(j*xSep,i*ySep,xSep,ySep);
            
            CGImageRef imgRef = CGImageCreateWithImageInRect([image CGImage], rect);
            UIImage * img = [UIImage imageWithCGImage:imgRef];
            MyImageView * imgView = [[MyImageView alloc]initWithImage:img];
            
            imgView.frame = CGRectMake(j*imgSize.width, i*imgSize.height, imgSize.width, imgSize.height);
            
            imgView.tag = IMAGE_BADE_TAG + i*colNum + j;
            [mutArray addObject:imgView];
            
        }
    }
    
    return mutArray;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



















