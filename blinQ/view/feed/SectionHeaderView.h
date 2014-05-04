//
//  SectionHeaderView.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoadingImageView.h"

@class Question;
@class SectionInfo;
@protocol SectionHeaderViewDelegate;

@interface SectionHeaderView : UIView

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) SectionInfo *sectionInfo;
@property (nonatomic, assign) id <SectionHeaderViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *expireDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *nameLbl;
@property (nonatomic, retain) IBOutlet UILabel *classLbl;
@property (nonatomic, retain) IBOutlet UILabel *sectionLbl;

@property (nonatomic, retain) IBOutlet UILabel *subjectLbl;
@property (nonatomic, retain) IBOutlet UILabel *questionLbl;

-(id)initWithQuestion:(Question*) question section:(NSInteger)sectionNumber delegate:(id <SectionHeaderViewDelegate>)aDelegate;
-(void)toggleOpenWithUserAction:(BOOL)userAction;


@end

@protocol SectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

@end
