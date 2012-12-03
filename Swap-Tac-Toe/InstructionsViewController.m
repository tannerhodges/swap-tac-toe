//
//  InstructionsViewController.m
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import "InstructionsViewController.h"

@implementation InstructionsViewController

// Synthesize properties
@synthesize instructions;

/*====================================================================
    Yep... view did load... stuff.
  ====================================================================*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the current screen size
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenSize.size.width;
    CGFloat screenHeight = screenSize.size.height;
    
    // Set the size of the instructions label
    instructions.frame = CGRectMake(0, 0, screenWidth-10, screenHeight-10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
