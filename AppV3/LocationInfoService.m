//
//  LocationInfoService.m
//  App
//
//  Created by Sai krishna K Rao on 1/25/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "LocationInfoService.h"

@interface LocationInfoService()
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *urlSession;
@end

@implementation LocationInfoService
- (id)init
{
    self = [super init];
    if (self) {
        self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    }
    return self;
}


-(void) whatsMyLocation
{
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithURL:[NSURL URLWithString:@"http://freegeoip.net/json/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        MyLocation *location = [[MyLocation alloc] init];
        if(!error){
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            location.ip =  jsonDict[@"ip"];
            location.countryCode = jsonDict[@"country_code"];
            location.countryName = jsonDict[@"country_name"];
            location.regionCode = jsonDict[@"region_code"];
            location.regionName = jsonDict[@"region_name"];
            location.city = jsonDict[@"city"];
            location.zipCode = jsonDict[@"zipcode"];
            location.latitude = jsonDict[@"latitude"];
            location.longitude = jsonDict[@"longitude"];
            location.metroCode = jsonDict[@"metro_code"];
            location.areaCode = jsonDict[@"areacode"];
        }
        
        [self.locationDataDelegate didRecieveLocationInformation:location andError:error];
    }];
    
    [dataTask resume];
}



@end
