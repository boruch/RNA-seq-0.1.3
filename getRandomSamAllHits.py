import sys
def getRandomSamAllHits(sam, numReads):
    import random
    f=open(sam,"r")
    g=open(str("sample_any_"+str(numReads)+"_"+sam),"w")
    line=f.readline()
    while line[0] is "@":
        g.write(line)
        line=f.readline()
    f.seek(-1,2)
    end=f.tell()
    ids={}
    nb=1000
    f.seek(nb,0)
    window=end/numReads
    while len(ids) < numReads and nb < end:
        rbt=random.randrange(1,window)
        f.seek(rbt,1)
        line=f.readline()
        line=f.readline()
        nb=f.tell()
        id=line
        g.write(id)
        ids[id]=1
    f.close()
    g.close()
    return
sys.path.append("/u/home/eeskin/charlesb/PIPELINE/RNA-seq-0.1.3/bin")
from getRandomSamAllHits import *
sam=sys.argv[1]
numReads=sys.argv[2]
getRandomSamAllHits(sam,int(numReads))
