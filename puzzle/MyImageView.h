//
//  MyImageView.h
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-29.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    MOVE_DIR_LEFT,
    MOVE_DIR_RIGHT,
    MOVE_DIR_DOWN,
    MOVE_DIR_UP
    
}MOVE_DIR;


@protocol  imageDelegate <NSObject>


@optional
-(void)moveDection:(MOVE_DIR)movDir;
@end


@interface MyImageView : UIImageView
{
    CGPoint downPT;
    BOOL canMove;
}
@property(weak) id delegate;
@end
