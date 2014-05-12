//
//  QuestionService.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "QuestionService.h"
#import "Question.h"
#import "Answer.h"

@implementation QuestionService
@synthesize delegate, theRequest;
@synthesize groups;
@synthesize questions, answers;
- (void) retrieveGroups {
    NSURL *url = [NSURL URLWithString:GROUPS_RETRIEVE_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Retrieve groups: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"group"];
                self.groups = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Group *g = [[Group alloc] initWithElement:ele];
                    [groups addObject:g];
                }
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveGroupsSuccess:)]) {
                    [delegate didRetrieveGroupsSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveGroupsFail:withMessage:)]) {
                    [delegate didRetrieveGroupsFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didRetrieveGroupsFail:withMessage:)]) {
                [delegate didRetrieveGroupsFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didRetrieveGroupsFail:withMessage:)]) {
            [delegate didRetrieveGroupsFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void) sortQuestionsWithExpireDate:(BOOL) withexpire {
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    if ([questions count] == 0 || [questions count] == 1) {
        return;
    }
    for (Question *question in questions) {
        if ([question.expireDate compare:[NSDate date]] == NSOrderedDescending || [question.expireDate compare:[NSDate date]] == NSOrderedSame) {
            [arr1 addObject:question];
        } else {
            [arr2 addObject:question];
        }
    }
    
    //sort each array
    for (int i = 0; i < [arr1 count] - 1; i++) {
        for (int j = i+1; j < [arr1 count]; j++) {
            Question *q1 = [arr1 objectAtIndex:i];
            Question *q2 = [arr1 objectAtIndex:j];
            
            if ([q1.expireDate compare:q2.expireDate] == NSOrderedDescending) {
                Question *temp = q1;
                [arr1 replaceObjectAtIndex:i withObject:q2];
                [arr1 replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
    /*
    for (int i = 0; i < [arr2 count] - 1; i++) {
        for (int j = i+1; j < [arr2 count]; j++) {
            Question *q1 = [arr2 objectAtIndex:i];
            Question *q2 = [arr2 objectAtIndex:j];
            
            if ([q1.expireDate compare:q2.expireDate] == NSOrderedDescending) {
                Question *temp = q1;
                [arr2 replaceObjectAtIndex:i withObject:q2];
                [arr2 replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
    */
    self.questions = [NSMutableArray arrayWithArray:arr1];
    if (withexpire) {
        [questions addObjectsFromArray:arr2];
    }
}

- (void) askAQuestionFromUserId: (NSString*) userId withSubject: (NSString*) subject withQuestion: (NSString*) question withGroupIds: (NSString*) groupIds withExpireDate: (NSString*) expireDate {
    NSURL *url = [NSURL URLWithString:ASK_QUESTION_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:subject forKey:@"subject"];
    [theRequest setPostValue:question forKey:@"question"];
    [theRequest setPostValue:groupIds forKey:@"groupIds"];
    [theRequest setPostValue:expireDate forKey:@"expireDate"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Ask question: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"question"];
                self.questions = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Question *question = [[Question alloc] initWithElement:ele];
                    [self.questions addObject:question];
                }
                if (delegate && [delegate respondsToSelector:@selector(didAskAQuestionSuccess:)]) {
                    [delegate didAskAQuestionSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didAskAQuestionFail:withMessage:)]) {
                    [delegate didAskAQuestionFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didAskAQuestionFail:withMessage:)]) {
                [delegate didAskAQuestionFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didAskAQuestionFail:withMessage:)]) {
            [delegate didAskAQuestionFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];

}

- (void) getMyQuestionsWithUserId: (NSString*) userId withIgnoreIds: (NSString*) ignoreIds {
    NSURL *url = [NSURL URLWithString:GET_MY_QUESTIONS_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:ignoreIds forKey:@"ignoreIds"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Get my questions: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"question"];
                self.questions = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Question *question = [[Question alloc] initWithElement:ele];
                    [self.questions addObject:question];
                }
                [self sortQuestionsWithExpireDate: YES];
                if (delegate && [delegate respondsToSelector:@selector(didGetMyQuestionsSuccess:)]) {
                    [delegate didGetMyQuestionsSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didGetMyQuestionsFail:withMessage:)]) {
                    [delegate didGetMyQuestionsFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didGetMyQuestionsFail:withMessage:)]) {
                [delegate didGetMyQuestionsFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didGetMyQuestionsFail:withMessage:)]) {
            [delegate didGetMyQuestionsFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}
- (void) getQuestionsForMeWithGroupIds: (NSString*) groupIds withIgnoreIds: (NSString*) ignoreIds {
    NSURL *url = [NSURL URLWithString:GET_QUESTIONS_FOR_ME_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:groupIds forKey:@"groupIds"];
    [theRequest setPostValue:ignoreIds forKey:@"ignoreIds"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Questions for me: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"question"];
                self.questions = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Question *question = [[Question alloc] initWithElement:ele];
                    [self.questions addObject:question];
                }
                [self sortQuestionsWithExpireDate: NO];
                if (delegate && [delegate respondsToSelector:@selector(didGetQuestionsForMeSuccess:)]) {
                    [delegate didGetQuestionsForMeSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didGetQuestionsForMeFail:withMessage:)]) {
                    [delegate didGetQuestionsForMeFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didGetQuestionsForMeFail:withMessage:)]) {
                [delegate didGetQuestionsForMeFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didGetQuestionsForMeFail:withMessage:)]) {
            [delegate didGetQuestionsForMeFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}
- (void) getTopQuestionsWithUserId:(NSString *)userId withIgnoreIds:(NSString *)ignoreIds {
    NSURL *url = [NSURL URLWithString:GET_TOP_QUESTIONS_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:ignoreIds forKey:@"ignoreIds"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Top questions: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"question"];
                self.questions = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Question *question = [[Question alloc] initWithElement:ele];
                    [self.questions addObject:question];
                }
                [self sortQuestionsWithExpireDate: NO];
                if (delegate && [delegate respondsToSelector:@selector(didGetTopQuestionsSuccess:)]) {
                    [delegate didGetTopQuestionsSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didGetTopQuestionsFail:withMessage:)]) {
                    [delegate didGetTopQuestionsFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didGetTopQuestionsFail:withMessage:)]) {
                [delegate didGetTopQuestionsFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didGetTopQuestionsFail:withMessage:)]) {
            [delegate didGetTopQuestionsFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}
- (void) submitAnswerFromUserId: (NSString*) userId forQuestionId: (NSString*) questionId withAnswer: (NSString*) answer {
    NSURL *url = [NSURL URLWithString:SUBMIT_ANSWER_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:questionId forKey:@"questionId"];
    [theRequest setPostValue:answer forKey:@"answer"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Submit answer: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"answer"];
                self.answers = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Answer *question = [[Answer alloc] initWithElement:ele];
                    [self.answers addObject:question];
                }
                if (delegate && [delegate respondsToSelector:@selector(didSubmitAnswerSuccess:)]) {
                    [delegate didSubmitAnswerSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didSubmitAnswerFail:withMessage:)]) {
                    [delegate didSubmitAnswerFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didSubmitAnswerFail:withMessage:)]) {
                [delegate didSubmitAnswerFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didSubmitAnswerFail:withMessage:)]) {
            [delegate didSubmitAnswerFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];

}
- (void) retrieveAnswersForQuestion: (NSString*) questionId withUserId: (NSString*) userId {
    NSURL *url = [NSURL URLWithString:GET_ANSWER_FOR_QUESTION_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:questionId forKey:@"questionId"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Retrieve answers: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"answer"];
                self.answers = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Answer *question = [[Answer alloc] initWithElement:ele];
                    [self.answers addObject:question];
                }
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveAnswersForQuestionSuccess:)]) {
                    [delegate didRetrieveAnswersForQuestionSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveAnswersForQuestionFail:withMessage:)]) {
                    [delegate didRetrieveAnswersForQuestionFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didRetrieveAnswersForQuestionFail:withMessage:)]) {
                [delegate didRetrieveAnswersForQuestionFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didRetrieveAnswersForQuestionFail:withMessage:)]) {
            [delegate didRetrieveAnswersForQuestionFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];

}
- (void) searchQuestionByKeyword: (NSString*) keyword {
    NSURL *url = [NSURL URLWithString:SEARCH_ON_QUESTIONS_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:keyword forKey:@"keyword"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Search question: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                NSArray *arr = [element elementsForName:@"question"];
                self.questions = [[NSMutableArray alloc] initWithCapacity:[arr count]];
                for (GDataXMLElement *ele in arr) {
                    Question *question = [[Question alloc] initWithElement:ele];
                    [self.questions addObject:question];
                }
                [self sortQuestionsWithExpireDate: YES];
                if (delegate && [delegate respondsToSelector:@selector(didSearchQuestionsSuccess:)]) {
                    [delegate didSearchQuestionsSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didSearchQuestionsFail:withMessage:)]) {
                    [delegate didSearchQuestionsFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didSearchQuestionsFail:withMessage:)]) {
                [delegate didSearchQuestionsFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didSearchQuestionsFail:withMessage:)]) {
            [delegate didSearchQuestionsFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];

}

- (void)voteForAnswer:(NSString *)answerId withUserId:(NSString *)userId withValue:(NSInteger)value {
    NSURL *url = [NSURL URLWithString:VOTE_ANSWER_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:answerId forKey:@"answerId"];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:[NSString stringWithFormat:@"%d", value] forKey:@"value"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Vote answer: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                if (delegate && [delegate respondsToSelector:@selector(didVoteAnswerSuccess:)]) {
                    [delegate didVoteAnswerSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didVoteAnswerFail:withMessage:)]) {
                    [delegate didVoteAnswerFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didVoteAnswerFail:withMessage:)]) {
                [delegate didVoteAnswerFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didVoteAnswerFail:withMessage:)]) {
            [delegate didVoteAnswerFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

@end
