//
//  DetailViewController.m
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>

static NSString *CellIdentifier = @"CellIdentifier";
@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property NSArray *resources;
@property UITableView *tableView;
@property Regional *theRegForTeam;
@property (strong, nonatomic)MPMoviePlayerController *mpc;
@end

@implementation DetailViewController

#pragma mark - General
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    Team *t = [RankingsHandler findTeam:searchBar.text.intValue];
    if (t.number>0) {
        [self selectTeam:t];
    }
    [searchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
-(void)selectTeam: (Team *) team {
    self.theTeam = team;
    [self performSegueWithIdentifier:@"showTeamReg" sender:self];
}
-(void)selectRegForTeam: (Regional *) reg {
    self.theRegForTeam = reg;
    
    if (((DetailViewController *)_parent).theTeam == nil)
        [self presentViewController: [RegionalInfoViewController newWithRegional:reg]
                           animated: YES
                         completion: nil];
    else [self performSegueWithIdentifier:@"showListMatches" sender:self];
}
- (void)setDetailItem:(NSString *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]) {
            self.resources = [RankingsHandler downloadRegsForTeam:self.detailItem];
            [self.navigationItem setTitleView:[MasterViewController createLabelWithName: [self.detailItem name] big:NO]];
            self.tableView = [self makeTableView];
            [self.view addSubview:self.tableView];
        } else if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]) {
            [self.navigationItem setTitleView:[MasterViewController createLabelWithName:  [[self.detailItem team] name] big:NO]];
            self.tableView = [self makeTableView];
            [self.view addSubview:self.tableView];
        } else {
            [self.navigationItem setTitleView:[MasterViewController createLabelWithName: self.detailItem big:NO]];
            if ([self.detailItem isEqualToString:@"Twitter"]) {
                self.resources = ((MasterViewController *) self.parent).tweets;
                self.tableView=[self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Events"]) {
                self.resources = ((MasterViewController *) self.parent).events;
                self.tableView=[self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Media"]) {
                
            } else if ([self.detailItem isEqualToString:@"Rankings"]) {
                self.resources = [NSArray arrayWithObjects:@"Teams", @"Events ", nil];
                self.tableView = [self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Tutorials"]) {
                self.resources = ((MasterViewController *) self.parent).tuts;
                self.tableView=[self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Resources"]) {
                self.resources = [NSArray arrayWithObjects:@"Team 2485 Site", @"FRC Site", @"Game Manual", nil];
                self.tableView=[self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Teams"]) {
                self.resources = ((MasterViewController *)(((DetailViewController *) (self.parent)).parent)).teams;
                self.tableView = [self makeTableView];
                
                UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
                UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
                searchDisplayController.delegate = self;
                searchDisplayController.searchResultsDataSource = self;
                searchBar.delegate = self;
                self.tableView.tableHeaderView = searchBar;
                
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Events "]) {
                self.resources = ((MasterViewController *)(((DetailViewController *) (self.parent)).parent)).regs;
                self.tableView = [self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Team 2485 Sign-In"]) [self makeSignInFields];
        }
        
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTeamReg"]) {
        [[segue destinationViewController] setDetailItem:self.theTeam];
        [[segue destinationViewController] setParent:self];
        [[segue destinationViewController] configureView];
    } else if ([[segue identifier] isEqualToString:@"showListMatches"]) {
        [[segue destinationViewController] setDetailItem:
         [RankingsHandler downloadMatchesForTeam:((DetailViewController *) _parent).theTeam regional:_theRegForTeam]];
        [[segue destinationViewController] setParent:self];
        [[segue destinationViewController] configureView];
    } else {
        [[segue destinationViewController] setDetailItem:
            [_resources objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [[segue destinationViewController] setParent:self];
        [[segue destinationViewController] configureView];
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

#pragma mark - Table View
-(UITableView *)makeTableView {
    CGFloat x = 0;
    CGFloat y = 63;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height-y;
    CGRect tableFrame = CGRectMake(x, y, width, height);//Create table view frame
    
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
    
    tableView.backgroundColor = [UIColor blackColor];
    tableView.sectionIndexColor = [Constants gold];
    tableView.sectionIndexBackgroundColor = [Constants gold];
    tableView.sectionIndexTrackingBackgroundColor = [Constants gold];
    tableView.separatorColor = [Constants gold];
    [self.navigationController setToolbarHidden:YES];
    
    return tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/*                                                          |
____________________________________________________________|                   |
    _______                                                                     |
    /       \                                                                   |
   /    .    \                 _____                                            |
  |          /                /      \                                          |
  |         /       .        |  .\/.  |        .                      *         |
  |         \                |        |                                         |
  |          \               | \____/ |                                         |
   \         /               |        |                                         |
    \_______/                |/\/\/\/\|                                         |
 _______________________________________________________________________________|
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]) {
        id obj = [_resources objectAtIndex:indexPath.row];
        if ([NSStringFromClass([obj class]) isEqualToString:@"Regional"])
            [self selectRegForTeam: obj];
        else {
            TeamInfoViewController * tivc = [TeamInfoViewController newWithTeam:self.detailItem];
            tivc.parent = self;
            [self presentViewController:tivc animated:YES completion:nil];
        }

    } else if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]) {
        MatchInfoViewController *mivc= [MatchInfoViewController newWithMatch:[((ListOfMatches *)self.detailItem).matches objectAtIndex:indexPath.row]];
        mivc.parent=self;
        [self presentViewController:mivc animated:YES completion:nil];
    } else if ([self.detailItem isEqualToString:@"Events"]) {
        UpcomingEventsViewController *uevc= [UpcomingEventsViewController newWithEvent:[_resources objectAtIndex:indexPath.row]];
        uevc.parent=self;
        [self presentViewController:uevc animated:YES completion:nil];
    } else if ([self.detailItem isEqualToString:@"Tutorials"]) {
        NSURL *url = [NSURL URLWithString: ((Tutorial *) [_resources objectAtIndex:indexPath.row]).url];
        
        _mpc =  [[MPMoviePlayerController alloc]
                 initWithContentURL:url];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_mpc];
        
        _mpc.controlStyle = MPMovieControlStyleDefault;
        _mpc.shouldAutoplay = YES;
        [self.view addSubview:_mpc.view];
        [_mpc setFullscreen:YES animated:YES];
    } else if ([self.detailItem isEqualToString:@"Twitter"]) {
        TwitterFeedViewController *tfvc= [TwitterFeedViewController newWithDescription:[_resources objectAtIndex:indexPath.row]];
        tfvc.parent=self;
        [self presentViewController:tfvc animated:YES completion:nil];
    } else if ([self.detailItem isEqualToString:@"Rankings"]) {
        [self performSegueWithIdentifier:@"showTeams" sender:self];
    } else if ([self.detailItem isEqualToString:@"Teams"]) {
        self.theTeam = [_resources objectAtIndex:indexPath.row];
        if ([NSStringFromClass([self.theTeam class]) isEqualToString:@"Team"])
            [self performSegueWithIdentifier:@"showTeamReg" sender:self];
    } else if ([self.detailItem isEqualToString:@"Events "]) {
        RegionalInfoViewController * rivc = [RegionalInfoViewController newWithRegional: [_resources objectAtIndex:indexPath.row]];
        rivc.parent = self;
        [self presentViewController:rivc animated:YES completion:nil];
    }
    else {
        NSString*myurl;
        switch (indexPath.row) {
            case 0:
                //Open Website
                myurl = @"http://robotics.francisparker.org/";
                break;
            case 1:
                //Open FRC Website
                myurl = @"http://www.usfirst.org/roboticsprograms/frc";
                break;
            case 2:
                //Open Game Manual
                myurl = @"http://www.usfirst.org/sites/default/files/uploadedFiles/Robotics_Programs/FRC/Game_and_Season__Info/2015/2015GameManual0130.pdf";
                break;
            default:
                break;
        }
        NSURL *url = [NSURL URLWithString:myurl];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"])
        return [((ListOfMatches *)self.detailItem).matches count];
    return [_resources count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]) { //match list
        Match *m = [((ListOfMatches *)self.detailItem).matches objectAtIndex:indexPath.row];
        cell.textLabel.text = [m description];
    }
    else cell.textLabel.text = [_resources[indexPath.row] description];
    if (![NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]&&![NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]&&[self.detailItem isEqualToString:@"Teams"]) {
        if (indexPath.row%6==0) {
            cell.backgroundColor=[Constants gold];
            cell.textLabel.textColor = [UIColor blackColor];;
        } else {
            cell.backgroundColor = [UIColor blackColor];;
            cell.textLabel.textColor=[Constants gold];
        }
    } else {
        if (indexPath.row%2==1) {
            cell.backgroundColor=[Constants gold];
            cell.textLabel.textColor = [UIColor blackColor];
        } else {
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor=[Constants gold];
        }
    }
    cell.font = [UIFont fontWithName:@"Copperplate" size:24];
    
    return cell;
}
#pragma mark - Sign In
-(void)makeSignInFields {
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(25, 125, 150, 50)];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = @"Password:";
    [self.view addSubview:lab];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(125, 125, 170, 50)];
    _tf.borderStyle = UITextBorderStyleRoundedRect;
    _tf.font = [UIFont systemFontOfSize:15];
    _tf.placeholder = @"enter password";
    _tf.autocorrectionType = UITextAutocorrectionTypeNo;
    _tf.keyboardType = UIKeyboardTypeDefault;
    _tf.returnKeyType = UIReturnKeyDone;
    _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tf.delegate = self;
    [self.view addSubview: _tf];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(self.view.frame.size.width/2-50, 200, 100, 50);
    [but setTitle:@"Submit" forState:UIControlStateNormal];
    [but addTarget:self
            action:@selector(submit:)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}
-(IBAction)submit:(id)sender {
    if ([_tf.text isEqualToString:[Constants password]]) {
        MasterTeamViewController *mtvc= [[MasterTeamViewController alloc] init];
        [self presentViewController:mtvc
                           animated:YES
                         completion:nil];
    } else
        [[[UIAlertView alloc] initWithTitle: @"Incorrect Password"
                                    message:@"Try again"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self submit:nil];
    return YES;
}
@end
