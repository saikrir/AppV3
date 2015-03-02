//
//  LeftNavViewController.h
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationHandler.h"

@interface LeftNavViewController : UIViewController

@property (nonatomic,weak) id<NavigationHandler> navigationDelegate;

@end
