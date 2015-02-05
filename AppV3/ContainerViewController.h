//
//  ContainerViewController.h
//  AppV3
//
//  Created by Sai krishna K Rao on 2/4/15.
//  Copyright (c) 2015 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController


-(instancetype) initWith:(UIViewController *) leftViewController
                mainViewController:(UIViewController *)
                mainViewController gap:(NSInteger ) gap;


@end
