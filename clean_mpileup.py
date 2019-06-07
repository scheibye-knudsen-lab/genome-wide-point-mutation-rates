import re
import sys
print ("This is the name of the script: " + str(sys.argv[0]))
print ("Number of arguments: " + str(len(sys.argv)))
print ("The arguments are: " + str(sys.argv))

def doIt(filename):
    outfile = open(filename + ".clean",'w')

    with open(filename,'r') as infile:
        for line in infile:
            line = re.sub("\n", "", line)
            line = line.split('\t')
            line[4] = re.sub("\^.", "", line[4])
            line[4] = re.sub("\$", "", line[4])

            insertions = re.findall("\+(\d+)", line[4])

            if len(insertions)!=0:
                regex_insertions = "^"
                for insertion in insertions:
                    insertion = int(insertion)
                    if int(insertion)>=10:
                        insertion = insertion + 1
                    insertion = insertion + 1
                    regex_insertions = regex_insertions + ".*?(\+.{" + str(insertion) + "})"
                regex_insertions = regex_insertions + ".*?$"
                groups = re.search(regex_insertions, line[4]).groups()
                for group in groups:
                    regex_remove = "\\" + str(group)
                    line[4] = re.sub(regex_remove, "", line[4], 1)

            deletions = re.findall("\-(\d+)", line[4])

            if len(deletions)!=0:
                regex_deletions = "^"
                for deletion in deletions:
                    deletion = int(deletion)
                    if int(deletion)>=10:
                        deletion = deletion + 1
                    deletion = deletion + 1
                    regex_deletions = regex_deletions + ".*?(\-.{" + str(deletion) + "})"
                regex_deletions = regex_deletions + ".*?$"
                groups = re.search(regex_deletions, line[4]).groups()
                for group in groups:
                    regex_remove = "\\" + str(group)
                    line[4] = re.sub(regex_remove, "", line[4], 1)

            if int(line[3])!=0:
                if len(line[4])!=int(line[3]):
                    print(line)
            outfile.write('\t'.join(line) + '\n')

    outfile.close()


doIt(sys.argv[1])
