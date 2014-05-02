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

- (void) didAskAQuestionSuccess: (QuestionService*) service;
- (void) didAskAQuestionFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didGetMyQuestionsSuccess: (QuestionService*) service;
- (void) didGetMyQuestionsFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didGetQuestionsForMeSuccess: (QuestionService*) service;
- (void) didGetQuestionsForMeFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didGetTopQuestionsSuccess: (QuestionService*) service;
- (void) didGetTopQuestionsFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didSubmitAnswerSuccess: (QuestionService*) service;
- (void) didSubmitAnswerFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didRetrieveAnswersForQuestionSuccess: (QuestionService*) service;
- (void) didRetrieveAnswersForQuestionFail: (QuestionService *)service withMessage: (NSString*) message;

- (void) didSearchQuestionsSuccess: (QuestionService*) service;
- (void) didSearchQuestionsFail: (QuestionService *)service withMessage: (NSString*) message;
@end

@interface QuestionService : NSObject {
    
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) ASIFormDataRequest *theRequest;

@property (nonatomic, retain) NSMutableArray *groups;

- (void) retrieveGroups;
- (void) askAQuestionFromUserId: (NSString*) userId withSubject: (NSString*) subject withQuestion: (NSString*) question withGroupIds: (NSString*) groupIds withExpireDate: (NSString*) expireDate;

- (void) getMyQuestionsWithUserId: (NSString*) userId withIgnoreIds: (NSString*) ignoreIds;
- (void) getQuestionsForMeWithGroupIds: (NSString*) groupIds withIgnoreIds: (NSString*) ignoreIds;
- (void) getTopQuestionsWithIgnoreIds: (NSString*) ignoreIds;
- (void) submitAnswerFromUserId: (NSString*) userId forQuestionId: (NSString*) questionId withAnswer: (NSString*) answer;
- (void) retrieveAnswersForQuestion: (NSString*) questionId;
- (void) searchQuestionByKeyword: (NSString*) keyword;

@end
