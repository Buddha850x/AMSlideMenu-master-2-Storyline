//
//  ScheduleTableView.m
//  AMSlideMenu
//
//  Created by Jacky Zou on 11/12/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "ScheduleTableView.h"
#import "URLRequest.h"

@interface ScheduleTableView () <NSXMLParserDelegate>
{
    NSMutableData *webData;
    NSURLConnection *connection;
   
    NSMutableArray *TypeArrayToSent;
    NSMutableArray *PriceToSent;
    NSMutableArray *PictureToSent;
    
    
    NSXMLParser *soapParser1;
    NSString *currentElement1;
    NSMutableString *ElementValue1;
    BOOL errorParsing1;
    NSMutableDictionary *item1;
    
    NSMutableArray *CourseArray;
    NSString *SectionOneNumber;
    NSString *SectionTwoNumber;
    NSString *CourseName;
   
    
}

@end

@implementation ScheduleTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    
     [_cells setBackgroundColor: [UIColor blackColor]];
    
    
    
    
    NSString *soapMsg =[NSString stringWithFormat:
                        
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        
                        "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        
                        "<Body>"
                        
                        "<*** xmlns=\"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp\">"
                        
                        
                        
                        
                        "</***>"
                        
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

    
    //setup the right date today
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger x =8;
    return x;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
   // cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}





//Parse the schedule from XML

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


    


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"CourseNames__CourseShortName"]) {

        NSLog(@"%@",[NSString stringWithFormat:@"Result: %@", ElementValue1]);
        
        
        
        [CourseArray addObject:ElementValue1];
        
       
         NSLog(@"This is the Array of courses: %@", CourseArray);
        
    }
    
    
    else
    {
        [item1 setObject:ElementValue1 forKey:elementName];
        
        
    }
   

    
}






@end
