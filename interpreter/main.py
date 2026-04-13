#TODO: actually write the parsing functions

import func as F

def parse_var(line):
    pass

def parse_phy(line):
    pass

def parse_mk(line):
    pass

def parse_electrical(line):
    pass

def parse_goto(line):
    pass

def parse_function(line):
    pass

def parse_echo(line):
    pass

def parse_conditional(line):
    pass

def parse_iterator(line):
    pass

def parse_writetolog(line):
    pass

def parse_sys(line):
    pass

def parse_end(line):
    pass

def parse_(line):
    pass



input_code = F.readfile("ssr.ec")

input_code = input_code.replace("%N", "\n")

while input_code.count("  ") > 0:
    input_code = input_code.replace("  ", " ")


input_code = input_code.replace("\n ", "\n")


icode0 = input_code.splitlines()

icode1 = []

multi_line_comment = False

for line in icode0:
    if "#{" in line: multi_line_comment = True
    if "#" in line: line = line[0:min( len(line) + 1, line.find("#") )]
    line = line.removesuffix(" ")
    condition = line == "" or ( len(line) > 2 and ( "#{" in line or "}#" in line ) ) or multi_line_comment
    if not condition:
        icode1 += [line]
    if "}#" in line: multi_line_comment = False

print(icode1)
# icode1 is the clean code which is ready for parsing.

Pdone = False
line_idx = 0

while not Pdone:
    line = icode1[line_idx]
    #send line to correct parsing function
    estart = [ "tag", "unt", "con", "par", "net" ]
    if line[0] == "$":
        print("VAR!")
        parse_var(line)

    elif line[0:3] == "phy":
        print("PHY!")
        parse_phy(line)

    elif line[0:2] == "mk":
        print("MK!")
        parse_mk(line)

    elif line[0:3] in estart:
        print("ELE!")
        parse_electrical(line)

    elif line[0:8] in [ "gotojump", "gotomark" ]:
        print("GTO!")
        parse_goto(line)

    elif line[0:8] == "function":
        print("FUN!")
        parse_function(line)

    elif line[0:4] == "echo":
        print("ECH!")
        parse_echo(line)

    elif line[0:2] == "if":
        print("CON!")
        parse_conditional(line)

    elif line[0:3] == "for":
        print("ITR!")
        parse_iterator(line)

    elif line[0:10] == "writetolog":
        print("LOG!")
        parse_writetolog(line)

    elif line[0:3] == "sys":
        print("SYS!")
        parse_sys(line)

    elif line[0:4] == "halt":
        print("HLT!")
        Pdone = True
        parse_end(line)
        break

    else:
        print("Invalid line encounterd!")
        break


    if line_idx < len(icode1):
        line_idx += 1
    else:
        print("End of program reached without halt statement being encountered!")
        break
