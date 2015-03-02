//
//  LeftNavViewController.m
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import "LeftNavViewController.h"

@interface LeftNavViewController ()

@end

@implementation LeftNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadNewsArticles:(id)sender {
    [self handleNavigation: sender];
}

- (IBAction)loadPlayerSearch:(id)sender {
    [self handleNavigation: sender];
}

- (IBAction)loadRatings:(id)sender {
}

- (IBAction)loadClubs:(id)sender {
}


- (IBAction)loadMerchendise:(id)sender {
}

-(void) handleNavigation:(id) sender{
    if([self.navigationDelegate respondsToSelector:@selector(handleNavigation:)]){
        [self.navigationDelegate handleNavigation:sender];
    }
}

@end
