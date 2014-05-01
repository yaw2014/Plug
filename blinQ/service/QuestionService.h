 //
//  QuestionService.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
#import "Constants.h"
#import "Group.h"
#import "Utils.h"

@class QuestionService;
@protocol QuestionServiceDelegate

@optional
- (void) didRetrieveGroupsSuccess: (QuestionService*) service;
- (void) didRetrieveGroupsFail: (QuestionService *)service withMessage: (NSString*) message;

@end

@interface QuestionService : NSObject {
    
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) ASIFormDataRequest *theRequest;

@property (nonatomic, retain) NSMutableArray *groups;

- (void) retrieveGroups;
@end
