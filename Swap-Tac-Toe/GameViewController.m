//
//  GameViewController.m
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

/*====================================================================*/
    #pragma mark - DEFAULT METHODS
/*====================================================================*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*====================================================================*/
    #pragma mark - ACTIONS
/*====================================================================*/

-(IBAction)buttonWasPushed:(id)sender {
    UIButton *button = [[UIButton alloc] init];
    button = sender;
    
    // Log out the action
    printf("Button %d was pushed.\n", button.tag);
    
    // Change the UILabel text value to current player's symbol
    
    // Increment the current turn / which player's turn it is
    // ^^ Where should this variable be stored? 
}




@end
