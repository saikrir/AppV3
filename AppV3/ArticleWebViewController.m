//
//  ArticleWebViewController.m
//  AppV3
//
//  Created by Sai krishna K Rao on 3/21/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import "ArticleWebViewController.h"

@interface ArticleWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Article";
    NSString *urlStr = self.newsArticle.guid;
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"\n\t\t" withString:@""];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:req];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ", (int)webView.frame.size.width]];
}

@end
