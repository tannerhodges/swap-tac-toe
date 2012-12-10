//
//  HomeViewController.m
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

@synthesize beginButton, instructionsButton;

-(void)viewDidLoad {
    [super viewDidLoad];

    // I was going to set this stuff up programmatically, but decided not too... Maybe another day. 
    
    // Create title
    // Create logo image
/*
    // beginButton
    float buttonWidth = beginButton.frame.size.width;
    float buttonHeight = beginButton.frame.size.height;
    float centerX = (self.view.frame.size.width/2)-(buttonWidth/2);
    float centerY = (self.view.frame.size.height/2)-(buttonHeight/2);
    beginButton.frame = CGRectMake(centerX,centerY,buttonWidth,buttonHeight);
*/

//    beginButton.backgroundColor = [UIColor blueColor];
//    [beginButton setTitle:@"Begin" forState:UIControlStateNormal];

    // Create Instructions button
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
