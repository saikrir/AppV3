//
//  PlayerTableViewCell.h
//  AppV3
//
//  Created by Sai krishna K Rao on 3/1/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPlayer.h"

@interface PlayerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerRating;
@property (weak, nonatomic) IBOutlet UILabel *playerState;
@property (weak, nonatomic) IBOutlet UILabel *lastPlayed;

-(void) setupPlayerCell:(TTPlayer *) player;


@end
