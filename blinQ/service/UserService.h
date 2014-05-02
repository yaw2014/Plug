//
//  UserService.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
#import "Constants.h"
#import "Utils.h"
#import "User.h"

@class UserService;
@protocol UserServiceDelegate

@optional
- (void) didRegisterSuccess: (UserService*) service;
- (void) didRegisterFail: (UserService*) service withMessage: (NSString*) message;

- (void) didSubmitAvatarForUserSuccess: (UserService*) service;
- (void) didSubmitAvatarForUserFail: (UserService*) service withMessage: (NSString*) message;

- (void) didLoginWithEmailSuccess: (UserService*) service;
- (void) didLoginWithEmailFail: (UserService*) service withMessage: (NSString*) message;

- (void) didForgotPasswordWithEmailSuccess: (UserService*) service;
- (void) didForgotPasswordWithEmailFail: (UserService*) service withMessage: (NSString*) message;
@end

@interface UserService : NSObject {
    
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) ASIFormDataRequest *theRequest;
@property (nonatomic, retain) User *user;

+ (void) storeUserName: (NSString*) name;
+ (void) storeEmail: (NSString*) email;
+ (void) storeSection: (NSString*) section;
+ (void) storeYear: (NSString*) year;
+ (void) storeCity: (NSString*) city;
+ (void) storeState: (NSString*) state;
+ (void) storeCountry: (NSString*) country;
+ (void) storeAvatar: (NSString*) avatar;

+ (NSString*) signedInUserName;
+ (NSString*) signedInEmail;
+ (NSString*) signedInSection;
+ (NSString*) signedInYear;
+ (NSString*) signedInCity;
+ (NSString*) signedInState;
+ (NSString*) signedInCountry;
+ (NSString*) signedInAvatar;

- (void) registerWithName: (NSString*) name
              withEmail: (NSString*) email
            withSection: (NSString*) section
               withYear: (NSString*) year
               withCity: (NSString*) city
              withState: (NSString*) state
            withCountry: (NSString*) country
           withPassword: (NSString*) password
           withGroupIds: (NSString*) groupIds;

- (void) submitAvatarForUser: (NSString*) userId withFileName: (NSString*) fileName andData: (NSData*) data;
- (void) loginWithEmail: (NSString*) email andPassword: (NSString*) password;
- (void) forgotPasswordWithEmail: (NSString*) email;
@end
