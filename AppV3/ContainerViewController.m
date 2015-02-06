//
//  ContainerViewController.m
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

    @property (nonatomic,weak) UIViewController *leftViewController;
    @property (nonatomic,weak) UIViewController *mainViewController;
    @property (nonatomic,strong) UIScrollView *scrollView;
    @property (nonatomic,assign) NSInteger gap;

@end

@implementation ContainerViewController

-(instancetype) initWith:(UIViewController *) leftViewController
      mainViewController:(UIViewController *)  mainViewController
                     gap:(NSInteger ) gap{
    
    self = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        self.mainViewController = mainViewController;
        self.gap = gap;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.scrollView];
    
    NSDictionary *views= @{@"scrollView":self.scrollView};
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:0 views:views];
    [self.view addConstraints:hConstraints];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:0 views:views];
    [self.view addConstraints:vConstraints];

    
    [self addSubViews];
    [self setupConstraints];
    
    self.scrollView.pagingEnabled = YES;
}

-(void) addSubViews{
    self.leftViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.leftViewController.view];
    [self addChildViewController:self.leftViewController];
    [self.leftViewController didMoveToParentViewController:self];
    
    self.mainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.mainViewController.view];
    [self addChildViewController:self.mainViewController];
    [self.mainViewController didMoveToParentViewController:self];
}

-(void) viewDidLayoutSubviews{
    CGFloat x = (self.view.bounds.size.width - self.gap);
    CGPoint offset = CGPointMake(x, self.scrollView.contentOffset.y);
    
    [self.scrollView setContentOffset:offset animated:NO];

}

-(void) setupConstraints{
    
    NSDictionary *viewsDefs = @{ @"containerView":self.view , @"leftNav": self.leftViewController.view , @"mainView": self.mainViewController.view };
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[leftNav][mainView(==containerView)]|" options:0 metrics:0 views:viewsDefs];
    [self.view addConstraints:hConstraints];
    
    NSLayoutConstraint *leftNavHConstraints = [NSLayoutConstraint constraintWithItem:self.leftViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant: -self.gap];
    
    [self.view addConstraint:leftNavHConstraints];
    
    NSArray *leftNavVContstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftNav(==containerView)]|" options:0 metrics:0 views:viewsDefs];
    [self.view addConstraints:leftNavVContstraints];
    
    NSArray *mainVwVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView(==containerView)]|" options:0 metrics:0 views:viewsDefs];
    [self.view addConstraints:mainVwVConstraints];
    
}



@end
