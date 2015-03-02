//
//  TTPlayer.h
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPlayer : NSObject

@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *expDate;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *rating;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *lastPlay;
@property (nonatomic,strong) NSString *rank;
@property (nonatomic,strong) NSString *wins;
@property (nonatomic,strong) NSString *totalPlayed;

@end
