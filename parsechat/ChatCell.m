//
//  ChatCell.m
//  parsechat
//
//  Created by Emily Jiang on 7/6/21.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.messageLabel.text = self.message;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
//- (void)setCell:(NSString *)message {
//    _message = message;
//    self.messageLabel.text = self.message;
//}

@end
