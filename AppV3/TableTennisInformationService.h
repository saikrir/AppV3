//
//  TableTennisInformationService.h
//  App
//
//  Created by Sai krishna K Rao on 1/24/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "TableTennisInformationServiceDelegate.h"

@interface TableTennisInformationService : NSObject

@property (weak,nonatomic) id<TableTennisInformationServiceDelegate> dataDelegate;

-(void) getLatestTornaments;

-(void) searchPlayer:(NSString *) playerName;

-(void) top20Player:(NSString *) year;

@end
