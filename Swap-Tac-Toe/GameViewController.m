//
//  GameViewController.m
//  Swap-Tac-Toe
//
//  Created by Tanner Hodges on 11/26/12.
//  Copyright (c) 2012 Tanner Hodges. All rights reserved.
//

#import "GameViewController.h"

// Define fancy shortcodes
// #define f(x) [NSNumber numberWithFloat:x]

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Grid parameters
    int gridSize[] = {3, 3};
    int buttonSize = self.view.frame.size.width / 5;
    int padding = 5;
    
    // Dynamic variables for grid size and position
    int totalGridSize = (buttonSize*gridSize[0])+(padding*(gridSize[0]-1));
    float centerX = (self.view.frame.size.width/2)-(totalGridSize/2);
    float centerY = (self.view.frame.size.height/2)-(totalGridSize/2);

/*  // Get a crosshair on that center
    UIButton *temp = [[UIButton alloc] init];
    temp.backgroundColor = [UIColor blueColor];
    temp.frame = CGRectMake(0,(self.view.frame.size.height/2),self.view.frame.size.width,1);
    [self.view addSubview:temp];
*/
    
    // Start 3x3 grid
    int index = 0;
    // Loop through rows
    for(int y=0; y<gridSize[1]; y++) {
        // Set y position
        float newY = centerY + (y * (buttonSize + padding));
        
        // Loop through columns
        for(int x=0; x<gridSize[0]; x++) {
            // Set x position
            float newX = centerX + (x * (buttonSize + padding));

            // Init button
            UIButton *defaultButton = [[UIButton alloc] init];
            // Add action
            [defaultButton addTarget:self action:@selector(buttonWasPushed:) forControlEvents:UIControlEventTouchUpInside];
            // Set background color
            defaultButton.backgroundColor = [UIColor blueColor];
            // Set default text
            defaultButton.titleLabel.text = @"-";
            // Set unique tag id
            defaultButton.tag = index;
            // Set frame
            defaultButton.frame = CGRectMake(newX,newY,buttonSize,buttonSize);
            
//          NSLog(@"%@",NSStringFromCGRect(defaultButton.frame));
            
            // Add to view
            [self.view addSubview:defaultButton];
            
            // Log and reset
            printf("Added button %d to view.\n", x);
            defaultButton = nil;
            index++;
        }
    }
    // Fun debug statement:
    // po [_view recursiveDescription]
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
    // Copy sender into button variable (to please XCode's sassiness)
    UIButton *button = [[UIButton alloc] init];
    button = sender;
    
    // Log the action
    printf("Button %d was pushed.\n", button.tag);
    
    // Change the UILabel text value to current player's symbol
    [sender setTitle:@"X" forState:UIControlStateNormal];
    
    // Increment the current turn / which player's turn it is
    // ^^ Where should this variable be stored? 
}




@end
