//
//  LocationInoDataDelegate.h
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyLocation.h"

@protocol LocationInoDataDelegate <NSObject>

@optional
-(void) didRecieveLocationInformation:(MyLocation *) location andError:(NSError *) error;

@end
