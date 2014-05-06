//
//  Answer.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "GDataXMLNode.h"
#import "User.h"

@interface Answer : NSObject {
    
}

@property (nonatomic, retain) NSString *answerId;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSDate *createdDate;
@property (nonatomic, retain) User *user;
@property (nonatomic, assign) NSInteger value;
- (id) initWithElement: (GDataXMLElement*) element;

@end
