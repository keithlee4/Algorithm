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

@implementation QuickSort
+ (void)sort:(NSMutableArray<NSNumber *> *)input {
    [self quicksort:input left:0 right:(int)input.count - 1];
    NSLog(@"Quick Sort:\n%@", input);
}

+ (void)quicksort: (NSMutableArray<NSNumber *> *)input left: (int)left right: (int)right {
    //時間複雜度 O(NlogN)
    //空間複雜度（最糟） O(N) (儲存 i, j, pivot)
    if (left > right) { return; }
    
    NSNumber *pivot = input[left];
    int i, j;
    
    i = left;
    j = right;
    //循環至左右相碰, 產生 O(N) 時間複雜度
    while (i != j) {
        while (input[j].integerValue <= pivot.integerValue && i < j) {
            //嘗試找到第一個右方比 pivot 小的 index
            j --;
        }
        
        while (input[i].integerValue >= pivot.integerValue && i < j) {
            //嘗試找到第一個左方比 pivot 大的 index
            i ++;
        }
        
        if (i < j) {
            //找到一個需要交換的 i, j index
//            NSLog(@"Swap idx %i: %i, %i: %i", i, input[i].integerValue, j, input[j].integerValue);
            NSNumber *temp = input[i];
            input[i] = input[j];
            input[j] = temp;
        }
    }
    
    //將 pivot 置中 (此時 i == j, 必然在中間)
    input[left] = input[i];
    input[i] = pivot;
    
    //從左右分割的數組繼續執行快排
    //產生 O(logN) 時間複雜度
    [self quicksort:input left:left right:i - 1];
    [self quicksort:input left:i + 1 right:right];
}
@end

@implementation HeapSort
+ (void)sort:(NSMutableArray<NSNumber *> *)input {
    int lastParentIdx = [self parentOfIdx:(int)input.count - 1];
    
    //產生 O(n) 時間複雜度，構建堆。
    for (int i = lastParentIdx; i >= 0; i-- ) {
        //從最後一個父結點往回走，大頂堆化每一個子樹
        [self maxHeapify:input startIdx:i maxLength:(int)input.count];
    }
//    NSLog(@"Heap Sort HEAP:\n%@", input);
    //此時已經完成一顆大頂堆樹, 把 root 和最後一個值交換，並且減少 maxLength, 讓 maxHeapify 重新大頂堆化。(會過濾每次丟到尾巴的 root)
    //進行 N - 1 次交換
    for (int j = 1; j < (input.count); j++) {
        //頭和位置[input.count - j](堆的尾巴）交換
        NSNumber *root = input[0];
        input[0] = input[input.count - j];
        input[input.count - j] = root;
        
        //把剩餘的 input.count - j 個元素再大頂堆化
        [self maxHeapify:input startIdx:0 maxLength:(int)input.count - j];
    }
    
    
    NSLog(@"Heap Sort:\n%@", input);
}

+ (void)maxHeapify:(NSMutableArray<NSNumber *> *)input startIdx:(int)idx maxLength:(int)length {
    int idxLeftChild = [self leftChildOfIdx:idx];
    while (idxLeftChild < length) {
        int idxRightChild = [self rightChildOfIdx:idx];
        int maxIdx;
        BOOL hasRightChild = idxRightChild < length;
        //取出左右節點中較大的 idx
        if (hasRightChild && input[idxLeftChild].integerValue < input[idxRightChild].integerValue) {
            maxIdx = idxRightChild;
        }else {
            maxIdx = idxLeftChild;
        }
        
        //如果大數比父結點大
        if (input[maxIdx].integerValue > input[idx].integerValue) {
            //把父節點和大的子節點交換
            NSNumber *temp = input[idx];
            input[idx] = input[maxIdx];
            input[maxIdx] = temp;
            //重定向下一個要判斷的subtree root
            idx = maxIdx;
        }else {
            //父節點最大，跳出循環（因為建立在下方的子數已經是最大堆的前提上）
            break;
        }
        
        //下一個左子節點
        idxLeftChild = [self leftChildOfIdx:idx];
    }
}

+ (int)parentOfIdx: (int) idx {
    return (idx / 2) - 1;
}

+ (int)leftChildOfIdx: (int) idx {
    return (idx * 2) + 1;
}

+ (int)rightChildOfIdx: (int) idx {
    return (idx * 2) + 2;
}

@end


@implementation Algorithm
+ (void)sort:(NSMutableArray<NSNumber *> *)input withAlg:(Class)alg {
    if ([alg conformsToProtocol:@protocol(SortAlgorithm)]) {
        [alg performSelectorInBackground:@selector(sort:) withObject:input];
    }
}
@end
