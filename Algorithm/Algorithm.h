//
//  Algorithm.h
//  Algorithm
//
//  Created by Keith on 2018/9/19.
//  Copyright © 2018年 keith.lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SortAlgorithm
+ (void)sort: (NSMutableArray<NSNumber *> *) input;
@end

@interface BubbleSort: NSObject<SortAlgorithm>
@end

@interface SelectionSort: NSObject<SortAlgorithm>
@end

@interface InsertionSort: NSObject<SortAlgorithm>
@end

@interface QuickSort: NSObject<SortAlgorithm>
@end

@interface HeapSort: NSObject<SortAlgorithm>
@end

@interface Algorithm : NSObject
+ (void)sort: (NSMutableArray<NSNumber *> *) input withAlg: (Class) alg;
@end
