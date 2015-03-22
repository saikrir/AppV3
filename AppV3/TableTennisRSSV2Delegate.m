//
//  TableTennisRSSV2Delegate.m
//  App
//
//  Created by Sai krishna K Rao on 1/2/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisRSSV2Delegate.h"

@implementation TableTennisRSSV2Delegate

- (id)init
{
    self = [super init];
    if (self) {
        self.newsArticles = [[NSMutableArray alloc] init];
        fields = @[@"title",@"guid",@"link",@"description",@"updated", @"enclosure",@"category", @"author", @"pubDate"];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setLenient:YES];
    }
    return self;
}


#pragma mark - NSXMLMarker Delegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:NewItem]){
        currentArticle = [[NewsArticle alloc] init];
    }
    
    if([fields containsObject:elementName]){
        currentElement = elementName;
        elementText = [[NSMutableString alloc] init];
        
        if([elementName isEqualToString:@"enclosure"]){
            currentArticle.imageURL = [attributeDict valueForKey:@"url"];
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    
    if([elementName isEqualToString:NewItem]){
        [self.newsArticles addObject:currentArticle];
    }
    
    if([fields containsObject:elementName]){
        currentElement = elementName;
        
        if([@"guid"isEqualToString:elementName]){
            currentArticle.guid = elementText;
        }
        else if([@"title" isEqualToString:elementName]){
            currentArticle.title = elementText;
        }
        else if ([@"link" isEqualToString:elementName]){
            currentArticle.link = elementText;
        }
        else if ([@"description" isEqualToString:qName] && currentArticle){
            if(!currentArticle.imageURL){
                currentArticle.imageURL = [self imageURL:elementText];
            }
            currentArticle.newsDescription = [self filterHTMLCharacters:elementText];
        }
        else if ([@"updated" isEqualToString:qName]){
            
            if([elementText length] > 0 ){
                [dateFormat  setDateFormat:@"yyyy-MM-dd"];
                NSRange range = [elementText rangeOfString:@"T"];
                if(range.location != NSNotFound){
                    NSRange newRange = {0, range.location};
                    NSString *dateStr = [elementText substringWithRange:newRange];
                    currentArticle.pubDate = [dateFormat dateFromString:dateStr];
                }
            }
            
        }
        else if([@"pubDate" isEqualToString:qName]){
            if([elementText length] > 0 ){
                dateFormat.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
                currentArticle.pubDate = [dateFormat dateFromString:elementText];
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [elementText appendString:string];
}


-(NSString *) filterHTMLCharacters:(NSString *) description{
    NSError *error = nil;

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:description options:0 range:NSMakeRange(0, [description length]) withTemplate:@""];
    modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    return modifiedString;
}

-(NSString *) imageURL:(NSString *) description{
    
    NSString *retURL = @"";
    NSError *error = nil;
    
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"https?://[\\w\\./-]+\\.(jpe?|pn)g" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *match = [regex matchesInString:description options:0 range:NSMakeRange(0, [description length])];
   
    if(match && [match count] > 0 ){
        retURL = [description substringWithRange:[match[0] range]];
    }
    return retURL;
}

@end
