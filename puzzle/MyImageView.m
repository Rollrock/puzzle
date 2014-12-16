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
    /*
    if( [_delegate respondsToSelector:@selector(moveDection:)])
    {
        [_delegate moveDection:self];
    }
     */
    
    canMove = YES;
    
    downPT = [[touches anyObject] locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation=[[touches anyObject] locationInView:self];
    float xDiffrance=downPT.x-touchLocation.x;
    float yDiffrance=downPT.y-touchLocation.y;
    
    NSLog(@"!!!!!x:%f  y:%f",xDiffrance,yDiffrance);
    
    if( [_delegate respondsToSelector:@selector(moveDection:)] )
    {
        
        if(canMove && (  ABS(xDiffrance) > 10 || ABS(yDiffrance) > 10))
        {
            canMove = NO;
            
            if( ABS(xDiffrance) > ABS(yDiffrance ) )
            {
                if( xDiffrance > 0 )
                {
                    [_delegate moveDection:MOVE_DIR_RIGHT];
                }
                else
                {
                    [_delegate moveDection:MOVE_DIR_LEFT];
                }
            }
            else
            {
                if( yDiffrance > 0 )
                {
                    [_delegate moveDection:MOVE_DIR_DOWN];
                }
                else
                {
                    [_delegate moveDection:MOVE_DIR_UP];
                }
            }
        }
        
        
        
        
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
