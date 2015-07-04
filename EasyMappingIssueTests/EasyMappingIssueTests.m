//
//  EasyMappingIssueTests.m
//  EasyMappingIssueTests
//
//  Created by Tsyganov Stanislav on 30/06/15.
//  Copyright (c) 2015 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <MagicalRecord/MagicalRecord.h>

#import "RDNServerResponseMapper.h"
#import "RDNCluster.h"

@interface EasyMappingIssueTests : XCTestCase

@property (nonatomic, strong) RDNServerResponseMapper *clusterIdsMapper;
@property (nonatomic, strong) NSDictionary *regularServerResponse;

@end

@implementation EasyMappingIssueTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setDefaultModelFromClass:[self class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"badJson" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    self.regularServerResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.clusterIdsMapper = [RDNServerResponseMapper new];
}

- (void)tearDown {
    self.regularServerResponse = nil;
    self.clusterIdsMapper = nil;
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testFeedMapperStrongParentChildClustersRelations {
    // given
    NSInteger expectedCountOfRootClusters = 10;
    
    // when
    [self.clusterIdsMapper mapServerResponse:self.regularServerResponse];
    NSArray *cachedClustersArray = [RDNCluster MR_findAllSortedBy:@"clusterId" ascending:YES];
    
    NSLog(@"%@", cachedClustersArray);
    
    // then
    NSMutableSet *clusterIdsSet = [NSMutableSet new];
    NSInteger currentNumberOfRootClusters = 0;
    for (RDNCluster *cluster in cachedClustersArray) {
        XCTAssertFalse([clusterIdsSet containsObject:cluster.clusterId], @"Cluster %@ duplicated", cluster.clusterId);
        [clusterIdsSet addObject:cluster.clusterId];
        if (cluster.childClusters.count > 0) {
            currentNumberOfRootClusters++;
        }
    }
    XCTAssertEqual(expectedCountOfRootClusters, currentNumberOfRootClusters, @"Wrong number of parent clusters");
}

@end
