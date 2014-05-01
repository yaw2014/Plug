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



@end
