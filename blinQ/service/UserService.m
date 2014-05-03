//
//  UserService.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "UserService.h"

@implementation UserService
@synthesize delegate, theRequest;
+ (void) storeUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:USER_ID_KEY];
}

+ (void) storeUserName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:USER_NAME_KEY];
}

+ (void) storeEmail:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:USER_EMAIL_KEY];
}

+ (void) storeSection:(NSString *)section {
    [[NSUserDefaults standardUserDefaults] setObject:section forKey:USER_SECTION_KEY];
}

+ (void) storeYear:(NSString *)year {
    [[NSUserDefaults standardUserDefaults] setObject:year forKey:USER_YEAR_KEY];
}

+ (void) storeCity:(NSString *)city {
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:USER_CITY_KEY];
}

+ (void) storeState:(NSString *)state {
    [[NSUserDefaults standardUserDefaults] setObject:state forKey:USER_STATE_KEY];
}

+ (void) storeCountry:(NSString *)country {
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:USER_COUNTRY_KEY];
}

+ (void) storeAvatar:(NSString *)avatar {
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:USER_AVATAR_KEY];
}

+ (NSString*) signedInUserId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_KEY];
}

+ (NSString*) signedInUserName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
}

+ (NSString*) signedInEmail {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_EMAIL_KEY];
}

+ (NSString*) signedInSection {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_SECTION_KEY];
}

+ (NSString*) signedInYear {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_YEAR_KEY];
}

+ (NSString*) signedInCity {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_CITY_KEY];
}

+ (NSString*) signedInState {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_STATE_KEY];
}

+ (NSString*) signedInCountry {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_COUNTRY_KEY];
}

+ (NSString*) signedInAvatar {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_AVATAR_KEY];
}

