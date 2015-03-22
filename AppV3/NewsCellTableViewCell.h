//
//  NewsCellTableViewCell.h
//  AppV3
//
//  Created by Saikrishna Rao on 10/5/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticle.h"

@interface NewsCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *headingLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTxt;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) NewsArticle *newsArticle;

-(void) showData:(NewsArticle *) newsArticle;
@end
