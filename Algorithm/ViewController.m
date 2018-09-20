//
//  ViewController.m
//  Algorithm
//
//  Created by Keith on 2018/9/19.
//  Copyright © 2018年 keith.lee. All rights reserved.
//

#import "ViewController.h"
#import "Algorithm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray<NSNumber *> *unsortedNums = [NSArray arrayWithObjects:@8, @5, @7, @4, @9, @2, @6, @1, @3, nil];
    [Algorithm sort:[unsortedNums mutableCopy] withAlg:[BubbleSort class]];
    [Algorithm sort:[unsortedNums mutableCopy] withAlg:[SelectionSort class]];
    [Algorithm sort:[unsortedNums mutableCopy] withAlg:[InsertionSort class]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
