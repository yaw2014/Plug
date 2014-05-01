//
//  UILineFooterView.m
//  wxiPadApp
//
//  Created by Hai Le on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILineFooterView.h"

@implementation UILineFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect frame = self.frame;
    CGPoint p1 = CGPointMake(frame.origin.x + 3, frame.origin.y + frame.size.height);
    CGPoint p2 = CGPointMake(frame.origin.x + frame.size.width - 3, frame.origin.y + frame.size.height);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);	
	CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, p2.x, p2.y);
	
    CGContextStrokePath(context);
}


@end
