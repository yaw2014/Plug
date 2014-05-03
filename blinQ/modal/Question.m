//
//  Question.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question
@synthesize questionId, subject, question, expireDate, createdDate;
@synthesize user;
@synthesize answers;
@synthesize groups;

- (id)initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.questionId = [[Utils getSingleChildFrom:element withElementName:@"id"] stringValue];
        self.subject = [[Utils getSingleChildFrom:element withElementName:@"subject"] stringValue];
        self.question = [[Utils getSingleChildFrom:element withElementName:@"question"] stringValue];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.expireDate = [dateFormatter dateFromString:[[Utils getSingleChildFrom:element withElementName:@"expireDate"] stringValue]];
        self.createdDate = [dateFormatter dateFromString:[[Utils getSingleChildFrom:element withElementName:@"createdDate"] stringValue]];
        
        self.user = [[User alloc] initWithElement:[Utils getSingleChildFrom:element withElementName:@"user"]];
        
        NSArray *arr = [element elementsForName:@"answer"];
        self.answers = [[NSMutableArray alloc] initWithCapacity:[arr count]];
        for (GDataXMLElement *ele in arr) {
            Answer *ans = [[Answer alloc] initWithElement:ele];
            [answers addObject:ans];
        }
    }
    return self;
}

@end
