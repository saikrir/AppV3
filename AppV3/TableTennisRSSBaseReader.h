//
//  TableTennisRSSBaseReader.h
//  App
//
//  Created by Sai krishna K Rao on 1/2/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"



@interface TableTennisRSSBaseReader : NSObject<NSXMLParserDelegate>{
    NSMutableString *elementText;
    NSString *currentElement;
    NSString *articleId;
    NSArray *fields;
    NewsArticle *currentArticle;
    NSDateFormatter *dateFormat;
    NSString *imageRegex;
    NSString *NewItem;
}
    
    @property (nonatomic, strong) NSMutableArray *newsArticles;
@end
