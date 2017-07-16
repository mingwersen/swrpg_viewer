//
//  WeaponViewController.h
//  SWRPG_Viewer
//
//  Created by matthew ingwersen on 6/13/17.
//  Copyright © 2017 matthew ingwersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGWeapon.h"

@interface WeaponViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) IBOutlet UITableView *tableItems;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *actLoading;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;


@end
