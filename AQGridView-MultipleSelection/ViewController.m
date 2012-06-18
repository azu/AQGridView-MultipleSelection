//
//  ViewController.m
//  AQGridView-MultipleSelection
//
//  Created by azu on 06/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SelectedImageCell.h"

@interface ViewController ()

@end

@implementation ViewController {
@private
    AQGridView *gridView_;
    NSMutableArray *imgNameArray_;
    NSMutableIndexSet *selectedIndexSet_;
}


@synthesize deselectBarButton;
@synthesize selectBarButton;
@synthesize gridView = gridView_;
@synthesize imgNameArray = imgNameArray_;
@synthesize selectedIndexSet = selectedIndexSet_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self){
        return nil;
    }

    self.selectedIndexSet = [NSMutableIndexSet indexSet];
    // Sample Images - http://www.futta.net/
    self.imgNameArray = [NSMutableArray array];
    for (int j = 0 ;j < 7 ;j++){
        [self.imgNameArray addObject:[NSString stringWithFormat:@"th_image0%d.jpg", j + 1]];
    }
    for (int j = 0 ;j < 7 ;j++){
        [self.imgNameArray addObject:[NSString stringWithFormat:@"th_image0%d.jpg", j + 1]];
    }

    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Grid View
    self.gridView = [[[AQGridView alloc] init] autorelease];
    // {0, 0, view.width, view.height-toolbar.height}
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 44, 0);
    CGRect resultRect = UIEdgeInsetsInsetRect(self.view.bounds, contentInsets);
    self.gridView.frame = resultRect;
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    [self.view addSubview:self.gridView];
    // BarButtonItem Action
    self.selectBarButton.action = @selector(selectAll);
    self.deselectBarButton.action = @selector(deselectAll);
}
#pragma mark - operate selection
- (void)selectAll {
    [self.selectedIndexSet addIndexesInRange:NSMakeRange(0, [self.imgNameArray count])];
    [self updateVisibleCells];
}

- (void)deselectAll {
    [self.selectedIndexSet removeAllIndexes];
    [self updateVisibleCells];
}
#pragma mark - update cell
- (void)updateVisibleCells {
    for (AQGridViewCell *cell in [self.gridView visibleCells]){
        [self updateCell:cell cellForItemAtIndex:[self.gridView indexForCell:cell]];
    }
}

- (void)updateCell:(AQGridViewCell *)cell cellForItemAtIndex:(NSUInteger)index {
    if ([self.selectedIndexSet containsIndex:index]){
        [(SelectedImageCell *) cell setIsChecked:YES];
    } else {
        [(SelectedImageCell *) cell setIsChecked:NO];
    }
}
#pragma mark - grid view delegate
- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView {
    return [self.imgNameArray count];
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index {
    static NSString *cellIdentifier = @"CellIdentifier";

    SelectedImageCell *cell = (SelectedImageCell *) [aGridView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[[SelectedImageCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 96, 72)
            reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.selectionStyle = AQGridViewCellSelectionStyleNone;
    NSString *imageName = [self.imgNameArray objectAtIndex:index];
    cell.imageView.image = [UIImage imageNamed:imageName];
    [self updateCell:cell cellForItemAtIndex:index];

    return cell;

}

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    if ([self.selectedIndexSet containsIndex:index]){
        [self.selectedIndexSet removeIndex:index];
    } else {
        [self.selectedIndexSet addIndex:index];
    }
    [self updateCell:[self.gridView cellForItemAtIndex:index] cellForItemAtIndex:index];
}

#pragma mark - view will
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.gridView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [self setDeselectBarButton:nil];
    [self setSelectBarButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [gridView_ release], gridView_ = nil;
    [imgNameArray_ release], imgNameArray_ = nil;
    [selectedIndexSet_ release], selectedIndexSet_ = nil;
    [deselectBarButton release];
    [selectBarButton release];
    [super dealloc];
}

@end