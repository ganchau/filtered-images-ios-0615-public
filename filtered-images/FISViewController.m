//
//  FISViewController.m
//  filtered-images
//
//  Created by Joe Burgess on 7/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import "UIImage+Filters.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface FISViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *uunfilteredImage;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self unFilterImage];
    
}

- (IBAction)noFilterTapped:(id)sender
{
    [self unFilterImage];
}

- (void)unFilterImage
{
    UIImage *nonFiltered = [UIImage imageNamed:@"Mickey.jpg"];
    self.imageView.image = nonFiltered;
}

- (void)filterImageWithFilter:(UIImageFilterType)filterType
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *nonFiltered = [UIImage imageNamed:@"Mickey.jpg"];
        UIImage *filtered = [nonFiltered imageWithFilter:filterType];
        
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        [mainQueue addOperationWithBlock:^{
            self.imageView.image = filtered;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }];
    
    [operationQueue addOperation:blockOperation];
}

- (IBAction)vignetterTapped:(id)sender
{
    [self filterImageWithFilter:UIImageFilterTypeVignette];
}

- (IBAction)sephiaFilterTapped:(id)sender
{
    [self filterImageWithFilter:UIImageFilterTypeSepia];
}

- (IBAction)invertedFilterTapped:(id)sender
{
    [self filterImageWithFilter:UIImageFilterTypeColorInvert];
}
@end
