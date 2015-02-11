//
//  MasterTeamViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/27/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "MasterTeamViewController.h"

@interface MasterTeamViewController ()

@end

@implementation MasterTeamViewController

- (void)viewDidLoad {
    //[self makeTableView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    super.objects = [NSMutableArray arrayWithObjects:@"Twitter Feed", @"Upcoming Events", nil] ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text=[self.objects objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
