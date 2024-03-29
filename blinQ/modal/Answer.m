//
//  Answer.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "Answer.h"

@implementation Answer
@synthesize answer, answerId, createdDate, user;
@synthesize value;
@synthesize voteDown, voteUp;
- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.answerId = [[Utils getSingleChildFrom:element withElementName:@"id"] stringValue];
        self.answer = [[Utils getSingleChildFrom:element withElementName:@"answer"] stringValue];
        

        self.value = [[[Utils getSingleChildFrom:element withElementName:@"vote"] stringValue] intValue];
        self.voteUp = [[[Utils getSingleChildFrom:element withElementName:@"voteup"] stringValue] intValue];
        self.voteDown = [[[Utils getSingleChildFrom:element withElementName:@"votedown"] stringValue] intValue];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.createdDate = [dateFormatter dateFromString:[[Utils getSingleChildFrom:element withElementName:@"createdDate"] stringValue]];
        
        
        self.user = [[User alloc] initWithElement:[Utils getSingleChildFrom:element withElementName:@"user"]];
    }
    return self;
}

@end
