"""
Dr. Kelly Douglass, Joshua Lemberg
University of Rochester
Department of Physics and Astronomy

Metallicity Callibrations for Dwarf Galaxies.

Work in progress.

Code written by Joshua Lemberg
"""
import os
import math
from astropy.table import Table, Column
import numpy as np

## Uses the package urllib to import the data from online table
import urllib
def import_data(url_str):
    content = urllib.request.urlopen(url_str)
    return content


## Astropy method of reading in data
    
# Changing directory to private folder, used to protect data.
def astropy_data_read(filename):
    os.chdir('/Users/JoshLemberg/Documents/URochester Folder/Research/dwarf-data-folder')
    astro_data = Table.read(filename, format = 'ascii.commented_header')
    ##print(astro_data)
    return astro_data



def make_dict(url_str):
    ''' 
    Idea here is to make a dictionary with all of the idexes as keys and then
    a list of the numbers with that index as the thing that the key is related
    to.
    '''
    
def adjustForZErr():
    '''
    This method creates a new table where the only values are ones that have 
    Error in logOH + 12 to be less than or equal to 0.05
    
    FIXME: I can't get it to effectively remove the data. Every time it iterates,
    the data that has been removed changes the index and an index out of bounds
    error is thrown after 6506 iterations.
    '''
    tableForZErr = astropy_data_read("dwarfdata.txt")
    shouldRemove = Column(np.arange(len(tableForZErr)), name='shouldRemove')
    shouldRemove.fill(0)
    tableForZErr.add_column(shouldRemove, index = 0)
    
    for i in range(0, 11051):
        if np.isnan(tableForZErr["Z12logOH"][i]):
            tableForZErr["shouldRemove"][i] = 1
        #elif np.isnan(tableForZErr["Z12logOH"][i]):
            #pass
        
        
    for i in range(0, 11051):
        try:
            if tableForZErr["shouldRemove"][i] == 1:
                tableForZErr.remove_rows(i)
        except:
            continue
            
    '''
    i = 0
    while i < len(tableForZErr):
        if tableForZErr["shouldRemove"][i] == 1:
            tableForZErr.remove_rows(i)
        i = i + 1
        '''
            

    #print(tableForZErr['index', 'Z12logOH'][0:1])
    print(tableForZErr['index', 'shouldRemove', 'Z12logOH', 'Zerr'])

def adjustForZErrTEST():
    '''
    This method creates a new table where the only values are ones that have 
    Error in logOH + 12 to be less than or equal to 0.05
    '''
    tableForZErr = astropy_data_read("dwarfdata.txt")
    shouldRemove = Column(np.arange(len(tableForZErr)), name='shouldRemove')
    shouldRemove.fill(0)
    tableForZErr.add_column(shouldRemove, index = 0)
    
    for i in range(0, 11051):
        if np.isnan(tableForZErr["Z12logOH"][i]):
            tableForZErr["shouldRemove"][i] = 1
        #elif np.isnan(tableForZErr["Z12logOH"][i]):
            #pass
            
    #print(tableForZErr['index', 'shouldRemove', 'Z12logOH', 'Zerr'])
    for i in range(0, 6):
        
        if tableForZErr["shouldRemove"][i] != 0:
            try:
                tableForZErr.remove_row(i)
            except:
                continue
        
    print(tableForZErr['index', 'shouldRemove', 'Z12logOH', 'Zerr'][0:10])

def main():
    table = astropy_data_read("dwarfdata.txt")
    #table.remove_rows(0)
    #print(table)
    
    print(table['index', 'Z12logOH', 'Zerr'])
    
    


##main()
