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
    self.containerView.layer.borderColor = [UIColor blackColor].CGColor;
    self.containerView.layer.borderWidth = 0.3f;
    self.containerView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.containerView.layer.shadowRadius = 1.0;
    self.containerView.layer.shadowOpacity = 0.6;
}

-(void) addGradient{
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = self.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:50.0/255.0 green:63.0/255.0 blue:86.0/255.0 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:23.0/255.0 green:26.0/255.0 blue:29.0/255.0 alpha:1.0] CGColor], nil];
    
    [self setBackgroundView:[[UIView alloc] init]];
    [self.backgroundView.layer insertSublayer:grad atIndex:0];
    
    CAGradientLayer *selectedGrad = [CAGradientLayer layer];
    selectedGrad.frame = self.bounds;
    selectedGrad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    
    [self setSelectedBackgroundView:[[UIView alloc] init]];
    [self.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:0];
    [self setNeedsDisplay];
}

-(void)setupCell
{
    [self.containerView setAlpha:1];
    self.containerView.layer.masksToBounds = NO;
    self.containerView.layer.cornerRadius = 1; // if you like rounded corners
    self.containerView.layer.shadowOffset = CGSizeMake(-.2f, .2f); //%%% this shadow will hang slightly down and to the right
    self.containerView.layer.shadowRadius = 1; //%%% I prefer thinner, subtler shadows, but you can play with this
    self.containerView.layer.shadowOpacity = 0.2; //%%% same thing with this, subtle is better for me
    
    //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.containerView.bounds];
    self.containerView.layer.shadowPath = path.CGPath;
    
    //self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% I prefer choosing colors programmatically than on the storyboard
    //self.containerView.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:63.0/255.0 blue:86.0/255.0 alpha:1.0];
}

-(void) showData:(NewsArticle *) newsArticle{
    
    [self setupCell];
    self.thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.thumbnail.layer.borderWidth = 0.3f;

    //[self decorateCell];
    //[self addGradient];
    self.descriptionTxt.text = newsArticle.newsDescription;
    self.headingLbl.text = newsArticle.title;
    self.dateLbl.text = [@"Published on : " stringByAppendingString:[self.dateFormatter stringFromDate:newsArticle.pubDate]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[newsArticle.imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    NSURLSessionDataTask *thumbnailTask = [self.thumbnailSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                self.thumbnail.image = image;
            });
        }
        else{
            NSLog(@"Error Downloading Image %@", error);
        }
    }];
    [thumbnailTask resume];
}


@end
