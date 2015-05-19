//
//  ViewController.m
//  GetTop10Albums
//
//  Created by Jacky Zou on 11/18/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import "ScheduleTable1ViewController.h"
#import "DetailViewControllerOfSchedule.h"
#import "URLRequest.h"

@interface ScheduleTable1ViewController () <NSXMLParserDelegate>
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
    NSMutableArray *TypeArrayToSent;
    NSMutableArray *PriceToSent;
    NSMutableArray *PictureToSent;
    
    
    NSXMLParser *soapParser1;
    NSString *currentElement1;
    NSMutableString *ElementValue1;
    BOOL errorParsing1;
    NSMutableDictionary *item1;

}

@end

@implementation ScheduleTable1ViewController

BOOL shouldLogin1 = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    
    
    NSString *soapMsg =[NSString stringWithFormat:
                        
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        
                        "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        
                        "<Body>"
                        
                        "<Test2 xmlns=\"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp\">"
                        
                       
                        
                        "</Test2>"
                        
                        "</Body>"
                        
                        "</Envelope>"];

 
    
    NSLog(@"soap: %@",soapMsg);
    //Create the NSURL
    NSURL *url = [NSURL URLWithString:@"http://fmp.rutgersprep.org/websvcmgr.php?wsdl@service=RPSScheduling"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long) [soapMsg length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //Set the SOAP Action
    [theRequest addValue: @"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp/Test2" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //make sure it's a POST
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    
   
    URLRequest *urlRequest = [[URLRequest alloc] initWithRequest:theRequest];
    [urlRequest startWithCompletion:^(URLRequest *request, NSData *data, BOOL success) {
        if (success)
        {
            errorParsing1=NO;
            //create the NSXMLParser and initialize it with the data received
            soapParser1 = [[NSXMLParser alloc] initWithData:data];
            //set the delegate
            [soapParser1 setDelegate:self];
            // You may need to turn some of these on depending on the type of XML file you are parsing
            [soapParser1 setShouldProcessNamespaces:NO];
            [soapParser1 setShouldReportNamespacePrefixes:NO];
            [soapParser1 setShouldResolveExternalEntities:NO];
            [soapParser1 parse];
            NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strData);
            
        }
        else
        {
            NSLog(@"error  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
    
    







    array =[[NSMutableArray alloc]init];
    TypeArrayToSent =[[NSMutableArray alloc]init];
    PriceToSent =[[NSMutableArray alloc]init];
    PictureToSent =[[NSMutableArray alloc]init];
    NSURL *urlitunes = [NSURL URLWithString:@"http://itunes.apple.com/us/rss/topalbums/limit=10/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlitunes];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
    
   
    NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    assert(en_US_POSIX != nil);
    
    // The Date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE, dd"];
    
    NSDate *now = [[NSDate alloc] init];

    NSString *week = [dateFormatter stringFromDate:now];
   

    [dateFormatter setDateFormat:@"dd-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    //    dateFromString = [dateFormatter dateFromString:curDate];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MMM yyyy"];
    NSString *theDate1 = [dateFormat1 stringFromDate:dateFromString];
   

    _YearMonth.text =theDate1;
    _DayLabel.text = week;
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
        DetailViewControllerOfSchedule *detailviewcontroller = [segue destinationViewController];
        
        
        NSIndexPath *myIndexPath = [self.myTableView indexPathForSelectedRow];
        
        NSInteger row = [myIndexPath row];
        detailviewcontroller.DetailModal = @[array[row]];
        detailviewcontroller.DetailModalForType = @[TypeArrayToSent[row]];
        detailviewcontroller.DetailModalForPrice = @[PriceToSent[row]];
        //detailviewcontroller.DetailModalForPicture = @[PictureToSent[row]];
        
      
     
    }
    
    
       
}


#pragma marks delegates
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"***data found and parsing started***");
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"***Parsing Finished***");
}
/*
 This method is called if an error occurs
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %li", (long)[parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    errorParsing1=YES;
}

/*
 When the parser find characters, they are added to your variable "ElementValue".
 
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
 [ElementValue appendString:string];
 NSLog(@"%@", ElementValue);
 
 }
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement1 = [elementName copy];
    ElementValue1 = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"Test2Response"]) {
        item1 = [[NSMutableDictionary alloc] init];
        
    }
    NSLog(@"%@",currentElement1);
}
/*
 When the parser find characters, they are added to your variable "ElementValue".
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [ElementValue1 appendString:string];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender{
    if(shouldLogin1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"Test2Response"]) {
        
      
     
        
        NSLog(@"%@",[NSString stringWithFormat:@"Result: %@", ElementValue1]);
        
        
        
        
    }
    
    
    else
    {
        [item1 setObject:ElementValue1 forKey:elementName];
        
    }
    
}



@end
