import re
import numpy as np
import sys
print ("This is the name of the script: " + str(sys.argv[0]))
print ("Number of arguments: " + str(len(sys.argv)))
print ("The arguments are: " + str(sys.argv))

print("start")

def calc_qscore(x):
    return 1-(10**(-(ord(x)-33)/10))

def calc_mapq(x):
    return 1-(10**(-(ord(x)-33)/10))

def doIt(filename):
    print(filename)
    ACGT = ['A','C','G','T','N']

    outfile = open(filename + ".freqs",'w')

    # title = 'chr\tpos\tref\tcall\ta\tc\tg\tt\tc>t\n'
    title = 'chr\tpos\tref\tdepth\ta\tc\tg\tt\tfa\tfc\tfg\tft\tdepth\n'


    outfile.write(title)

    with open(filename,'r') as infile:
        for line in infile:
            line = re.sub('\n', '', line)
            line = line.split('\t')
            counts = int(line[3])
            if counts > 0:
                reads = line[4]
                reads = re.sub(",", line[2].upper(), reads)
                reads = re.sub("\.", line[2].upper(), reads)
                reads = list(reads.upper())
                qscore = line[5]
                mapq = line[6]

                mapq = list(map(calc_mapq, mapq))
                qscore = list(map(calc_qscore, qscore))
                mapq = np.array(mapq)
                qscore = np.array(qscore)
                freqs = mapq*qscore

                As = [i for i, x in enumerate(reads) if x == "A"]
                Cs = [i for i, x in enumerate(reads) if x == "C"]
                Gs = [i for i, x in enumerate(reads) if x == "G"]
                Ts = [i for i, x in enumerate(reads) if x == "T"]

                TotalA = np.sum(freqs[[As]])
                # if TotalA == 0:
                #     TotalA = 0.0001
                TotalC = np.sum(freqs[[Cs]])
                # if TotalC == 0:
                #     TotalC = 0.0001
                TotalG = np.sum(freqs[[Gs]])
                # if TotalG == 0:
                #     TotalG = 0.0001
                TotalT = np.sum(freqs[[Ts]])

                TotalACGT = TotalA + TotalC + TotalG + TotalT

                # if TotalT == 0:
                #     TotalT = 0.0001
                # TotalACGT = np.sum(freqs)
                # if TotalACGT == 0:
                #     TotalACGT = 0.0004

                FreqA = TotalA/TotalACGT
                FreqC = TotalC/TotalACGT
                FreqG = TotalG/TotalACGT
                FreqT = TotalT/TotalACGT
                #
                # FreqTC = np.sum([FreqT, FreqC])
                # FreqC_TC = FreqC/FreqTC
                # FreqT_TC = FreqT/FreqTC
                # RatioTC = FreqT_TC/FreqC_TC
                #
                # call = [FreqA,FreqC,FreqG,FreqT]
                # call = call.index(max(call))

                new_line = line[0] + '\t' + line[1] + '\t' + line[2] + '\t' + line[3] + '\t' + "{0:.20f}".format(TotalA) + '\t' + "{0:.20f}".format(TotalC) + '\t' + "{0:.20f}".format(TotalG) + '\t' + "{0:.20f}".format(TotalT) + '\t' + "{0:.20f}".format(FreqA) + '\t' + "{0:.20f}".format(FreqC) + '\t' + "{0:.20f}".format(FreqG) + '\t' + "{0:.20f}".format(FreqT) + '\t' + "{0:.20f}".format(TotalACGT) +'\n'
                # new_line = line[0] + '\t' + line[1] + '\t' + line[2] + '\t' + ACGT[call] + '\t' + "{0:.20f}".format(FreqA) + '\t' + "{0:.20f}".format(FreqC) + '\t' + "{0:.20f}".format(FreqG) + '\t' + "{0:.20f}".format(FreqT) + '\t' + "{0:.20f}".format(RatioTC) + '\n'
                outfile.write(new_line)

    outfile.close()
    # print('.')
    print("done")

doIt(sys.argv[1])
