//
//  Question.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "Question.h"

@implementation Question
@synthesize questionId, subject, question, expireDate, createdDate;
@synthesize user;

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        
    }
    return self;
}

@end
