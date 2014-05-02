//
//  Question.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Question : NSObject {
    
}

@property (nonatomic, retain) NSString *questionId;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSDate *expireDate;
@property (nonatomic, retain) NSDate *createdDate;
@property (nonatomic, retain) User *user;

- (id) initWithElement: (GDataXMLElement*) element;
@end
