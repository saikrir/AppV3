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
        fields = @[@"title",@"guid",@"link",@"description",@"a10:updated", @"enclosure",@"category", @"a10:author"];
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat  setDateFormat:@"yyyy-MM-dd"];
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
        else if ([@"description" isEqualToString:elementName] && currentArticle){
            currentArticle.newsDescription = [self filterHTMLCharacters:elementText];
        }
        else if ([@"a10:updated" isEqualToString:elementName]){
            
            if([elementText length] > 0 ){
                NSRange range = [elementText rangeOfString:@"T"];
                NSRange newRange = {0, range.location};
                NSString *dateStr = [elementText substringWithRange:newRange];
                currentArticle.pubDate = [dateFormat dateFromString:dateStr];
            }
            
        }
        else if([@"category" isEqualToString:elementName]){
            //NSLog(@"Category TExt %@", elementText);
        }
        else if([@"a10:author" isEqualToString:elementName]){
            //NSLog(@"Author %@", elementText);
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [elementText appendString:string];
}


-(NSString *) filterHTMLCharacters:(NSString *) description{
    NSError *error = nil;

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"style=\".+;\"" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:description options:0 range:NSMakeRange(0, [description length]) withTemplate:@""];
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"</?[a-z ]+/?>" options:NSRegularExpressionCaseInsensitive error:&error];

    modifiedString = [regex stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@""];
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"&[a-z]+;" options:NSRegularExpressionCaseInsensitive error:&error];
    
    modifiedString = [regex stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@""];
    
    return modifiedString;
}

@end
