//
//  NewsArticleReader.h
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsArticle;

@protocol NewsArticleReader <NSObject>

-(void) readNewsArticles;
-(void) readNewsArticlesByPage:(NSNumber *) page;

@optional
-(NSArray *) readNewsArticles:(NSNumber *) count;

@end
