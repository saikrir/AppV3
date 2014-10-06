//
//  LocationInfoService.h
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationInoDataDelegate.h"

@interface LocationInfoService : NSObject

@property (nonatomic, weak) id<LocationInoDataDelegate> locationDataDelegate;
-(void) whatsMyLocation;

@end
