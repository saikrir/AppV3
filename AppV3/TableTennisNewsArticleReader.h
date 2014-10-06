//
//  TableTennisNewsArticleReader.h
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticleReader.h"
#import "NewsArticleDelegate.h"


@interface TableTennisNewsArticleReader : NSObject <NewsArticleReader, NSXMLParserDelegate>


@property (strong,atomic)  id<NewsArticleDelegate> newsArticleDelegate;
@property (strong,atomic)  NSString *readerURL;

-(instancetype) initWithReaderURL:(NSString *) readerURL;

@end
