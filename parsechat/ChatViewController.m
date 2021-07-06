//
//  ChatViewController.m
//  parsechat
//
//  Created by Emily Jiang on 7/6/21.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *messages; // array of dicts

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messages = [[NSMutableArray alloc] init];
    [self refreshMessages];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)refreshMessages {
    // run every sec
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshMessages) userInfo:nil repeats:true];
    // fetch data
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            NSLog(@"%@", posts.description);
//            self.messages = posts;
            for (PFObject *post in posts) {
//                NSLog(@"%@", post);
                NSLog(@"%@", post[@"text"]);
                PFUser *user;
                if (post[@"user"]) {
                    user = post[@"user"];
                }
//                if (post[@"user"] == nil) {
//                    user.username = @"blank username";
//                } else {
//                    user = post[@"user"];
//                }
                NSLog(@"%@", post[@"user"]);
                [self.messages addObject:@{@"text":post[@"text"], @"user":(user ? user.username:@"blank username")}];
//                NSLog(@"%@", self.messages);
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)onSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.messageField.text;
    chatMessage[@"user"] = PFUser.currentUser;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
//            [self.messages addObject:self.messageField.text];
            [self.messages addObject:@{@"text":self.messageField.text, @"user":PFUser.currentUser}];
            self.messageField.text = @"";
            [self.tableView reloadData];
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Signup Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // nothing
            }];
            [alert addAction:dismissAction];
            [self presentViewController:alert animated:YES completion:^{
                // nothing
            }];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    cell.message = self.messages[indexPath.row];
    cell.messageLabel.text = cell.message[@"text"];
//    PFUser *user = cell.message[@"user"];
    cell.usernameLabel.text = cell.message[@"user"];
//    if ([cell.message[@"user"] isEqualToString:@"blank username"]) {
//        cell.usernameLabel.text = cell.message[@"user"];
//    } else {
//        cell.usernameLabel.text = @"blank username";
//    }
    return cell;
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
