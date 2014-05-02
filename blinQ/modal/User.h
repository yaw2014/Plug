//
//  User.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "GDataXMLNode.h"


@interface User : NSObject {
    
}
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *section;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) UIImage *avatarImg;
@property (nonatomic, retain) NSString *password;


@property (nonatomic, retain) NSMutableArray *groups;

- (id) initWithElement: (GDataXMLElement *) element;
@end