- (void)registerWithName:(NSString *)name
             withEmail:(NSString *)email
           withSection:(NSString *)section
              withYear:(NSString *)year
              withCity:(NSString *)city
             withState:(NSString *)state
           withCountry:(NSString *)country
          withPassword:(NSString *)password
          withGroupIds:(NSString *)groupIds {
    NSURL *url = [NSURL URLWithString:REGISTER_USER_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:name forKey:@"name"];
    [theRequest setPostValue:email forKey:@"email"];
    [theRequest setPostValue:section forKey:@"section"];
    [theRequest setPostValue:year forKey:@"year"];
    [theRequest setPostValue:city forKey:@"city"];
    [theRequest setPostValue:state forKey:@"state"];
    [theRequest setPostValue:country forKey:@"country"];
    [theRequest setPostValue:password forKey:@"password"];
    [theRequest setPostValue:groupIds forKey:@"groupIds"];
    
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Register user: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                GDataXMLElement *ele = [Utils getSingleChildFrom:element withElementName:@"user"];
                self.user = [[User alloc] initWithElement:ele];
                if (delegate && [delegate respondsToSelector:@selector(didRegisterSuccess:)]) {
                    [delegate didRegisterSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didRegisterFail:withMessage:)]) {
                    [delegate didRegisterFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didRegisterFail:withMessage:)]) {
                [delegate didRegisterFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didRegisterFail:withMessage:)]) {
            [delegate didRegisterFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void) submitAvatarForUser: (NSString*) userId withFileName: (NSString*) fileName andData: (NSData*) data {
    NSURL *url = [NSURL URLWithString:SUBMIT_AVATAR_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    NSString *extension = [fileName pathExtension];
    if ([extension isEqual:@"png"]) {
        [theRequest setData:data withFileName:fileName andContentType:@"image/png" forKey:@"picture"];
    } else {
        [theRequest setData:data withFileName:fileName andContentType:@"image/jpeg" forKey:@"picture"];
    }
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Submit avatar: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                GDataXMLElement *ele = [Utils getSingleChildFrom:element withElementName:@"user"];
                self.user = [[User alloc] initWithElement:ele];
                if (delegate && [delegate respondsToSelector:@selector(didSubmitAvatarForUserSuccess:)]) {
                    [delegate didSubmitAvatarForUserSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didSubmitAvatarForUserFail:withMessage:)]) {
                    [delegate didSubmitAvatarForUserFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didSubmitAvatarForUserFail:withMessage:)]) {
                [delegate didSubmitAvatarForUserFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didSubmitAvatarForUserFail:withMessage:)]) {
            [delegate didSubmitAvatarForUserFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void) loginWithEmail: (NSString*) email andPassword: (NSString*) password {
    NSURL *url = [NSURL URLWithString:LOGIN_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:email forKey:@"email"];
    [theRequest setPostValue:password forKey:@"password"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Log in: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                GDataXMLElement *ele = [Utils getSingleChildFrom:element withElementName:@"user"];
                self.user = [[User alloc] initWithElement:ele];
                if (delegate && [delegate respondsToSelector:@selector(didLoginWithEmailSuccess:)]) {
                    [delegate didLoginWithEmailSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didLoginWithEmailFail:withMessage:)]) {
                    [delegate didLoginWithEmailFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didLoginWithEmailFail:withMessage:)]) {
                [delegate didLoginWithEmailFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didLoginWithEmailFail:withMessage:)]) {
            [delegate didLoginWithEmailFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void) forgotPasswordWithEmail: (NSString*) email {
    NSURL *url = [NSURL URLWithString:FORGOT_PASSWORD_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:email forKey:@"email"];
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Forgot password: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                if (delegate && [delegate respondsToSelector:@selector(didForgotPasswordWithEmailSuccess:)]) {
                    [delegate didForgotPasswordWithEmailSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didForgotPasswordWithEmailFail:withMessage:)]) {
                    [delegate didForgotPasswordWithEmailFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didForgotPasswordWithEmailFail:withMessage:)]) {
                [delegate didForgotPasswordWithEmailFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didForgotPasswordWithEmailFail:withMessage:)]) {
            [delegate didForgotPasswordWithEmailFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void) retrieveUserInfoByUserId: (NSString*) userId {
    NSURL *url = [NSURL URLWithString:RETRIEVE_USER_INFO_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];

    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Get user info: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                GDataXMLElement *ele = [Utils getSingleChildFrom:element withElementName:@"user"];
                self.user = [[User alloc] initWithElement:ele];
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveUserInfoByUserIdSuccess:)]) {
                    [delegate didRetrieveUserInfoByUserIdSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didRetrieveUserInfoByUserIdFail:withMessage:)]) {
                    [delegate didRetrieveUserInfoByUserIdFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didRetrieveUserInfoByUserIdFail:withMessage:)]) {
                [delegate didRetrieveUserInfoByUserIdFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didRetrieveUserInfoByUserIdFail:withMessage:)]) {
            [delegate didRetrieveUserInfoByUserIdFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

- (void)updateUserInfoWithUserId: (NSString*) userId
                        withName:(NSString *)name
                   withSection:(NSString *)section
                      withYear:(NSString *)year
                      withCity:(NSString *)city
                     withState:(NSString *)state
                   withCountry:(NSString *)country
               withOldPassword:(NSString *)oldPassword
               withNewPassword:(NSString *)newPassword
                  withGroupIds:(NSString *)groupIds {
    NSURL *url = [NSURL URLWithString:UPDATE_USER_INFO_URL];
    self.theRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:name forKey:@"name"];
    [theRequest setPostValue:section forKey:@"section"];
    [theRequest setPostValue:year forKey:@"year"];
    [theRequest setPostValue:city forKey:@"city"];
    [theRequest setPostValue:state forKey:@"state"];
    [theRequest setPostValue:country forKey:@"country"];
    [theRequest setPostValue:oldPassword forKey:@"oldPassword"];
    [theRequest setPostValue:newPassword forKey:@"newPassword"];
    [theRequest setPostValue:groupIds forKey:@"groupIds"];
    
    
    __weak ASIFormDataRequest *request = theRequest;
    
    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        NSLog(@"Update info: %@", responseString);
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        GDataXMLElement *element = [doc rootElement];
        if ([element.name isEqual:@"data"]) {
            GDataXMLElement *success = [Utils getSingleChildFrom:element withElementName:@"success"];
            if ([success.stringValue isEqual:@"true"]) {
                GDataXMLElement *ele = [Utils getSingleChildFrom:element withElementName:@"user"];
                self.user = [[User alloc] initWithElement:ele];
                if (delegate && [delegate respondsToSelector:@selector(didUpdateUserInfoByUserIdSuccess:)]) {
                    [delegate didUpdateUserInfoByUserIdSuccess:self];
                }
            } else {
                GDataXMLElement *errMess = [Utils getSingleChildFrom:element withElementName:@"error_message"];
                if (delegate && [delegate respondsToSelector:@selector(didUpdateUserInfoByUserIdFail:withMessage:)]) {
                    [delegate didUpdateUserInfoByUserIdFail:self withMessage:errMess.stringValue];
                }
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(didUpdateUserInfoByUserIdFail:withMessage:)]) {
                [delegate didUpdateUserInfoByUserIdFail:self withMessage:@"Error when access web service"];
            }
        }
    }];
    
    [request setFailedBlock:^{
        NSError * error = [request error];
        NSLog(@"Error: %@", [error localizedDescription]);
        if (delegate && [delegate respondsToSelector:@selector(didUpdateUserInfoByUserIdFail:withMessage:)]) {
            [delegate didUpdateUserInfoByUserIdFail:self withMessage:[error localizedDescription]];
        }
    }];
    
    [theRequest startAsynchronous];
}

@end
