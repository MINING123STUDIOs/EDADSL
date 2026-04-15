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
