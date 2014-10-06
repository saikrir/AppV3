//
//  MyLocation.h
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLocation : NSObject

@property (strong, nonatomic) NSString *ip;
@property (strong, nonatomic) NSString *countryCode;
@property (strong, nonatomic) NSString *countryName;
@property (strong, nonatomic) NSString *regionCode;
@property (strong, nonatomic) NSString *regionName;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *metroCode;
@property (strong, nonatomic) NSString *areaCode;

@end
