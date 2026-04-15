import re

def readfile(name):
    with open(name) as f: tmp = f.read()
    return tmp
    

def str_to_scalar(s):
    suffix_map = {
        "q": -30, "r": -27, "y": -24, "z": -21,
        "a": -18, "f": -15, "p": -12, "n": -9,
        "u": -6,  "m": -3,  "c": -2,  "d": -1,
        "k": 3,   "M": 6,   "G": 9,   "T": 12,
        "P": 15,  "E": 18,  "Z": 21,  "Y": 24,
        "R": 27,  "Q": 30
    }

    # Base number pattern
    num = r"[+-]?(\d+(\.\d*)?|\.\d+)"

    s = s.replace(" ", "").replace("µ", "u").replace("μ", "u").replace("_", "").replace("−", "-").replace("K", "k")
    # With suffix (e.g., 10k, 3.3M)
    if re.fullmatch(num + r"[qryzafpnumcdkMGTPEZYRQ]", s):
        value = float(s[:-1])
        return value * (10 ** suffix_map[s[-1]])

    # Scientific notation
    if re.fullmatch(num + r"[eE][+-]?\d+", s):
        return float(s)

    # Plain float
    if re.fullmatch(num, s):
        return float(s)

    return None
# tests=["0","1","-1","+1","42","-999999","0.0","1.0","-1.0","+3.14",".5","-.5","2.","123.456","1e3","1E3","-1e3","+1e-3","3.14e2",".5e-2","1k","2M","3G","4T","5P","6E","7Z","8Y","9R","10Q","1m","1u","1n","1p","1f","1a","1z","1y","+0","-0","0001","1.000",".0","0.","1e0","1k","1.5M","",".","-","+","e3","1e","1ee3","1.2.3","1 k","1,000","1..0","--1","++1","1M3","k1","M1","abc","1z!"," 1k","1k ","1_k","1µ","1μ","1−2","1K","1e+","1e-","1e--3"] 
