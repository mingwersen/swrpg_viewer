//
//  WeaponViewController.m
//  SWRPG_Viewer
//
//  Created by matthew ingwersen on 6/13/17.
//  Copyright © 2017 matthew ingwersen. All rights reserved.
//

#import "WeaponViewController.h"
#import "XMLDictionary.h"


@interface WeaponViewController (){
    NSDictionary *xmlWeapons;
    NSMutableArray *listOfItems;
    

}

@end

@implementation WeaponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Weapons" ofType:@"xml"];
    xmlWeapons = [NSDictionary dictionaryWithXMLFile:filePath];
   for(NSString *key in [xmlWeapons allKeys]) {
        NSLog(@"KEY?%@",[xmlWeapons objectForKey:key]);
    }
   
   // [self readDataFromFile];
   // [self loadTableView];
    
    int *count = [xmlWeapons count];
    
    if (count > 0)
    {
        listOfItems = [[NSMutableArray alloc] init]; //Re-init and clear
        
        NSArray *items = [xmlWeapons objectForKey:@"Weapon"];
        //  NSLog(@"weapons: %@", items);
        
        for (NSDictionary * dataDict in items)
        {
            
            NSString *name = [dataDict objectForKey:@"Name"];
            NSString *key = [dataDict objectForKey:@"Key"];
            NSString *description = [dataDict objectForKey:@"Description"];
            NSString *damage = [dataDict objectForKey:@"Damage"];
            NSString *critical = [dataDict objectForKey:@"Crit"];
            NSString *hardPoints = [dataDict objectForKey:@"HP"];
            NSString *price = [dataDict objectForKey:@"Price"];
            NSString *rarity = [dataDict objectForKey:@"Rarity"];
            
            RPGWeapon  *Result = [[RPGWeapon alloc]init];
            
            Result.weaponName = name;
            Result.weaponKey = key;
            Result.weaponDescription = description;
            Result.damage = damage;
            Result.critLevel = critical;
            Result.hardPoints = hardPoints;
            
            
            
            [listOfItems addObject:Result];
            
            [self.tableItems reloadData]; //refresh and loop again
        }
    }
   
    self.tableItems.delegate = self;
    self.tableItems.dataSource = self;
    
    for(UIView *subView in [self.searchBar subviews]) {
        if([subView conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)subView setReturnKeyType: UIReturnKeyDone];
            // always force return key to be enabled
            [(UITextField *)subView setEnablesReturnKeyAutomatically:NO];
        } else {
            for(UIView *subSubView in [subView subviews]) {
                if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                    [(UITextField *)subSubView setReturnKeyType: UIReturnKeyDone];
                    [(UITextField *)subSubView setEnablesReturnKeyAutomatically:NO];
                }
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark UITABLEVIEW

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RPGWeapon *eResult = [listOfItems objectAtIndex:indexPath.row];
    NSLog(@"WEAPON RESULt %@", eResult.weaponName );
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listOfItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 90;
    }else{
        return 90;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"weaponCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    RPGWeapon *e = [listOfItems objectAtIndex:indexPath.row];
    
    UILabel *name = (UILabel *)[cell viewWithTag:100];
    UILabel *description = (UILabel *)[cell viewWithTag:101];
    UILabel *damage = (UILabel *)[cell viewWithTag:102];
    UILabel *key = (UILabel *)[cell viewWithTag:103];
    
    name.text = e.weaponName;
    description.text = e.weaponDescription;
    damage.text = [NSString stringWithFormat:@"Damage: %@", e.damage];
    key.text = e.weaponKey;
    
    NSLog(@"Weapon_Name= %@", e.weaponName);
    
    
    // Fix for iOS 7 to clear backgroundColor
    cell.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    
    [self.tableItems setBackgroundView:nil];
    [self.tableItems setBackgroundColor:[UIColor clearColor]];
    
    return cell;
    
}


#pragma mark SEARCH_DELEGATES
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}



/*
-(void)loadTableView{
   // xmlWeapons = [self JSONFromFile];
    NSInteger *count = [xmlWeapons count];
    
    if (count > 0)
    {
        listOfItems = [[NSMutableArray alloc] init]; //Re-init and clear
        
        NSArray *items = [xmlWeapons objectForKey:@"weapon"];
      //  NSLog(@"weapons: %@", items);
        
        for (NSDictionary * dataDict in items)
        {
            
            NSString *name = [dataDict objectForKey:@"name"];
            NSString *key = [dataDict objectForKey:@"key"];
            NSString *description = [dataDict objectForKey:@"description"];
            NSString *damage = [[dataDict objectForKey:@"damage"]integerValue];
         
            
            RPGWeapon  *Result = [[RPGWeapon alloc]init];
           
            Result.weaponName = name;
            Result.weaponKey = key;
            Result.weaponDescription = description;
            Result.damage = damage;
            
            
            
            [listOfItems addObject:Result];
            
            [self.tableItems reloadData]; //refresh and loop again
        }
    }
    
}
 */

-(void)readDataFromFile
{
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"weapons" ofType:@"json"];
    
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    
    xmlWeapons = [NSJSONSerialization
                                JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                options:0 error:NULL];
}


- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weapons" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


@end
