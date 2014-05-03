//
//  User.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "User.h"
#import "Group.h"

@implementation User
@synthesize userId, name, email, section, year, state, city, country, avatar;
@synthesize groups;
@synthesize avatarImg;
@synthesize oldPassword;
- (id) initWithElement:(GDataXMLElement *)element {
    if (self = [super init]) {
        self.userId = [[Utils getSingleChildFrom:element withElementName:@"id"] stringValue];
        self.name = [[Utils getSingleChildFrom:element withElementName:@"name"] stringValue];
        self.email = [[Utils getSingleChildFrom:element withElementName:@"email"] stringValue];
        self.section = [[Utils getSingleChildFrom:element withElementName:@"section"] stringValue];
        self.year = [[Utils getSingleChildFrom:element withElementName:@"year"] stringValue];
        self.state = [[Utils getSingleChildFrom:element withElementName:@"state"] stringValue];
        self.city = [[Utils getSingleChildFrom:element withElementName:@"city"] stringValue];
        self.country = [[Utils getSingleChildFrom:element withElementName:@"country"] stringValue];
        self.avatar = [[Utils getSingleChildFrom:element withElementName:@"avatar"] stringValue];
        
        NSArray *arr = [element elementsForName:@"group"];
        self.groups = [[NSMutableArray alloc] initWithCapacity:[arr count]];
        for (GDataXMLElement *ele in arr) {
            Group *g = [[Group alloc] initWithElement:ele];
            [groups addObject:g];
        }
    }
    return self;
}
@end
