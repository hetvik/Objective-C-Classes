//
//  EntryDetailsVC.m
//  InterestCalculator
//
//  Created by Bhavik Talpada on 04/03/19.
//  Copyright © 2019 Bhavik Talpada. All rights reserved.
//

#import "EntryDetailsVC.h"
#import "Util.h"
#import "InterestCalculator-Swift.h"
#import "PDSearchHUD.h"

@interface EntryDetailsVC (){
    
}
@property(nonatomic, strong) NSArray *items;

@end

@implementation EntryDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [herderView diognalView];
    
    //_countryLabel.text = @"Tap on Show List";
    
    _items = @[@"Brazil", @"China",
               @"France", @"Germany",
               @"India", @"Japan",
               @"Nigeria", @"Russia",
               @"United States", @"United Kingdom"];
    self.view.backgroundColor = [UIColor redColor];
    
}

- (IBAction)showMenu:(id)sender {

    PDSearchHUD *searchHUD = [[PDSearchHUD alloc] initWithSearchList:self.items andDelegate:self];
    [searchHUD setDismissWhenRowSelected:YES];
    [searchHUD setSearchType:PDSearchTypeContains];
    //Uncomment the following line to pre fill the search bar with some text, like the last selection
    //searchHUD.searchBar.text = @"India";
    [searchHUD addToSuperView:self.view withInsets:PDSEARCHHUD_DEFAULT_INSETS];
    
}


#pragma mark -
#pragma mark SearchHUD

- (void)didSelectRowAtIndex:(NSUInteger)index {
    NSLog(@"Index of Tapped item : %lu", (unsigned long) index);
    //_countryLabel.text = (self.items)[index];
}

- (void)didSelectItem:(NSString *)item {
    NSLog(@"Selected Item %@", item);
    //_countryLabel.text = item;
}

@end


