//
//  QuestionProtocol.h
//  plug
//
//  Created by Le Thanh Hai on 5/17/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionInfo.h"
@protocol QuestionProtocol
- (void) answerToSectionInfo: (SectionInfo*) sectionInfo;
@end
