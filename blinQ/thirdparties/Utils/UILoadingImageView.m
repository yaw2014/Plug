//
//  UIArticleImageView.m
//  wxiPadApp
//
//  Created by Hai Le on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILoadingImageView.h"

@implementation UILoadingImageView
@synthesize imgUrl;
@synthesize receivedData;
@synthesize connection;
@synthesize activity;
- (void)setImgUrl: (NSString*) url {
    if (url == nil || [url isEqual:@""]) {
        return;
    }
    [imgUrl release];
    imgUrl = nil;
    imgUrl = [url retain];
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * firstUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * fileName = [firstUrl lastPathComponent];
    
    NSString * tempFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * filePath = [tempFolder stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath]) {
        self.image = [[[UIImage alloc] initWithContentsOfFile:filePath] autorelease];
    } else {
        self.activity = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        activity.hidesWhenStopped = YES;
        CGRect f = activity.frame;
        activity.frame = CGRectMake((self.frame.size.width - f.size.width)/2, (self.frame.size.height - f.size.height)/2, f.size.width, f.size.height);
        [self addSubview:activity];
        [activity startAnimating];
        
        
        NSURL * url = [NSURL URLWithString:firstUrl];
        NSURLRequest * theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        self.connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
        if (self.connection) {
            self.receivedData = [NSMutableData data];
        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.receivedData = nil;
	self.connection = nil;
    [activity stopAnimating];
	NSLog(@"error: %@", [error localizedDescription]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	self.connection = nil;
    [activity stopAnimating];
	UIImage * img = [[UIImage alloc] initWithData:self.receivedData];
	self.image = img;
	
    NSString * firstUrl = imgUrl;
    NSString * fileName = [firstUrl lastPathComponent];
    
    NSString * tempFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * filePath = [tempFolder stringByAppendingPathComponent:fileName];
    
    [fileManager createFileAtPath:filePath contents:receivedData attributes:nil];
    
	[img release];
	receivedData = nil;
	
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void) dealloc {
    [imgUrl release];
    [connection release];
    [receivedData release];
    [activity release];
    [super dealloc];
}

@end
