//
//  PlayerTableViewCell.m
//  AppV3
//
//  Created by Sai krishna K Rao on 3/1/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void) setupPlayerCell:(TTPlayer *) player{
    self.playerName.text = player.name;
    self.playerRating.text = player.rating;
    self.playerState.text = ([player.state length] > 0) ? player.state: @"N/A";
    self.lastPlayed.text =  ([player.lastPlay length] > 0) ? player.lastPlay: @"N/A";
}


@end
