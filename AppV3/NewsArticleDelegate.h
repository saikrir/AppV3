//
//  NewsArticleDelegate.h
//  App
//
//  Created by Sai krishna K Rao on 1/1/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsArticleDelegate <NSObject>

-(void) didRecieveNewsArticle:(NSArray *) newsArticles andError:(NSError *) error;

@end
