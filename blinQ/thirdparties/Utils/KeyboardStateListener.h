//
//  KeyboardStateListener.h
//  plug
//
//  Created by Le Thanh Hai on 5/13/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardStateListener : NSObject{
    BOOL _isVisible;
}
+ (KeyboardStateListener *)sharedInstance;
@property (nonatomic, readonly, getter=isVisible) BOOL visible;

@end
