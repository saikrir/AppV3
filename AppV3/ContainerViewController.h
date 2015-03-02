//
//  ContainerViewController.h
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationHandler.h"

@interface ContainerViewController : UIViewController


-(instancetype) initWith:(UINavigationController *) leftViewController
                mainViewController:(UINavigationController *)
                mainViewController gap:(NSInteger ) gap;


@end
