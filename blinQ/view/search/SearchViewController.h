//
//  SearchViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionService.h"


@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    
}
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) NSMutableArray *searchResults;

@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
