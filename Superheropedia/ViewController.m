//
//  ViewController.m
//  Superheropedia
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *superheroArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Array of NSDictionaries
//    self.superheroArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Batman",@"name",@"28",@"age", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Ironman",@"name",@"34",@"age", nil], nil];
    //first string we write is the object, second is the key. For third and forth we repeat the same order.

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        self.superheroArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        [self.tableView reloadData];

    }]; //we are making a call to the internet so we are using AsynchronousRequest instead of SynchronousRequest.


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    NSDictionary *dictionary = [self.superheroArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:@"name"]; //calls the object connected to this key("name")
    cell.detailTextLabel.text = [dictionary objectForKey:@"description"]; //we changed the key because its given as "description" on JSON website.
    cell.detailTextLabel.numberOfLines = 0;
    NSURL *url = [NSURL URLWithString:[dictionary objectForKey:@"avatar_url"]];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.superheroArray.count;
}


@end
