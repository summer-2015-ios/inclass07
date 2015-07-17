//
//  AddEventViewController.m
//  InClass07
//
//  Created by student on 7/16/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "AddEventViewController.h"
#import <Parse/PFObject.h>
#import <Parse/PFUser.h>

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eNameTV;
@property (weak, nonatomic) IBOutlet UITextField *eLocationTV;
@property (weak, nonatomic) IBOutlet UITextField *eDateTV;
@property (weak, nonatomic) IBOutlet UITextView *eDescrTV;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

- (IBAction)submitBtnClicked:(UIButton *)sender {
    NSString* eName = self.eNameTV.text;
    NSString* eLocation = self.eLocationTV.text;
    NSString* eDate = self.eDateTV.text;
    NSString* eDescr = self.eDescrTV.text;
    if(!eName || !eLocation || !eDate || !eDescr){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Missing Field"
                                                                       message:@"All field are mandatory!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    PFObject* event = [PFObject objectWithClassName:@"Event"];
    event[@"name"] = eName;
    event[@"location"] = eLocation;
    event[@"date"] = eDate;
    event[@"description"] = eDescr;
    event[@"owner"] = [[PFUser currentUser] username];
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"error while saving event %@", error);
            return ;
        }
        [self performSegueWithIdentifier:@"submitToEventsSegue" sender:self];
    }];
}

@end
