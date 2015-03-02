//
//  NewArticleWebViewController.m
//  AppV3
//
//  Created by Saikrishna Rao on 10/13/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "NewArticleWebViewController.h"

@interface NewArticleWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NewArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURL *urlToLoad = [NSURL URLWithString:self.newsarticle.link];
    //NSURL *urlToLoad = [NSURL URLWithString:@"http://google.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:urlToLoad]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
