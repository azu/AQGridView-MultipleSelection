//
//  ViewController.h
//  AQGridView-MultipleSelection
//
//  Created by azu on 06/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface ViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>

@property (retain, nonatomic) IBOutlet UIBarButtonItem *deselectBarButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *selectBarButton;

@property(nonatomic, retain) AQGridView *gridView;
@property(nonatomic, retain) NSMutableArray *imgNameArray;
@property(nonatomic, retain) NSMutableIndexSet *selectedIndexSet;
@end