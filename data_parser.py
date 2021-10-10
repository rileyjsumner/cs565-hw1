"""
FILE: skeleton_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Edited By: Riley Sumner (rsumner@wisc.edu)
            Dennis Kelly (@wisc.edu)
            Hassan Kheireddine (@wisc.edu)
Modified: 04/21/2014

Skeleton parser for CS564 programming project 1. Has useful imports and
functions for parsing, including:

1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.

Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!
"""

import sys
from json import loads
from re import sub

columnSeparator = "|"

# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
"""
def transformDttm(dttm):
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):
    # lists to store what items and users we have already accounted for
    existing_items = []
    existing_users = []
    with open(json_file, 'r') as f:
        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file
        with open('items.dat', 'a') as item_data, open('bids.dat', 'a') as bids_data, open('users.dat', 'a') as user_data, open('categories.dat', 'a') as category_data:
            for item in items:
                # check to not make duplicate items
                if item['ItemID'] in existing_items:
                    continue
                existing_items.append(item['ItemID'])
                curr_id = item['ItemID']
                # now iterate through items
                for field in item:
                    #get information on bids
                    if (field == 'Bids' and item[field]):
                        for Bid in item[field]: 
                            if Bid['Bid']['Bidder']['UserID'] not in existing_users:
                                existing_users.append(Bid['Bid']['Bidder']['UserID'])
                            # first check if the user has been store already
                                user_data.write(Bid['Bid']['Bidder']['UserID'] + columnSeparator 
                                                + Bid['Bid']['Bidder']['Rating'])
                                if ('Country' in Bid['Bid']['Bidder'].keys()):
                                    user_data.write(columnSeparator + Bid['Bid']['Bidder']['Country'])
                                if ('Location' in Bid['Bid']['Bidder'].keys()):
                                    user_data.write(columnSeparator + Bid['Bid']['Bidder']['Location'])
                                user_data.write('\n')
                            #then gather bid information
                            bids_data.write(curr_id + columnSeparator 
                                            + Bid['Bid']['Bidder']['UserID'] + columnSeparator 
                                            + transformDttm(Bid['Bid']['Time']) + columnSeparator 
                                            + transformDollar(Bid['Bid']['Amount']))
                            bids_data.write("\n") # new line after each bid
                    elif (field == 'Category'):
                        for cat in item[field]:
                            category_data.write(cat + columnSeparator + curr_id)
                            category_data.write('\n')
                            
                    elif (field == 'First_Bid' or field == 'Currently'):
                        item_data.write(str(transformDollar(item[field]) + columnSeparator))
                    elif (field == 'Started' or field == 'Ends'):
                        item_data.write(str(transformDttm(item[field])) + columnSeparator)
                    else:
                        if field == 'Bids':
                            continue
                        if field == 'Category':
                            continue
                        if field == 'Seller':
                            if item[field]['UserID'] not in existing_users:
                                existing_users.append(item[field]['UserID'])
                                user_data.write(item[field]['UserID'] + columnSeparator
                                                + item[field]['Rating'] + '\n')
                                item_data.write(item[field]['UserID'] + columnSeparator)
                        elif field == 'Description':
                            item_data.write(str(item[field]))
                        else:
                            item_data.write(str(item[field]) + columnSeparator)         
        
                item_data.write('\n')

"""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def main(argv):
    if len(argv) < 2:
        print >> sys.stderr, 'Usage: python skeleton_json_parser.py <path to json files>'
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print("Success parsing " + f)
            
if __name__ == '__main__':
    main(sys.argv)
