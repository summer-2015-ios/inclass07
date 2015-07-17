//
//  EventViewController.m
//  InClass07
//
//  Created by student on 7/16/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "EventViewController.h"
#import <Parse/PFObject.h>

@interface EventViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *eDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eDescrLabel;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eNameLabel.text = self.event[@"name"];
    self.eLocationLabel.text = self.event[@"location"];
    self.eDateLabel.text = self.event[@"date"];
    self.eDescrLabel.text = self.event[@"description"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)deleteBtnClicked:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Event Delete"
                                                                   message:@"Do you want to delete this event?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self.event deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                  if(error){
                                                                      NSLog(@"error while deleting event");
                                                                      return ;
                                                                  }
                                                                  [self.navigationController popViewControllerAnimated:YES];
                                                              }];

                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {}];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
