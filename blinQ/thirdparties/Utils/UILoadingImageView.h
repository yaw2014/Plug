//
//  UIArticleImageView.h
//  wxiPadApp
//
//  Created by Hai Le on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILoadingImageView : UIImageView {
    NSString *imgUrl;
    NSMutableData * receivedData;
	NSURLConnection * connection;
	
    UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) NSString *imgUrl;
@property (nonatomic, retain) NSMutableData * receivedData;
@property (nonatomic, retain) NSURLConnection * connection;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@end
