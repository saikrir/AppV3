//
//  TableTennisInformationService.m
//  App
//
//  Created by Sai krishna K Rao on 1/24/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "TableTennisInformationService.h"
#import "TTTournament.h"
#import "TTPlayer.h"

@interface TableTennisInformationService()

@property (nonatomic,strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic,strong) NSURLSession *urlSession;

@end

@implementation TableTennisInformationService


- (id)init
{
    self = [super init];
    if (self) {
        self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    }
    return self;
}


-(void) getLatestTornaments
{
    NSURL *url = [NSURL URLWithString:@"http://usatt.net/history/rating/History/AllTourn.asp?Year=14"];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    
    NSMutableArray *tournaments= [[NSMutableArray alloc] init];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:urlReq
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        TFHpple *ttTournamentsParser = [TFHpple hppleWithHTMLData:data];
        NSArray *tournamentNodes = [ttTournamentsParser searchWithXPathQuery:@"//table/tr"];

        [tournamentNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(idx!= 0){
                TFHppleElement *trElement = (TFHppleElement *) obj;
                NSArray *tdElements = [trElement children];
                TTTournament *tournment = [[TTTournament alloc] init];
                
                [tdElements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                   TFHppleElement *tdElement = (TFHppleElement *) obj;
                    if([[tdElement tagName] isEqualToString:@"td"])
                    {
                        if([tdElement hasChildren] && ![@"text" isEqualToString:[tdElement firstChild].tagName]){
                            tournment.tournmentName = tdElement.firstChild.text;
                        }
                        else{
                            
                            if(idx!= 0 && (idx%2 ==0)){
                                switch (idx) {
                                    case 2:
                                        tournment.date = tdElement.text;
                                        break;
                                    case 4:
                                        tournment.state = tdElement.text;
                                        break;
                                    case 6:
                                        tournment.players = tdElement.text;
                                        break;
                                    case 8:
                                        tournment.matches = tdElement.text;
                                        break;
                                    case 10:
                                        tournment.stars = tdElement.text;
                                        break;
                                    
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                }];
                
                [tournaments addObject:tournment];
            }
        }];
        
       [self.dataDelegate didRecieveTableTennisTournamentInformation:tournaments andError:error];
                                                       
    }];
    
    [dataTask resume];
}

-(void) searchPlayer:(NSString *) playerName{
    
    NSString *urlString = [NSString stringWithFormat:@"http://usatt.net/history/rating/History/Allplayers.asp?NSearch=%@&Submit=Go", playerName ];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    NSMutableArray *players = [[NSMutableArray alloc] init];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:urlReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        TFHpple *ttTournamentsParser = [TFHpple hppleWithHTMLData:data];
        NSArray *playerNodes = [ttTournamentsParser searchWithXPathQuery:@"//table/tr"];
        
        
        
        [playerNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(idx!= 0){
                TFHppleElement *trElement = (TFHppleElement *) obj;
                NSArray *tdElements = [trElement children];
                TTPlayer *player = [[TTPlayer alloc] init];
                
                [tdElements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    TFHppleElement *tdElement = (TFHppleElement *) obj;
                    if([[tdElement tagName] isEqualToString:@"td"])
                    {
                        if([tdElement hasChildren] && ![@"text" isEqualToString:[tdElement firstChild].tagName]){
                            if(idx == 5){
                                player.name = [tdElement.firstChild.text stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                            }
                            else{
                                player.lastPlay = [tdElement.firstChild.text stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                            }
                        }
                        else{
                            
                            if(idx!= 6 && (idx%2 ==1)){
                                NSString *text = [tdElement.text stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                                switch (idx) {
                                    case 1:
                                        player.memberId = text;
                                        break;
                                    case 3:
                                        player.expDate= text;
                                        break;
                                    case 7:
                                        player.rating = text;
                                        break;
                                    case 9:
                                        player.state = text;
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                }];
                
                [players addObject:player];
            }
        }];
        [self.dataDelegate didRecieveTableTennisPlayerformation:players andError:error];
    }];
    
    [dataTask resume];
}


-(void) top20Player:(NSString *) year{
    
    NSString *urlString = [NSString stringWithFormat:@"http://usatt.net/history/rating/History/TopTen.asp?cbxYear=%@", year ];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    NSMutableArray *topPlayers = [[NSMutableArray alloc] init];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:urlReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        TFHpple *ttTournamentsParser = [TFHpple hppleWithHTMLData:data];
        NSArray *playerNodes = [ttTournamentsParser searchWithXPathQuery:@"//table/tr[1]/td/table[1]/tr"];
        
        
        
        [playerNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(idx > 1 ){
                TFHppleElement *trElement = (TFHppleElement *) obj;
                NSArray *tdElements = [trElement children];
                TTPlayer *player = [[TTPlayer alloc] init];
                
                [tdElements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    TFHppleElement *tdElement = (TFHppleElement *) obj;
                    if([[tdElement tagName] isEqualToString:@"td"])
                    {
                        if([tdElement hasChildren] && ![@"text" isEqualToString:[tdElement firstChild].tagName]){
                        if(idx == 3)
                            player.name = tdElement.firstChild.text;
                        }
                        else{
                            
                                switch (idx) {
                                    case 1:
                                        player.rank = tdElement.text;
                                        break;
                                    case 5:
                                        player.wins = tdElement.text;
                                        break;
                                    case 7:
                                        player.toralPlayed= tdElement.text;
                                        break;
                                    default:
                                        break;
                                }
                        }
                    }
                }];
                
                [topPlayers addObject:player];
            }
        }];
        [self.dataDelegate didRecieveTop20TableTennisPlayersformation:topPlayers andError:error];
    }];
    
    [dataTask resume];
}

@end
