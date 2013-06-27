# Created June 26 2013
__author__ = "student/ brendan / ashbyb@rpi.edu"
__summary__ = "A program to quickly modify data files (.xls) and add in county code data quickly."
__dependancies__ = "I use Requests for making queries: http://docs.python-requests.org/en/latest/"

# Standard Imports
import sys
import os
import csv
import argparse

# Import Dependancies
import requests

# Debugging Constants
TESTFILE = 'testFile.csv'

class SemantGeoLatLongHandler(object):
    ''' A class to parse Lat Long values into county code and manipulate xls files with the results '''

    def __init__(self):
        ''' standard constructor '''

        self.googleEndpoint = "http://maps.googleapis.com/maps/api/geocode/json"
        self.geoNamesEndpoint = "http://ws.geonames.org/postalCodeLookupJSON"
        #self.inputFile = inputFile
        #self.outputFile = outputFile

        # When no outputFile specified, we default to overwriting inputFile TODO: Is this a bad idea?
        #if self.outputFile is None:
        #   self.outputFile = inputFile

    def execute(self):
        ''' core logic function. Makes queries, gets data, manipulates files '''

        self.importCSV()
        self.query()
        #self.exportCSV()

    def query(self):
        ''' Makes http queries to google and geonames enpoints for Lat Long conversion '''

        pass
        #r = requests.get(self.googleEndpoint, auth=('user', 'pass'))

    def importCSV(self):
        ''' Reads in the state of targeted csv file, parses column structure '''

        with open(self.inFile, 'rb') as f:
            dialect = csv.Sniffer().sniff(f.read(1024))
            f.seek(0)
            reader = csv.reader(f, dialect)
            try:
                # First get headers
                headers = reader.next()
                print headers
                for row in reader:
                    pass
                    #print row
            except csv.Error as e:
                sys.exit('file %s, line %d: %s' % (filename, reader.line_num, e))

    def exportCSV(self):
        ''' writes out processed data to specified file '''

        with open(self.outputName, 'wb') as f:
            writer = csv.writer(f)
            writer.writerows(['a', 'b'])

if __name__ == "__main__":

    # Instantiate Converter Object
    theConverter = SemantGeoLatLongHandler()
    
    # Read in values
    parser = argparse.ArgumentParser(description='Append County Codes to files from Lat. Long. via APIs.')
    parser.add_argument('inFile', help='path of file to be modified')
    parser.add_argument('-n', '--outputName', metavar='aName', default=None, help="If set, the output of the program is written to a new file with this name, else the program edits the inputFile.")
    parser.add_argument('latCol', help="The column that contains the latitude values in the inputFile.")
    parser.add_argument('lngCol', help="The column that contains the longitude values in the inputFile.")

    # Parse values assign to our converter
    args = parser.parse_args(namespace=theConverter)

    # Run
    theConverter.execute()