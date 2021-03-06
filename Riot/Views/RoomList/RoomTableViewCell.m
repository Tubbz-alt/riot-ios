/*
 Copyright 2016 OpenMarket Ltd
 Copyright 2017 Vector Creations Ltd
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "RoomTableViewCell.h"

#import "RiotDesignValues.h"
#import "MXRoom+Riot.h"

@implementation RoomTableViewCell

#pragma mark - Class methods

- (void)customizeTableViewCellRendering
{
    [super customizeTableViewCellRendering];
    
    self.titleLabel.textColor = kRiotPrimaryTextColor;
    
    // Prepare direct room border
    [self.directRoomBorderView.layer setCornerRadius:self.directRoomBorderView.frame.size.width / 2];
    self.directRoomBorderView.clipsToBounds = YES;
    self.directRoomBorderView.layer.borderColor = CGColorCreateCopyWithAlpha(kRiotColorGreen.CGColor, 0.75);
    self.directRoomBorderView.layer.borderWidth = 3;
    
    self.avatarImageView.defaultBackgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Round image view
    [self.avatarImageView.layer setCornerRadius:self.avatarImageView.frame.size.width / 2];
    self.avatarImageView.clipsToBounds = YES;
}

- (void)render:(MXRoom *)room
{
    [room setRoomAvatarImageIn:self.avatarImageView];
    
    self.titleLabel.text = room.riotDisplayname;
    
    self.directRoomBorderView.hidden = !room.isDirect;
    
    self.encryptedRoomIcon.hidden = !room.state.isEncrypted;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.directRoomBorderView.hidden = YES;
    self.encryptedRoomIcon.hidden = YES;
}

+ (CGFloat)cellHeight
{
    return 74;
}

@end
