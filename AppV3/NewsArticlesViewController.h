//
//  ViewController.h
//  AppV3
//
//  Created by Saikrishna Rao on 9/28/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationHandler.h"


@interface NewsArticlesViewController : UIViewController

@property (nonatomic,weak) id<MenuToggleDelegate> menuDelegate;

@end

