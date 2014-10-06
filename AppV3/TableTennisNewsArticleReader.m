//
//  TableTennisNewsArticleReader.m
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisNewsArticleReader.h"
#import "TableTennisRSSV2Delegate.h"
#import "NewsArticle.h"


@interface TableTennisNewsArticleReader(){
   
}
    @property (nonatomic, strong) NSXMLParser *xmlParser;
    @property (nonatomic, strong) NSMutableArray *newsArticles;
@end


@implementation TableTennisNewsArticleReader


-(instancetype) initWithReaderURL:(NSString *) readerURL
{
    self = [super init];
    if(self){
        self.readerURL = readerURL;
        self.newsArticles = [[NSMutableArray alloc] init];
    }
    return self;
}


// ToDo Need Caching Here ?

-(void) readNewsArticles{
    [self readNewsArticlesByPage:@1];
}

-(void) readNewsArticlesByPage:(NSNumber *) page{
  
    NSString *urlWithParams = [self.readerURL stringByAppendingString: [page stringValue]];
    NSURL *rssURL = [NSURL URLWithString:urlWithParams];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 30;
    NSURLSession *newsArticlesSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    TableTennisRSSBaseReader *delegate = [[TableTennisRSSV2Delegate alloc] init];
    
    NSURLSessionDataTask *dataTask = [newsArticlesSession dataTaskWithURL:rssURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        string = [string stringByReplacingOccurrencesOfString:@"encoding=\"utf-16\"" withString:@""];
        NSData *aData = [string dataUsingEncoding:NSUTF8StringEncoding];
        self.xmlParser = [[NSXMLParser alloc] initWithData:aData];
        self.xmlParser.delegate = delegate;
        [self.xmlParser parse];
        NSError *parseError = [self.xmlParser parserError];
        
        if(!parseError){
            self.newsArticles = delegate.newsArticles;
            [self.newsArticleDelegate didRecieveNewsArticle:self.newsArticles andError:error];
        }
        else{
            NSLog(@"Failed to parse response Error: %@", parseError);
        }
        
    }];
    [dataTask resume];
}




@end
