//
//  MyImageView.m
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-29.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [_delegate respondsToSelector:@selector(moveDection:)])
    {
        [_delegate moveDection:self];
    }
}


-(id)initWithImage:(UIImage *)image
{
    
    if( self = [super initWithImage:image] )
    {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
