//
//  GameViewController.h
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

// Properties
@property (nonatomic, strong) NSMutableArray *gridValues;

@property (nonatomic, strong) IBOutlet UILabel *statusLabel;

// Methods
-(void)initGridArray;
-(void)setupGrid;

// Actions
-(IBAction)buttonWasPushed:(id)sender;
-(IBAction)newGameButtonWasPushed:(id)sender;

@end
