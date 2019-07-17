"""
Dr. Kelly Douglass, Joshua Lemberg
University of Rochester
Department of Physics and Astronomy

Metallicity Callibrations for Dwarf Galaxies.

Work in progress.

Code written by Joshua Lemberg
"""
import os
from astropy.table import Table
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import *
    
## Changing directory to private folder, used to protect data.
def astropy_data_read(filename):
    os.chdir('/Users/JoshLemberg/Documents/URochester Folder/Research/dwarf-data-folder')
    astro_data = Table.read(filename, format = 'ascii.commented_header')
    return astro_data

## Function to plot Z vs. Flux Ratios
def plot():
    # Creation of table objects
    table = astropy_data_read("dwarfdata.txt")
    fluxTable = astropy_data_read("dwarf_flux.txt")

    # Calculating R_23
    R_23 = (fluxTable["OII_3727_FLUX"] + fluxTable["OIII_4959_FLUX"] + fluxTable["OIII_5007_FLUX"]) / fluxTable["H_BETA_FLUX"] 

    plt.figure()
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][0:9516], fluxTable["NII_6584_FLUX"] / fluxTable["H_ALPHA_FLUX"], ".")
    plt.show()

#plot()

## Adjustment of the data for Err
def adjustForErr():
    # Opening tables
    table = astropy_data_read("dwarfdata.txt")
    fluxTable = astropy_data_read("dwarf_flux.txt")
    
    # Establishing R_23
# =============================================================================
#     R_23 = (fluxTable["OII_3727_FLUX"] + fluxTable["OIII_4959_FLUX"] + fluxTable["OIII_5007_FLUX"]) / fluxTable["H_BETA_FLUX"]
# =============================================================================
    
    # Iteration to correct tables so they have the same galaxies
    i = 0
    while i < 9156:
        if (table["index"][i] != fluxTable["index"][i]):
            table.remove_row(i)
        else:
            i += 1
    table = table[0:9516]
   
    
    BPTClassEqualsOneIndex = table["BPTclass"] == 1
    t3LessThan3Index = table["t3"] < 3
    goodIndexes = np.logical_and(BPTClassEqualsOneIndex, t3LessThan3Index)
    

# =============================================================================
#     plt.figure(1)
#     plt.xlabel("Z12logOH")
#     plt.ylabel("R_23")
#     plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
#     plt.semilogy(table["Z12logOH"][goodIndexes], R_23[goodIndexes], ".")
#     plt.show()
# =============================================================================
    
    plt.figure(2)
    plt.xlabel("Z12logOH")
    plt.ylabel("[NII]\u03BB6584 / H_\u03B1")
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][goodIndexes], fluxTable["NII_6584_FLUX"][goodIndexes] / fluxTable["H_ALPHA_FLUX"][goodIndexes], ".")
    plt.show()
    
    plt.figure(3)
    plt.xlabel("Z12logOH")
    plt.ylabel("[OIII]\u03BB5007 / [NII]\u03BB6584")
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][goodIndexes], fluxTable["OIII_5007_FLUX"][goodIndexes] / fluxTable["NII_6584_FLUX"][goodIndexes], ".")
    plt.show()
    
    plt.figure(4)
    plt.xlabel("Z12logOH")
    plt.ylabel("[NII]\u03BB6584 / [OII]\u03BB3727")
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][goodIndexes], fluxTable["NII_6584_FLUX"][goodIndexes] / fluxTable["OII_3727_FLUX"][goodIndexes], ".")
    plt.show()
    
    plt.figure(5)
    plt.xlabel("Z12logOH")
    plt.ylabel("[NII]\u03BB6584 / [SII]\u03BB6717")
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][goodIndexes], fluxTable["NII_6584_FLUX"][goodIndexes] / fluxTable["SII_6717_FLUX"][goodIndexes], ".")
    plt.show()
    
    plt.figure(6)
    plt.xlabel("Z12logOH")
    plt.ylabel("[OIII]\u03BB5007 / [OII]\u03BB3727")
    plt.autoscale(enable = True, axis = 'both', tight = None) # Creates a semilog plot to effectively show data
    plt.semilogy(table["Z12logOH"][goodIndexes], fluxTable["OIII_5007_FLUX"][goodIndexes] / fluxTable["OII_3727_FLUX"][goodIndexes], ".")
    plt.show()


def main():
    adjustForErr()
    
main()
