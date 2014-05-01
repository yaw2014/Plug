//
//  UserService.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject


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


@end
