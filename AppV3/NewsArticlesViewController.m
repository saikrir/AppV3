//
//  ViewController.m
//  AppV3
//
//  Created by Saikrishna Rao on 9/28/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "NewsArticlesViewController.h"
#import "TableTennisInformationServiceDelegate.h"
#import "TableTennisInformationService.h"
#import "TTTournament.h"
#import "NewsArticleDelegate.h"
#import "NewsArticleReader.h"
#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"

@interface NewsArticlesViewController ()<TableTennisInformationServiceDelegate,NewsArticleDelegate>
@end

@implementation NewsArticlesViewController
NSString *const url= @"http://www.teamusa.org/USA-Table-Tennis/Features?count=100&rss=";


- (void)viewDidLoad {
    [super viewDidLoad];
    TableTennisInformationService *ttSvc = [[TableTennisInformationService alloc] init];
    ttSvc.dataDelegate = self;
    //[ttSvc getLatestTornaments];
    TableTennisNewsArticleReader *reader= [[TableTennisNewsArticleReader alloc] initWithReaderURL:url];
    reader.newsArticleDelegate =self;
    [reader readNewsArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRecieveTableTennisTournamentInformation:(NSArray *) data  andError:(NSError  *) error{
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TTTournament *tournament = (TTTournament *)obj;
        NSLog(@"Tournament %@ ", tournament.tournmentName);
    }];
}

-(void) didRecieveNewsArticle:(NSArray *) newsArticles andError:(NSError *) error{
    [newsArticles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NewsArticle *newsArticle = (NewsArticle *) obj;
        NSLog(@"News Article %@", newsArticle.title);
    }];
}

@end
