//
//  Algorithm.m
//  Algorithm
//
//  Created by Keith on 2018/9/19.
//  Copyright © 2018年 keith.lee. All rights reserved.
//

#import "Algorithm.h"

/*@interface BubbleSort()
@end

@interface SelectionSort()
@end

@interface InsertionSort()
@end*/



@implementation BubbleSort
+ (void)sort:(NSMutableArray<NSNumber *> *)input {
    //從頭開始，跟後續的每一個做大小判斷交換，直至走完數組。
    //時間複雜度: O(n^2)
    for (int i = 0; i < input.count; i++) {
        for (int j = i + 1; j < input.count; j++) {
            if (input[j].integerValue > input[i].integerValue) {
                NSNumber *temp = input[j];
                input[j] = input[i];
                input[i] = temp;
            }
        }
        
        
    }
    
    NSLog(@"Bubble Sort:\n%@", input);
}
@end


@implementation SelectionSort
+ (void)sort:(NSMutableArray<NSNumber *> *)input {
    //遍歷數組，取得由第 i 個到尾巴的最大值，置換頭與最大值，持續至尾巴。
    //時間複雜度: O(n^2)
    for (int i = 0; i < input.count; i++) {
        int maxIdx = i;
        for (int j = i + 1; j < input.count; j++) {
            if (input[j].integerValue > input[maxIdx].integerValue) {
                maxIdx = j;
            }
        }
        
        if (maxIdx != i) {
            NSNumber *temp = input[i];
            input[i] = input[maxIdx];
            input[maxIdx] = temp;
        }
    }
    
    NSLog(@"Selection Sort:\n%@", input);
}
@end


@implementation InsertionSort
+ (void)sort:(NSMutableArray<NSNumber *> *)input {
    //以起頭為排序完成的序列，每次向後挪一個。判斷「再下一個」的數值該放在前序列的位置，inplace 挪動排序序列的 idx，然後置放新元素到應該放置的位置(j)
    // 時間複雜度: O(n^2)
    for (int i = 1; i < input.count; i++) {
        int j = i;
        NSNumber *temp = input[j];
        while (j > 0 && temp > input[j - 1]) {
            input[j] = input[j - 1];
            j --;
        }
        
        input[j] = temp;
    }
    
    
    NSLog(@"Insertion Sort:\n%@", input);
}
@end


@implementation Algorithm
+ (void)sort:(NSMutableArray<NSNumber *> *)input withAlg:(Class)alg {
    if ([alg conformsToProtocol:@protocol(SortAlgorithm)]) {
        [alg performSelectorInBackground:@selector(sort:) withObject:input];
    }
}
@end
