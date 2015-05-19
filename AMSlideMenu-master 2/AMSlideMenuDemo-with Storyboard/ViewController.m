//
//  ViewController.m
//  GetTop10Albums
//
//  Created by Jacky Zou on 11/18/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
    NSMutableArray *TypeArrayToSent;
    NSMutableArray *PriceToSent;
    NSMutableArray *PictureToSent;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    array =[[NSMutableArray alloc]init];
    TypeArrayToSent =[[NSMutableArray alloc]init];
    PriceToSent =[[NSMutableArray alloc]init];
    PictureToSent =[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/rss/topalbums/limit=10/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    
    //get Song Name
    for (NSDictionary *diction  in arrayOfEntry) {
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];

        [array addObject:label];
        [[self myTableView]reloadData];
    }
    
    
    
    //Get song type
     for (NSDictionary *diction  in arrayOfEntry) {
    NSDictionary *category = [diction objectForKey:@"category"];
    NSDictionary *attributes = [category objectForKey:@"attributes"];
    NSString *term = [attributes objectForKey:@"label"];
    
         [TypeArrayToSent addObject:term];
     
     }
   
    //get song price
    for (NSDictionary *diction  in arrayOfEntry) {
        NSDictionary *price = [diction objectForKey:@"im:price"];
        
        
        
        NSString *pricelabel = [price objectForKey:@"label"];
       
        
        [PriceToSent addObject:pricelabel];
    
    }
   
    //get song artwork
    for (NSDictionary *diction  in arrayOfEntry) {
        
        
        NSArray *arrayOfImage = [diction objectForKey:@"im"];
        
        for (NSDictionary *pic2 in arrayOfImage) {
        
        NSDictionary *im = [pic2 objectForKey:@"2"];
            
        NSString *picurl = [im objectForKey:@"label"];
            [PictureToSent addObject: picurl];
              NSLog(@"%@", picurl);
        }
      
    }
     
    
    
}


- (IBAction)getData:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/rss/topalbums/limit=100/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
        
        
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
      
    }
      cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"ShowDetails"])
    {
        DetailViewController *detailviewcontroller = [segue destinationViewController];
        
        
        NSIndexPath *myIndexPath = [self.myTableView indexPathForSelectedRow];
        
        NSInteger row = [myIndexPath row];
        detailviewcontroller.DetailModal = @[array[row]];
        detailviewcontroller.DetailModalForType = @[TypeArrayToSent[row]];
        detailviewcontroller.DetailModalForPrice = @[PriceToSent[row]];
        //detailviewcontroller.DetailModalForPicture = @[PictureToSent[row]];
        
      
     
    }
}



@end
