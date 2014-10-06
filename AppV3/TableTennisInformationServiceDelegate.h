//
//  TableTennisInformationServiceDelegate.h
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableTennisInformationServiceDelegate <NSObject>

@optional
-(void) didRecieveTableTennisTournamentInformation:(NSArray *) data  andError:(NSError  *) error;

-(void) didRecieveTableTennisPlayerformation:(NSArray *) data  andError:(NSError  *) error;

-(void) didRecieveTop20TableTennisPlayersformation:(NSArray *) data andError:(NSError  *) error;

@end
