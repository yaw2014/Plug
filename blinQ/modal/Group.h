//
//  Group.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "GDataXMLNode.h"

@interface Group : NSObject {
    
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *groupName;

- (id) initWithElement: (GDataXMLElement*) element;

@end
