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

    def execute(self):
        ''' core logic function. Makes queries, gets data, manipulates files '''

        # Vocalize execution
        print "[INFO] Converter Started."

        self.importCSV()
        self.exportCSV()

    def query(self, lat, lng):
        ''' Makes http queries to google and geonames enpoints for Lat Long conversion '''

        return self.queryGeoNames(self.queryGoogle(lat, lng))

    def queryGoogle(self, lat, lng):
        ''' A function to get Google's postal code for a lat long value '''

        try:
            payload = {"sensor": "true", "latlng": "%d,%d" % (lat, lng)}
            r = requests.get(self.googleEndpoint, params=payload)
        except:
            print "[CRITICAL] Failed to query Google endpoint!"
            raise
        else:
            data = r.json()
            # Iterate over results
            for result in data['results']:
                # If result is a postal code, we want to look at it
                if result['types'] and "postal_code" in result['types']:
                    # Iterate on this one result, looking at all components in it
                    for data in result['address_components']:
                        # If the type of this component is a postal_code then we are happy
                        if data['types'] and data['types'][0] == "postal_code":
                            # Get the name of the postal code, then quit out
                            return data['short_name']

    def queryGeoNames(self, postalcode):
        ''' query geonames API with a postal code, return a county code '''

        try:
            payload = {"county": "US", "postalcode": postalcode }
            r = requests.get(self.geoNamesEndpoint, params=payload)
        except:
            print "[CRITICAL] Failed to query GeoNames endpoint!"
            raise
        else:
            data = r.json()['postalcodes']

            for code in data:
                if code['countryCode'] == 'US':
                    return code['adminCode2']

    def importCSV(self):
        ''' Reads in the state of targeted csv file, parses column structure '''

        # Vocalize execution
        print "[INFO] Attempting to read inputFile from `%s`." % self.inFile

        with open(self.inFile, 'rb') as f:
            # Sniff the dialect of the file we are working with
            dialect = csv.Sniffer().sniff(f.read(1024))
            f.seek(0)
            # Build a reader of the file using our sniffed dialect
            reader = csv.reader(f, dialect)
            try:
                # First get headers
                headers = reader.next()
                print "[INFOl I see %i columns." % len(headers)

                # Determine where to insert data, using passed in arguments. Does some input validation as well.
                if self.column is None or self.column > len(headers) or self.column < 0:
                    self.column = len(headers) # Zero indexed
                if self.latCol > len(headers) or self.latCol < 0 or self.latCol == self.lngCol:
                    sys.exit("[CRITICAL] Invalid Latitude Column Argument.")
                if self.lngCol > len(headers) or self.lngCol < 0 or self.lngCol == self.latCol:
                    sys.exit("[CRITICAL] Invalid Longitude Column Argument.")
                print "[INFO] I will put data under column %i." % (self.column)
                print "[INFO] I am using `%s` (column %i) for Latitude values." % (headers[self.latCol], self.latCol)
                print "[INFO] I am using `%s` (column %i) for Longitude values." % (headers[self.lngCol], self.lngCol)

                # Iterate over all data, insert generated values where told to
                self.processed = [headers] # TODO: edit headers with where w are putting our county code data
                curRow = 0
                for row in reader:
                    print "[INFO] Processing row %i..." % curRow,
                    try:
                        # Cast data before we try to modify our list
                        lat = float(row[self.latCol])
                        lng = float(row[self.lngCol])
                        row[self.column:self.column] = [self.query(lat, lng)] # insert out data into list
                    except ValueError:
                        print "failed. (failed to cast `%s` and/or `%s` to a float)" % (row[self.latCol], row[self.lngCol]) 
                        row[self.column:self.column] = ["ERROR"]
                    else:
                        print "done."
                    finally:
                        self.processed.append(row)
                        curRow += 1
            except csv.Error as e:
                sys.exit('[ERROR] file %s, line %d: %s' % (filename, reader.line_num, e))

    def exportCSV(self):
        ''' writes out processed data to specified file '''

        # If no output name given at runtime, use inputname
        if self.outputName is None:
            self.outputName = self.inFile
        try:
            with open(self.outputName, 'wb') as f:
                writer = csv.writer(f)
                writer.writerows(self.processed)
        except:
            print "[ERROR] Failed to write file."
            raise

if __name__ == "__main__":

    # Instantiate Converter Object
    theConverter = SemantGeoLatLongHandler()
    
    # Read in values
    parser = argparse.ArgumentParser(description='Append County Codes to files from Lat. Long. via APIs.')
    parser.add_argument('inFile', help='path of file to be modified')
    parser.add_argument('-n', '--outputName', metavar='aName', default=None, help="If set, the output of the program is written to a new file with this name, else the program edits the inputFile.")
    parser.add_argument('latCol', type=int, help="The column that contains the latitude values in the inputFile.")
    parser.add_argument('lngCol', type=int, help="The column that contains the longitude values in the inputFile.")
    parser.add_argument('-c', '--column', metavar='aNumber', default=None, type=int, help="If set, a column is inserted at this index in the inputFile where the generated county code information will be put. Otherwise, the data is put into a column on the very end of the table. ")

    # Parse values assign to our converter
    args = parser.parse_args(namespace=theConverter)

    # Run
    theConverter.execute()