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


@interface TableTennisNewsArticleReader()
    @property (nonatomic, strong) NSXMLParser *xmlParser;
    @property (nonatomic, strong) NSMutableArray *newsArticles;
    @property (nonatomic,strong) NSURLSessionConfiguration *sessionConfiguration;
    @property (nonatomic,strong) NSURLSession *urlSession;

@end


@implementation TableTennisNewsArticleReader


-(instancetype) initWithReaderURL:(NSString *) readerURL
{
    self = [super init];
    if(self){
        self.readerURL = readerURL;
        self.newsArticles = [[NSMutableArray alloc] init];
        self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionConfiguration.timeoutIntervalForRequest = 30;
        self.urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
        
        NSLog(@"Session Configuration Setup!");
    }
    return self;
}


// ToDo Need Caching Here ?

-(void) readNewsArticles{
    [self readNewsArticlesByPage:@1];
}

-(void) readNewsArticlesByPage:(NSNumber *) page{
  
    //NSString *urlWithParams = [self.readerURL stringByAppendingString: [page stringValue]];
    NSURL *rssURL = [NSURL URLWithString:self.readerURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:rssURL];
    TableTennisRSSBaseReader *delegate = [[TableTennisRSSV2Delegate alloc] init];
    
    NSURLSessionDataTask *rssXMLTask = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *theData, NSURLResponse *response, NSError *error)
    {
        
        NSString *responseXML = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
        
        if([self isResponseUTF16Encoded:response]){
            responseXML = [responseXML stringByReplacingOccurrencesOfString:@"encoding=\"utf-16\"" withString:@""];
        }
        
        if(responseXML){
            NSData *aData = [responseXML dataUsingEncoding:NSUTF8StringEncoding];
            self.xmlParser = [[NSXMLParser alloc] initWithData:aData];
            [self.xmlParser setShouldProcessNamespaces:YES];
            self.xmlParser.delegate = delegate;
            [self.xmlParser parse];
            NSError *parseError = [self.xmlParser parserError];
            if(!parseError){
                self.newsArticles = delegate.newsArticles;
                [self.newsArticleDelegate didRecieveNewsArticle:self.newsArticles andError:error];
            }
            else{
                NSLog(@"Failed to parse response Error: \n--> %@", responseXML);
            }
        }else{
            NSLog(@"Failed to fetch Data %@", error);
        }
        
        
    }];

    [rssXMLTask resume];
}

-(BOOL) isResponseUTF16Encoded:(NSURLResponse *) response{
    
    BOOL isUTF16Encoded = NO;
    NSHTTPURLResponse *httpResponse = ((NSHTTPURLResponse *) response);
    NSString *contentType = [httpResponse allHeaderFields][@"Content-Type"];
    
    if(contentType){
        NSString *charset = [[contentType componentsSeparatedByString:@";"] lastObject];
        if(charset){
           NSString *encoding = [[charset componentsSeparatedByString:@"="] lastObject];
           isUTF16Encoded= ([encoding caseInsensitiveCompare:@"UTF-8"] != 0);
        }
    }
    
    return isUTF16Encoded;
}



@end
