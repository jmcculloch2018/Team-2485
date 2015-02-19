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
@property User *usr;
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
        [self performSegueWithIdentifier:@"showRegional" sender:self];
    else if([MasterViewController hasInterwebs]) [self performSegueWithIdentifier:@"showListMatches" sender:self];//Needs Internet
    else [MasterViewController noInternet:self];
}
- (void)setDetailItem:(NSString *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}
- (void)configureView {
    self.navigationController.navigationBar.barTintColor = [Constants gold];
    // Update the user interface for the detail item.
    if (self.detailItem) {
        if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]) {//Needs Internet
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
                
                UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320*widthMultiplier(self),heightMultiplier(self) * 64)];
                UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
                searchDisplayController.delegate = self;
                searchDisplayController.searchResultsDataSource = self;
                searchBar.placeholder = @"e.g. 2485";
                searchBar.delegate = self;
                searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
                self.tableView.tableHeaderView = searchBar;
                
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Events "]) {
                self.resources = ((MasterViewController *)(((DetailViewController *) (self.parent)).parent)).regs;
                self.tableView = [self makeTableView];
                [self.view addSubview:self.tableView];
            } else if ([self.detailItem isEqualToString:@"Team 2485 Sign In"]) {
                [self.navigationItem setTitleView:[MasterViewController createLabelWithName: @"Sign In" big:NO]];

                self.usr = ((DetailViewController *)self.parent).usr;
                [self updateSign];
                if (self.tableView==nil) {
                    self.tableView=[self makeTableView];
                    [self.view addSubview:self.tableView];
                }
                [self.tableView reloadData];
                    
            } else if ([self.detailItem isEqualToString:@"About Us"])[self makeAboutUs];
            else {
                [self makeSignIn];
            }
        }
        
    }
}
-(void)updateSign {
    self.resources = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%.1f hours (Updated 5 AM)", ((MasterViewController *)self.parent).hours],  ((MasterViewController *)self.parent).loggedIn ? @"Sign Out" : @"Sign In",  @"Switch User", nil];

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
    } else if ([[segue identifier] isEqualToString:@"showTwitter"]) {
        [[segue destinationViewController] initWithDescription:
            [_resources objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [[segue destinationViewController] setParent:self];
    } else if ([[segue identifier] isEqualToString:@"showUpcoming"]) {
        [[segue destinationViewController] initWithEvent:
         [_resources objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [[segue destinationViewController] setParent:self];
    } else if ([[segue identifier] isEqualToString:@"showRegional"]) {
        [[segue destinationViewController] initWithRegional:
         [_resources objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [[segue destinationViewController] setParent:self];
    } else if ([[segue identifier] isEqualToString:@"showTeam"]) {
        [[segue destinationViewController] initWithTeam: self.detailItem];
        [[segue destinationViewController] setParent:self];
    } else if ([[segue identifier] isEqualToString:@"showMatch"]) {
        [[segue destinationViewController] initWithMatch:
         [((ListOfMatches *)self.detailItem).matches objectAtIndex:
          [self.tableView indexPathForSelectedRow].row]];
        [[segue destinationViewController] setParent:self];
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
    if (_detailItem == nil) {
        _detailItem = @"About Us";
    }
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
-(void)makeAboutUs {
    self.view.backgroundColor = [Constants black];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10*widthMultiplier(self), 30*heightMultiplier(self), 300*widthMultiplier(self), 450*heightMultiplier(self))];
    lab.numberOfLines = 20;
    lab.textColor = [Constants gold];
    lab.text = [Constants about];
    lab.textAlignment = NSTextAlignmentJustified;
    lab.font = [Constants body:20*widthMultiplier(self)];
    [self.navigationController setToolbarHidden:YES];

    [self.view addSubview: lab];
}
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
    
    tableView.backgroundColor = [Constants black];
    tableView.sectionIndexColor = [Constants gold];
    tableView.sectionIndexBackgroundColor = [Constants gold];
    tableView.sectionIndexTrackingBackgroundColor = [Constants gold];
    tableView.separatorColor = [Constants black];
    [self.navigationController setToolbarHidden:YES];
    
    return tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/**                                                         |
____________________________________________________________|                   |
     _______                                                                    |
    /       \                                                                   |
   /    .    \                 _____                                            |
  |          /                /      \                                          |
  |         /       .        |  .\/.  |        .                      *         |
  |         \                |        |                                         |
  |          \               | \____/ |                                         |
   \         /               |        |                                         |
    \_______/                |/\/\/\/\|                                         |
 _______________________________________________________________________________|
 
 
 
 
 **/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL x =[MasterViewController hasInterwebs];
    BOOL displayThingy = FALSE;
    if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]) {
        if (x) {
            id obj = [_resources objectAtIndex:indexPath.row];
            if ([NSStringFromClass([obj class]) isEqualToString:@"Regional"]) [self selectRegForTeam: obj];
            else [self performSegueWithIdentifier:@"showTeam" sender:self];
        } else displayThingy = TRUE;

    } else if ([NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]) {
        [self performSegueWithIdentifier:@"showMatch" sender:self];
    } else if ([self.detailItem isEqualToString:@"Events"]) {
        [self performSegueWithIdentifier:@"showUpcoming" sender:self];
    } else if ([self.detailItem isEqualToString:@"Tutorials"]) {
        if ([MasterViewController hasInterwebs]) {
            
            NSURL *url = [NSURL URLWithString: ((Tutorial *) [_resources objectAtIndex:indexPath.row]).url];
            
            _mpc =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(movieEnded:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:_mpc];
            
            _mpc.controlStyle = MPMovieControlStyleDefault;
            _mpc.shouldAutoplay = YES;
            [self.view addSubview:_mpc.view];
            [_mpc setFullscreen:YES animated:YES];
        } else [MasterViewController noInternet: self];
    } else if ([self.detailItem isEqualToString:@"Twitter"]) {
        [self performSegueWithIdentifier:@"showTwitter" sender:self];
    } else if ([self.detailItem isEqualToString:@"Rankings"]) {
        if (((MasterViewController *)self.parent).teams == nil || ((MasterViewController *)self.parent).regs == nil) {
            if (x) {
                ((MasterViewController *)self.parent).teams = [RankingsHandler downloadTopTeams];
                ((MasterViewController *)self.parent).regs = [RankingsHandler downloadRegs];
            } else displayThingy = TRUE;
        }
        if (!displayThingy) [self performSegueWithIdentifier:@"showTeams" sender:self];
    } else if ([self.detailItem isEqualToString:@"Teams"]) {
        self.theTeam = [_resources objectAtIndex:indexPath.row];
        if ([NSStringFromClass([self.theTeam class]) isEqualToString:@"Team"]) {
            if (x) [self performSegueWithIdentifier:@"showTeamReg" sender:self];
            else displayThingy = TRUE;
        }
    } else if ([self.detailItem isEqualToString:@"Events "]) {
        [self performSegueWithIdentifier:@"showRegional" sender:self];
    } else if ([self.detailItem isEqualToString:@"Team 2485 Sign In"]) {
        if ([_resources[indexPath.row] hasPrefix: @"Sign"]) {//Needs Internet
            if ([MasterViewController hasInterwebs]) {
                if (((MasterViewController *)self.parent).onCampus) {
                    if ([self.usr toggleSign]) {
                        ((MasterViewController *)self.parent).loggedIn = !((MasterViewController *)self.parent).loggedIn;
                        [self updateSign];
                        [self.tableView reloadData];
                        [[[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil] show];
                    } else {
                        [[[UIAlertView alloc] initWithTitle:@"Cannot sign in between 5 and 6 AM"
                                                    message:@"Try again later"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil] show];
                    }
                } else if (((MasterViewController *)self.parent).bestEffortAtLocation == nil)
                    [[[UIAlertView alloc] initWithTitle:@"No accurate location found"
                                                message:@""
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles: nil] show];
                else {
                    [((MasterViewController *)self.parent) setup];
                    [[[UIAlertView alloc] initWithTitle:@"Not on campus"
                                                message:@""
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles: nil] show];
                }
                
            }
            else [MasterViewController noInternet: self];
        } else { //Switch User - NOTE CHANGE SO BOTH SIGN IN AND DETAIL ARE IN SAME VIEW CONTROLLER
            [User deleteAccounts];
            ((MasterViewController *)self.parent).usr = nil;
            _resources = [NSArray array];
            [self.tableView reloadData];
            [self setDetailItem:@"Sign In"];
        }
    } else {
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
    
    
    if (displayThingy) [MasterViewController noInternet:self];

}
-(IBAction)movieEnded:(id)sender {}
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
    if (![NSStringFromClass([self.detailItem class]) isEqualToString:@"Team"]&&![NSStringFromClass([self.detailItem class]) isEqualToString:@"ListOfMatches"]&&([self.detailItem isEqualToString:@"Teams"] || [self.detailItem isEqualToString:@"Events "])) {
        if ([NSStringFromClass([_resources[indexPath.row] class]) isEqualToString:@"__NSCFString"] ||[NSStringFromClass([_resources[indexPath.row] class]) isEqualToString:@"__NSCFConstantString"]) {
            cell.backgroundColor=[Constants gold];
            cell.textLabel.textColor = [Constants black];;
        } else {
            cell.backgroundColor = [Constants black];;
            cell.textLabel.textColor=[Constants gold];
        }
    } else {
        if (indexPath.row%2==1) {
            cell.backgroundColor=[Constants gold];
            cell.textLabel.textColor = [Constants black];
        } else {
            cell.backgroundColor = [Constants black];
            cell.textLabel.textColor=[Constants gold];
        }
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [Constants body:24];
    
    return cell;
}
#pragma mark - Sign In
-(UITextField *)makeTextField: (CGRect) f {
    f.origin.x*=widthMultiplier(self); f.origin.y*=heightMultiplier(self);
    f.size.width*=widthMultiplier(self); f.size.height*=heightMultiplier(self);
    UITextField *tf = [[UITextField alloc] initWithFrame: f];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.font = [Constants body: widthMultiplier(self) *15];
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardAppearance = UIKeyboardAppearanceDark;
    tf.keyboardType = UIKeyboardTypeDefault;
    tf.returnKeyType = UIReturnKeyNext;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.delegate = self;
    [_comps addObject:tf];

    return tf;
}
-(UILabel *)makeLabelWithFrame: (CGRect) f text: (NSString *)t {
    f.origin.x*=widthMultiplier(self); f.origin.y*=heightMultiplier(self);
    f.size.width*=widthMultiplier(self); f.size.height*=heightMultiplier(self);
    UILabel *lab=[[UILabel alloc] initWithFrame: f];
    lab.font = [Constants body: widthMultiplier(self) *18];
    lab.text = t;
    lab.textColor = [Constants gold];
    [_comps addObject:lab];
    return lab;
}
-(void)makeSignIn{
    _comps = [NSMutableArray array];
    [self.view addSubview:[self makeLabelWithFrame:CGRectMake(25, 75, 150, 35) text:@"First Name:"]];
    
    _tf = [self makeTextField:CGRectMake(135, 75, 170, 35)];
    _tf.placeholder = @"First Name";
    [self.view addSubview:_tf];
    
    [self.view addSubview:[self makeLabelWithFrame:CGRectMake(25, 120, 150, 35) text:@"Last Name:"]];
    
    _tf2 = [self makeTextField: CGRectMake(135, 120, 170, 35)];
    _tf2.placeholder = @"Last Name";
    [self.view addSubview: _tf2];
    
    [self.view addSubview:[self makeLabelWithFrame:CGRectMake(25, 165, 150, 35) text:@"Grade:"]];
    
    _tf3 = [self makeTextField: CGRectMake(135, 165, 170, 35)];
    _tf3.placeholder = @"e.g. 11";
    _tf3.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview: _tf3];
    
    [self.view addSubview:[self makeLabelWithFrame:CGRectMake(25, 210, 150, 35) text:@"Password:"]];
    
    _tf4 = [self makeTextField: CGRectMake(135, 210, 170, 35)];
    _tf4.returnKeyType = UIReturnKeyDone;
    _tf4.placeholder = @"Enter Password";
    _tf4.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview: _tf4];
    [self.navigationController setToolbarHidden:YES];

    self.view.backgroundColor = [Constants black];
}
-(IBAction)submit:(id)sender {
    if ([_tf.text isEqualToString: @""] || [_tf2.text isEqualToString: @""] || [_tf3.text isEqualToString: @""] || [_tf4.text isEqualToString: @""])
        [[[UIAlertView alloc] initWithTitle: @"Fields left blank"
                                    message:@"Please complete all fields"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    else if ([_tf4.text isEqualToString:[Constants password]]) {
        @try {
            User *usr = [[User alloc] init];
            usr.first = _tf.text;
            usr.last = _tf2.text;
            usr.grade = _tf3.text.intValue;
            NSCharacterSet *alphaNums = [NSCharacterSet letterCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:usr.first];
            BOOL valid = [alphaNums isSupersetOfSet:inStringSet];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:usr.last];
            BOOL valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid||!valid2) // Not numeric
                [[[UIAlertView alloc] initWithTitle: @"Invalid name"
                                            message:@"Name may not contian numbers"
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil] show];
            else {
                [usr createUser];
                [usr save];
                ((MasterViewController *)self.parent).usr = usr;
                ((MasterViewController *)self.parent).loggedIn = [usr isSignedIn];
                ((MasterViewController *)self.parent).hours = [usr getHours];
                [_tf4 resignFirstResponder];
                for (UIView *v in _comps) {
                    [v removeFromSuperview];
                }
                self.detailItem = @"Team 2485 Sign In";
                [self configureView];
            }
            
        } @catch (NSException *exception) {
            [[[UIAlertView alloc] initWithTitle: @"Not a number"
                                        message:@"Grade must be an integer"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
        }
    } else
        [[[UIAlertView alloc] initWithTitle: @"Incorrect Password"
                                    message:@"Try again"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.frame.origin.y == _tf.frame.origin.y) [_tf2 becomeFirstResponder];
    else if (textField.frame.origin.y == _tf2.frame.origin.y) [_tf3 becomeFirstResponder];
    else if (textField.frame.origin.y == _tf3.frame.origin.y) [_tf4 becomeFirstResponder];
    else [self submit:nil];
    
    return YES;
}
@end
