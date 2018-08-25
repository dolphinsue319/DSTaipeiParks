//
//  DSURLSessionManager.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSURLSessionManager.h"
#import "NSDictionary+DSCategory.h"
#import "DSPark.h"

@implementation DSURLSessionManager

- (NSURLSessionDataTask *)fetchParksWithOffset:(NSUInteger)offset completion:(void (^)(NSArray <DSPark *> *parks, NSUInteger totalOfParks, NSError *error))callback
{
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    NSURL* URL = [NSURL URLWithString:@"https://data.taipei/opendata/datalist/apiAccess"];
    NSDictionary* URLParams = @{
                                @"scope": @"resourceAquire",
                                @"rid": @"bf073841-c734-49bf-a97f-3757a6013812",
                                @"limit": @"30",
                                @"offset": [NSString stringWithFormat:@"%li", offset],
                                @"sort": @"_id",
                                };
    URL = NSURLByAppendingQueryParameters(URL, URLParams);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            if (((NSHTTPURLResponse *)response).statusCode != 200) {
                callback(nil, 0, [NSError errorWithDomain:@"DSError" code:((NSHTTPURLResponse *)response).statusCode userInfo:nil]);
                return;
            }
            
            NSError *jsonError;
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (jsonError) {
                callback(nil, 0, jsonError);
                return;
            }
            
            if (![object isKindOfClass:[NSDictionary class]]) {
                callback(nil, 0, [NSError errorWithDomain:@"DSError" code:999 userInfo:nil]);
                return;
            }
            
            NSDictionary *dict = (NSDictionary *)object;
            NSArray *parksArray = (NSArray *)[dict valueForKeyPath:@"result.results"];
            NSMutableArray *parks = [NSMutableArray array];
            for (NSDictionary *parkDict in parksArray) {
                DSPark *park = [[DSPark alloc] initWithDictionary:parkDict];
                if (park) {
                    [parks addObject:park];
                }
            }
            NSUInteger totalOfParks = ((NSNumber *)[dict valueForKeyPath:@"result.count"]).unsignedIntegerValue;
            callback(parks, totalOfParks, nil);
        }
        else {
            callback(nil, 0, error);
        }
    }];
    [task resume];
    [session finishTasksAndInvalidate];
    return task;
}

static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if (!encodedKey) {
            encodedKey = @"";
        }
        NSString *encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if (!encodedValue) {
            encodedValue = @"";
        }
        NSString *part = [NSString stringWithFormat: @"%@=%@",encodedKey,encodedValue];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)
                           ];
    return [NSURL URLWithString:URLString];
}



@end
