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
from astropy.table import Table
import urllib

## Uses the package urllib to import the data from online table
def import_data(url_str):
    content = urllib.request.urlopen(url_str)
    return content


## Astropy method of reading in data
    
def astropy_data_read(filename):
    os.chdir('/Users/JoshLemberg/Documents/URochester Folder/Research/dwarf-data-folder')
    # Changing directory to private folder, used to protect data.
    astro_data = Table.read(filename, format = 'ascii.commented_header')
    print(astro_data)

## Preliminary method of reading data from table. Does not use Astropy
def test_data(url_str):
    # Open the file for read-only access
    url_str = "https://www.pas.rochester.edu/~kdouglass/Research/dwarf_voidstatus_P-MJD-F_MPAJHU_ZdustOS_stellarMass_BPT_SFR_NSA_ALFALFA_HI70.txt"
    infile = import_data(url_str)
    
    # Ask for index
    index = eval(input('What is the index? '))

    # Ask for column
    col = input('What is the column? ')

    # estabilshing the different cols
    col_list = infile.readline().decode().split()
    col_num = col_list.index(col)

    remaining_lines = infile.readlines()
    realindex = index - 1
    list_for_index = remaining_lines[realindex]
    list_for_index_split = list_for_index.decode().split()
    try:
        float(list_for_index_split[col_num])
        output1 = float(list_for_index_split[col_num])
    except:
        output1 = print(list_for_index_split[col_num])
    return output1


def make_dict(url_str):
    ''' 
    Idea here is to make a dictionary with all of the idexes as keys and then
    a list of the numbers with that index as the thing that the key is related
    to.
    '''

def main():
    #url_str = input("What is the name of the url you wish to input? ")
    url_str = "https://www.pas.rochester.edu/~kdouglass/Research/dwarf_voidstatus_P-MJD-F_MPAJHU_ZdustOS_stellarMass_BPT_SFR_NSA_ALFALFA_HI70.txt"
    infile = import_data(url_str)
    x = infile.readline().decode().split() # .decode() removes the b before the string
    print(test_data(url_str))


#main()
