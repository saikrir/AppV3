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

@end

@implementation NewsCellTableViewCell

- (void)awakeFromNib {
    
    _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
     _thumbnailSession = [NSURLSession sessionWithConfiguration:_sessionConfiguration];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void) showData:(NewsArticle *) newsArticle{
    self.descriptionTxt.text = newsArticle.newsDescription;
    self.headingLbl.text = newsArticle.title;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newsArticle.imageURL ]];
    NSURLSessionDataTask *thumbnailTask = [self.thumbnailSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            self.thumbnail.image = image;
        });
    }];
    [thumbnailTask resume];
}


-(void) showThumbnailImage{
    
    
}

@end
