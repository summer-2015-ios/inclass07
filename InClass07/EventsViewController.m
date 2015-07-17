//
//  EventsViewController.m
//  InClass07
//
//  Created by student on 7/16/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "EventsViewController.h"
#import <Parse/PFObject.h>
#import <Parse/PFUser.h>
#import <Parse/PFQuery.h>
#import "EventViewController.h"

@interface EventsViewController () <UITableViewDataSource>
@property NSMutableArray* events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation EventsViewController

- (void)fetchEvents {
    // Do any additional setup after loading the view.
    PFQuery* eventsQuery = [PFQuery queryWithClassName:@"Event"];
    [eventsQuery whereKey:@"owner" equalTo:[[PFUser currentUser] username]];
    [eventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"error fetching events %@", error);
            return;
        }
        
        self.events = [NSMutableArray arrayWithArray:objects];
        NSLog(@"Count of objects returned %lu", (unsigned long)objects.count);
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.events.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    UILabel* title = cell.textLabel;
    PFObject* event = (PFObject*)self.events[indexPath.row];
    title.text = event[@"name"];
    return cell;
}
- (IBAction)logOutBtnClicked:(id)sender {
    //self.navigationController
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}

- (IBAction)addBtnClicked:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"logoutSegue"]){
        [PFUser logOutInBackground] ;
    }else if([segue.identifier isEqualToString:@"eventsToEventSegue"]){
        
        EventViewController* vc = [segue destinationViewController];
        UITableViewCell* cell = (UITableViewCell*) sender;
        long row = [self.tableView indexPathForCell:cell].row;
        vc.event = (PFObject*)self.events[row];
        NSLog(@"Sending model %@", vc.event);
    }
}
-(IBAction) backFromEventAddByCancel:(UIStoryboardSegue* ) segue{
    NSLog(@"Back from add event by cancel");
}
-(IBAction) backFromEventAddBySubmit:(UIStoryboardSegue* ) segue{
    NSLog(@"Back from add event by submit");
    [self fetchEvents];
}
@end
