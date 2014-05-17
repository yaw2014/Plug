//
//  KeyboardStateListener.m
//  plug
//
//  Created by Le Thanh Hai on 5/13/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "KeyboardStateListener.h"
static KeyboardStateListener *listener;
@implementation KeyboardStateListener
+ (KeyboardStateListener *)sharedInstance
{
    if (!listener) {
        listener = [[KeyboardStateListener alloc] init];
    }
    return listener;
}

- (BOOL)isVisible
{
    return _isVisible;
}

- (void)didShow
{
    _isVisible = YES;
}

- (void)didHide
{
    _isVisible = NO;
}

- (id)init
{
    if ((self = [super init])) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
        [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
@end
