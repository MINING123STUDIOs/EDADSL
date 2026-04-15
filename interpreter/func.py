import re

def readfile(name):
    with open(name) as f: tmp = f.read()
    return tmp
    
def str_to_scalar(string):
    s = string

    suffix =     [   "q",   "r",   "y",   "z",   "a",   "f",   "p",  "n",  "u",  "m",  "c",  "d", "k", "M", "G",  "T",  "P",  "E",  "Z",  "Y",  "R", "Q"  ]
    suffix_val = [ "-30", "-27", "-24", "-21", "-18", "-15", "-12", "-9", "-6", "-3", "-2", "-1", "3", "6", "9", "12", "15", "18", "21", "24", "27", "30" ]
    if re.search( r"^(|-|\+)(([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*)|[0-9]+)[qryzafpnumcdkMGTPEZYRQ]$", s ): #s[len(s)-1:] in suffix:
        #suffix parsing
        si = suffix.index(s[len(s)-1])
        s = s[:len(s)-1] + "e" + suffix_val[si]
        r = float(s)
    elif re.search( r"^(|-|\+)(([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*))$", s ) or re.search( r"^(|-|\+)(([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*)|[0-9]+)e(|-|\+)[0-9]+$", s ):
        r = float(s)
    elif re.search( r"^(|-|\+)[0-9]+$", s ):
        r = int(s)
    else: r = None

    return r
