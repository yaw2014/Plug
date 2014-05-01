//
//  Utils.h
//  FlipbookDiamond
//
//  Created by Hai Le on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface Utils : NSObject

+ (GDataXMLElement*)getSingleChildFrom:(GDataXMLElement*)xmlItem withElementName:(NSString*)elementName;
+ (BOOL) validEmail:(NSString *)email;
@end
