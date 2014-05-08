//
//  Utils.m
//  FlipbookDiamond
//
//  Created by Hai Le on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (GDataXMLElement*)getSingleChildFrom:(GDataXMLElement*)xmlItem withElementName:(NSString*)elementName {
	NSArray* result = [xmlItem elementsForName:elementName];
	if(result!= nil && [result count] > 0) {
		return [result objectAtIndex:0];
	}
	return NULL;
}

+ (BOOL) validEmail:(NSString *)email {
    
    //Based on the string below
    //NSString *strEmailMatchstring=@”\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b”;
    
    //Quick return if @ Or . not in the string
    if([email rangeOfString:@"@"].location==NSNotFound || [email rangeOfString:@"."].location==NSNotFound)
        return NO;
    
    //Break email address into its components
    NSString *accountName=[email substringToIndex: [email rangeOfString:@"@"].location];
    email=[email substringFromIndex:[email rangeOfString:@"@"].location+1];
    
    //’.’ not present in substring
    if([email rangeOfString:@"."].location==NSNotFound)
        return NO;
    NSString *domainName=[email substringToIndex:[email rangeOfString:@"."].location];
    NSString *subDomain=[email substringFromIndex:[email rangeOfString:@"."].location+1];
    
    //username, domainname and subdomain name should not contain the following charters below
    //filter for user name
    NSString *unWantedInUName = @" ~!@#$^&*()={}[]|;’:\"<>,?/`";
    //filter for domain
    NSString *unWantedInDomain = @" ~!@#$%^&*()={}[]|;’:\"<>,+?/`";
    //filter for subdomain
    NSString *unWantedInSub = @" `~!@#$%^&*()={}[]:\";’<>,?/1234567890";
    
    //subdomain should not be less that 2 and not greater 6
    if(!(subDomain.length>=2 && subDomain.length<=10)) return NO;
    
    if([accountName isEqualToString:@""] || [accountName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInUName]].location!=NSNotFound || [domainName isEqualToString:@""] || [domainName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInDomain]].location!=NSNotFound || [subDomain isEqualToString:@""] || [subDomain rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInSub]].location!=NSNotFound) {
        return NO;
    } else {
        NSInteger locHbs = [email rangeOfString:@".hbs.edu"].location;
        NSInteger locMba = [email rangeOfString:@"mba"].location;
        if (locHbs == NSNotFound || locMba == NSNotFound) {
            return NO;
        } else {
            NSInteger lengthYear = locHbs - locMba - 3;
            if (lengthYear == 4) {
                NSString *yearStr = [email substringWithRange:NSMakeRange(locMba + 3, 4)];
                NSInteger year = [yearStr intValue];
                if (year > 1900 && year < 2099) {
                    return YES;
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        }
    }

    
    return YES;
}
@end
