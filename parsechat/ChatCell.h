//
//  ChatCell.h
//  parsechat
//
//  Created by Emily Jiang on 7/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) NSDictionary *message;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;


@end

NS_ASSUME_NONNULL_END
