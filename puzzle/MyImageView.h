//
//  MyImageView.h
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-29.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  imageDelegate <NSObject>

@optional
-(void)moveDection:(UIImageView*)imageView;
@end


@interface MyImageView : UIImageView

@property(weak) id delegate;
@end
