//
//  Group.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "Group.h"

@implementation Group
@synthesize groupId, groupName;

- (id) initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.groupId = [[Utils getSingleChildFrom:element withElementName:@"id"] stringValue];
        self.groupName = [[Utils getSingleChildFrom:element withElementName:@"name"] stringValue];
    }
    return self;
}
@end
