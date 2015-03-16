//
//  ViewController.m
//  AppV3
//
//  Created by Saikrishna Rao on 9/28/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "NewsArticlesViewController.h"
#import "NewsArticleDelegate.h"
#import "NewsArticleReader.h"
#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"
#import "NewsCellTableViewCell.h"

@interface NewsArticlesViewController ()<NewsArticleDelegate, UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet UITableView *articles;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
    @property (strong, nonatomic) NSMutableArray *articlesList;
@end

@implementation NewsArticlesViewController
//NSString *const url= @"http://www.teamusa.org/USA-Table-Tennis/Features?count=100&rss=1";
//NSString *const url= @"http://www.teamusa.org/News?rss=1";
NSString *const url = @"http://blog.paddlepalace.com/author/steve/feed/";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articlesList = [[NSMutableArray alloc] initWithCapacity:50];
    TableTennisNewsArticleReader *reader= [[TableTennisNewsArticleReader alloc] initWithReaderURL:url];
    reader.newsArticleDelegate =self;
    [reader readNewsArticles];
    self.articles.delegate = self;
    self.articles.dataSource = self;
    [self.articles setAllowsSelection:YES];
    self.articles.separatorColor = [UIColor clearColor];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.activityIndicator startAnimating];
}
#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.articlesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCellTableViewCell *newsCell = [tableView dequeueReusableCellWithIdentifier:@"newsArticleCell"];
    NewsArticle *newsArticle = self.articlesList[indexPath.row];
    [newsCell showData:newsArticle];
    return newsCell;
}

- (IBAction)handleMenuToggle:(id)sender {
    if([self.menuDelegate respondsToSelector:@selector(didTapMenuButton:)]){
       [self.menuDelegate didTapMenuButton:self];   
    }
}



#pragma mark - Data Delegate Methods

-(void) didRecieveNewsArticle:(NSArray *) newsArticles andError:(NSError *) error{
    
    if(!error)
    {
        [self.articlesList addObjectsFromArray:newsArticles];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.articles reloadData];
            [self.activityIndicator stopAnimating];
        });
    }
    else{
        
        NSLog(@"Failed to Retrieve %@", error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Table Tennis News"
                                                            message:@"Failed to retrieve news Articles"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil,
                                  nil];
        [alertView show];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
