//
//  ContainerViewController.m
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController () <MenuToggleDelegate,NavigationHandler>

    @property (nonatomic,weak) UINavigationController *leftViewController;
    @property (nonatomic,weak) UINavigationController *mainViewController;
    @property (nonatomic,strong) UIScrollView *scrollView;
    @property (nonatomic,strong) NSDictionary *viewIndexes;
    @property (nonatomic,assign) NSInteger gap;
    @property (assign) BOOL firstTime;
    @property (assign) NSUInteger loadedViewControllerIndex;

@end

@implementation ContainerViewController

-(instancetype) initWith:(UINavigationController *) leftViewController
      mainViewController:(UINavigationController *)  mainViewController
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
    [self populateViewIndexes];
    
    self.scrollView.pagingEnabled = YES;
    self.firstTime = YES;
    self.loadedViewControllerIndex = 0;
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
    [self closeMenu];
}

-(void) openMenu{
    CGPoint offset = CGPointMake(0, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:offset animated:YES];
}


-(void) closeMenu{
    CGFloat x = (self.view.bounds.size.width - self.gap);
    CGPoint offset = CGPointMake(x, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:offset animated: !self.firstTime];
    self.firstTime = NO;
}

-(BOOL) isMenuOpen{
    CGPoint scrollviewOffset = self.scrollView.contentOffset;
    return (scrollviewOffset.x == 0);
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

-(void) populateViewIndexes{
    self.viewIndexes = @{
                         @0 : @"newsArticlesViewController",
                         @1: @"playerSearchViewController"
                        };
}

- (void)didTapMenuButton:(UIViewController *)controller{
    self.isMenuOpen? [self closeMenu]: [self openMenu];
}

-(void) handleNavigation:(id) sender{
    
    UIButton *button = (UIButton *) sender;
    if(self.loadedViewControllerIndex == button.tag) return;
    
    UIViewController *viewController = [self viewControllerFor: button.tag];
    if(viewController){
        [self.mainViewController setViewControllers:@[viewController] animated:YES];
        self.loadedViewControllerIndex = button.tag;
    }
    
}

-(UIViewController *) viewControllerFor:(NSUInteger) viewIndex{
    NSString *storyboardId = self.viewIndexes[@(viewIndex)];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [mainStoryBoard instantiateViewControllerWithIdentifier:storyboardId];
}

@end
