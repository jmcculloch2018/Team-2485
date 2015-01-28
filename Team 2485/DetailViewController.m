//
//  DetailViewController.m
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "DetailViewController.h"
#import "UpcomingEventsHandler.h"
#import "UpcomingEventsViewController.h"
#import "MasterViewController.h"
#import "Event.h"
static NSString *CellIdentifier = @"CellIdentifier";
@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSArray *events;
@property UITableView *tableView;
@end

@implementation DetailViewController

#pragma mark - General
- (void)setDetailItem:(NSString *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        [self.navigationItem setTitleView:[MasterViewController createLabelWithName: self.detailItem big:NO]];
        if ([self.detailItem isEqualToString:@"Upcoming Events"]) {
            self.events = ((MasterViewController *) self.parent).events;
            self.tableView=[self makeTableView];
            [self.view addSubview:self.tableView];
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Upcoming Events
-(UITableView *)makeTableView {
    CGFloat x = 0;
    CGFloat y = 70;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height-70;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//    _______
//   /       \
//  /    .    \                 ______
// |          /                /      \
// |         /   .   .   .    |  .  .  |
// |         \                |        |
// |          \               |        |
//  \         /               |        |
//   \_______/                |/\/\/\/\|

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UpcomingEventsViewController *uevc= [UpcomingEventsViewController newWithEvent:[_events objectAtIndex:indexPath.row]];
    uevc.parent=self;
    [self presentViewController:uevc
                       animated:YES
                     completion:nil];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
 
    cell.textLabel.text=[[_events objectAtIndex:indexPath.row] name];
    return cell;
}
@end
