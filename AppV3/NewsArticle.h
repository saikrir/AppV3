//
//  NewsArticle.h
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsArticle : NSObject

@property (nonatomic,strong) NSString *guid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *newsDescription;
@property (nonatomic,strong) NSString *contentHtml;
@property (nonatomic,strong) NSDate *pubDate;
@property (nonatomic,strong) NSString *imageURL;

@end
