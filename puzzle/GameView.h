//
//  GameView.h
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-28.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GameViewDelegate <NSObject>

-(void)setpIncrease:(int)setp;

@end


@interface GameView : UIView

@property(weak) id delegate;


-(id)initWithFrame:(CGRect)frame;

@end
