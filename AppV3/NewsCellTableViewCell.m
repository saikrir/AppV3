//
//  NewsCellTableViewCell.m
//  AppV3
//
//  Created by Saikrishna Rao on 10/5/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "NewsCellTableViewCell.h"

@interface NewsCellTableViewCell ()

@property (nonatomic,strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic,strong) NSURLSession *thumbnailSession;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation NewsCellTableViewCell

- (void)awakeFromNib {
    _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
     _thumbnailSession = [NSURLSession sessionWithConfiguration:_sessionConfiguration];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MM/dd/yyyy"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) decorateCell{
    self.containerView.layer.borderColor = [UIColor grayColor].CGColor;
    self.containerView.layer.borderWidth = 0.3f;
    self.containerView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.containerView.layer.shadowRadius = 1.0;
    self.containerView.layer.shadowOpacity = 0.6;
}

-(void) showData:(NewsArticle *) newsArticle{
    
    [self decorateCell];
    self.descriptionTxt.text = newsArticle.newsDescription;
    self.headingLbl.text = newsArticle.title;
    self.dateLbl.text = [@"Published on : " stringByAppendingString:[self.dateFormatter stringFromDate:newsArticle.pubDate]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newsArticle.imageURL ]];
    NSURLSessionDataTask *thumbnailTask = [self.thumbnailSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            self.thumbnail.image = image;
        });
    }];
    [thumbnailTask resume];
}


@end
