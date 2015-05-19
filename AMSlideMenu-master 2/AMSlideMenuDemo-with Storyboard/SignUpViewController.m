//
//  YDViewController.m
//  SecureSOAP
//  This file is part of source code lessons that are related to the book
//  Title: Professional IOS Programming
//  Publisher: John Wiley & Sons Inc
//  ISBN 978-1-118-66113-0
//  Author: Peter van de Put
//  Company: YourDeveloper Mobile Solutions
//  Contact the author: www.yourdeveloper.net | info@yourdeveloper.net
//  Copyright (c) 2013 with the author and publisher. All rights reserved.
//

#import "SignUpViewController.h"
#import "ScheduleTable1ViewController.h"
#import "URLRequest.h"
#import "LoginViewController.h"
@interface SignUpViewController ()<NSXMLParserDelegate>
{
    NSXMLParser *soapParser;
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;
    NSMutableDictionary *item;
    
    NSMutableString *ElementValue1;
    NSMutableDictionary *item1;
    NSString *lastName;
    NSString *fullName;
    
}

@end

@implementation SignUpViewController

BOOL shouldLoginFlag = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)ExitButton:(id)sender
{
    shouldLoginFlag = YES;
       [self performSegueWithIdentifier:@"Exit" sender:self];
}

-(IBAction)SignUpButton:(id)sender
{
    shouldLoginFlag= NO;
    
    if (([self.username.text length] == 0) ||([self.password.text length] == 0)||([self.studentID.text length] == 0) )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a username and a password and a student ID" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else{
    //make sure the keyboard will be gone
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.studentID resignFirstResponder];
   
   NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"%@",uniqueIdentifier);
    //Construct the soapMessasge
    
    NSString *soapMsg =[NSString stringWithFormat:
                        
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        
                        "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        
                        "<Body>"
                        
                        "<SetUp xmlns=\"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp\">"
                        
                        "<UserName>%@</UserName>"
                        
                        "<Password>%@</Password>"
                        
                        "<StudentID>%@</StudentID>"
                        
                        "<DeviceID>%@</DeviceID>"
                        
                        "</SetUp>"
                        
                        "</Body>"
                        
                        "</Envelope>",self.username.text,self.password.text,self.studentID.text,uniqueIdentifier];
    
    NSLog(@"soap: %@",soapMsg);
    //Create the NSURL
    NSURL *url = [NSURL URLWithString:@"http://fmp.rutgersprep.org/websvcmgr.php?wsdl@service=RPSScheduling"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long) [soapMsg length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //Set the SOAP Action
    [theRequest addValue: @"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp/SetUp" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //make sure it's a POST
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    URLRequest *urlRequest = [[URLRequest alloc] initWithRequest:theRequest];
    [urlRequest startWithCompletion:^(URLRequest *request, NSData *data, BOOL success) {
        if (success)
        {
            errorParsing=NO;
            //create the NSXMLParser and initialize it with the data received
            soapParser = [[NSXMLParser alloc] initWithData:data];
            //set the delegate
            [soapParser setDelegate:self];
            // You may need to turn some of these on depending on the type of XML file you are parsing
            [soapParser setShouldProcessNamespaces:NO];
            [soapParser setShouldReportNamespacePrefixes:NO];
            [soapParser setShouldResolveExternalEntities:NO];
            [soapParser parse];
            NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strData);
            
                   }
        else
        {
            NSLog(@"error  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
       

    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"successSignUp"])
    {
        // Get reference to the destination view controller
        //SignUpViewController *scheduletableview = [segue destinationViewController];
        
     }
    
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) { // UIAlertView with tag 1 detected
        if (buttonIndex == 0)
        {
            NSLog(@"user pressed Button Indexed 0");
            // Any action can be performed here
     
           // [self performSegueWithIdentifier:@"successSignUp" sender:self];
            
            
        }
        else
        {
            NSLog(@"user pressed Button Indexed 1");
            // Any action can be performed here
            
            
        }
    
    

    }
}



//GetProtectedDataResult
#pragma delegates
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"data found and parsing started");
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
    errorParsing=YES;
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender{
    if(shouldLoginFlag)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
    
}
/*
 The XML parser contains three methods, one that runs at the beginning of an individual element,
 one that runs during the middle of parsing the element,
 and one that runs at the end of the element.
 
 For this example, we'll be parsing an RSS feed that break down elements into groups under the heading of "items".
 At the start of the processing, we are checking for the element name "item" and allocating our item dictionary when a new group is detected.
 Otherwise, we initialize our variable for the value.
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement = [elementName copy];
    ElementValue = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"Name_First"]) {
        item = [[NSMutableDictionary alloc] init];
        
    }
    NSLog(@"%@",currentElement);
    
}
/*
 When the parser find characters, they are added to your variable "ElementValue".
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [ElementValue appendString:string];
}
/*
 If the endelement for the item is found the item is copied and added to the articles array
 Also the tableview is reloaded here
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if ([elementName isEqualToString:@"AllSchoolDemographics__Name_Last"])
    {
       
        
        NSLog(@"%@",[NSString stringWithFormat:@"Result: %@", ElementValue]);
        lastName = ElementValue;
        
            long nameLength = (unsigned long)[lastName length];
        NSLog(@"%@",[NSString stringWithFormat:@"Length: %ld", nameLength]);
        if (nameLength > 0)
        {
            //success
            shouldLoginFlag=true;
            [self performSegueWithIdentifier:@"successSignUp" sender:self];
            
             NSString *username = self.username.text;
             NSString *password = self.password.text;
             NSString *studentID = self.studentID.text;
        
         
            
       /*     // get path to Documents/somefile.txt
           NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Userinfo.txt"];
            
            // create if needed
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                [[NSData data] writeToFile:filePath atomically:YES];
            }
            
            // append
            NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            [handle truncateFileAtOffset:[handle seekToEndOfFile]];
            [handle writeData:[@"%@/n",[NSString stringWithFormat:@"Username:", username] dataUsingEncoding:NSUTF8StringEncoding]];
            [handle writeData:[@"%@",[NSString stringWithFormat:@"password:", password] dataUsingEncoding:NSUTF8StringEncoding]];
            [handle writeData:[@"%@",[NSString stringWithFormat:@"studentID:", studentID] dataUsingEncoding:NSUTF8StringEncoding]];
            */
            
            
           // NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            
           
            
            NSString *directory = NSHomeDirectory();
            NSString *fileName = @"username.txt";
            NSString *fileName1 = @"password.txt";
            NSString *fileName2 = @"studentID.txt";
            NSString *filePath =   [directory stringByAppendingPathComponent:fileName];
            NSString *filePath1 =  [directory stringByAppendingPathComponent:fileName1];
            NSString *filePath2 =  [directory stringByAppendingPathComponent:fileName2];
            //NSLog(@"%@",filePath);
            [username writeToFile:filePath atomically:YES encoding:NSASCIIStringEncoding error:nil];
            [password writeToFile:filePath1 atomically:YES encoding:NSASCIIStringEncoding error:nil];
            [studentID writeToFile:filePath2 atomically:YES encoding:NSASCIIStringEncoding error:nil];
            
            
                [self readFile];
            
        }
        else{
            shouldLoginFlag = false;
            //no matching record
             NSLog(@"no matching record");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SignUp Failure" message:@"You do not belong to this school!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }

        
    }
    
    else {
        [item setObject:ElementValue forKey:elementName];
        
        if ([elementName isEqualToString:@"AllSchoolDemographics__Name_First"])
        {
            fullName = [NSString stringWithFormat:@"%@ %@", ElementValue, lastName];

             NSString *directory = NSHomeDirectory();
             NSString *studentName = @"fullName.txt";
             NSString *filePath =   [directory stringByAppendingPathComponent:studentName];
             [fullName writeToFile:filePath atomically:YES encoding:NSASCIIStringEncoding error:nil];
             [self readFile];
        }

    }
    
    NSLog(@"%@",ElementValue);
    
    
}
-(void)readFile {
    //This is the filePath
    NSString *filePathForUsername = [NSHomeDirectory()stringByAppendingPathComponent:@"username.txt"];
    NSString *filePathForPassword = [NSHomeDirectory()stringByAppendingPathComponent:@"password.txt"];
    NSString *filePathForStudentID = [NSHomeDirectory()stringByAppendingPathComponent:@"studentID.txt"];
    NSString *filePathForStudentFullName = [NSHomeDirectory()stringByAppendingPathComponent:@"fullName.txt"];
    

    //sets string to text in file
    NSString *fileContentsUsername = [NSString stringWithContentsOfFile:filePathForUsername encoding:NSUTF8StringEncoding error:nil];
     NSString *fileContentsPassword = [NSString stringWithContentsOfFile:filePathForPassword encoding:NSUTF8StringEncoding error:nil];
     NSString *fileContentsStudentID = [NSString stringWithContentsOfFile:filePathForStudentID encoding:NSUTF8StringEncoding error:nil];
     NSString *fileContentsFullName = [NSString stringWithContentsOfFile:filePathForStudentFullName encoding:NSUTF8StringEncoding error:nil];
   
    NSLog(@"Username is: %@",fileContentsUsername);
    NSLog(@"Password is: %@",fileContentsPassword);
    NSLog(@"StudentID is: %@",fileContentsStudentID);
    NSLog(@"The student's full name is: %@", fileContentsFullName);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end