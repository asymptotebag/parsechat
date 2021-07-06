//
//  LoginViewController.m
//  parsechat
//
//  Created by Emily Jiang on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)checkFields {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot be blank"
                                                                       message:@"Username and password field cannot be blank."
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // nothing
        }];
        [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:^{
            // nothinkg
        }];
        return NO;
    }
    return YES;
}

- (IBAction)tapSignup:(id)sender {
    if ([self checkFields]) {
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        //    newUser.username = self.usernameField.text;
        //    newUser.email = self.emailField.text;
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Signup Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    // nothing
                }];
                [alert addAction:dismissAction];
                [self presentViewController:alert animated:YES completion:^{
                    // nothing
                }];
                
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                
                // manually segue to logged in view
            }
        }];
    }
}

- (IBAction)tapLogin:(id)sender {
    if ([self checkFields]) {
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    // nothing
                }];
                [alert addAction:dismissAction];
                [self presentViewController:alert animated:YES completion:^{
                    // nothing
                }];
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                // display view controller that needs to shown after successful login
            }
        }];
    }
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
