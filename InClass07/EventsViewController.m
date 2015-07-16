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

@interface EventsViewController () <UITableViewDataSource>
@property NSMutableArray* events;
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"<#myCell#>"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"<#myCell#>"];
    }
    UILabel* title = (UILabel*)[cell viewWithTag:2001];
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
    }
}


@end
