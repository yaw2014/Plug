//
//  QuestionService.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "QuestionService.h"


@implementation QuestionService
@synthesize delegate, theRequest;
@synthesize groups;
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

@end
