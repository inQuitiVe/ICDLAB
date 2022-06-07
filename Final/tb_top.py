import numpy as np
import random

def d2b(x, fill=True, lenth=16):
    #return [format(i,"b") for i in x]
    return str(format(x,"b")).zfill(lenth) if fill else str(format(x,"b"))

def initial(x, lenth=16):
    x = d2b(x, lenth=lenth)
    num1 = list("".zfill(len(x)))
    for i in range(len(x)):
        num1[len(x)-1-i] = x[i]
    return "".join(num1)

def deinitial(x, isint=True):
    num1 = list("".zfill(len(x)))
    for i in range(len(x)):
        num1[len(x)-1-i] = x[i]
    num1 = "".join(num1)
    return int(num1, 2) if isint else num1

def fp2int(x):
    x = initial(x)
    sign = -1 if (deinitial(x[15]) == 1) else 1
    exp = deinitial(x[10:15])
    mant = deinitial(x[0:10])
    # print(x[15], x[10:15], x[0:10])
    if (exp != 0):
        return  2**(exp-15) * sign * (mant/2**10 + 1)
    else:
        return sign * 2**(-14) *  mant/2**10

def iszero(x):
    for i in x:
        if (i != '0'): return False
    return True

def shift(x, y, out = 10, direction = "left"):
    for i in range(y): 
        if direction == "left" :
            x = '0' + x[0:len(x)-1]
        else :
            x = x[1:len(x)] + '0'
    return x[0:out+1]

def FP16multi(fp1,fp2):
    fp1 = initial(fp1)
    fp2 = initial(fp2)
    LD1 = 1 if (fp1[9] == "1") else (2 if (fp1[8] == "1") else(
          3 if (fp1[7] == "1") else (4 if (fp1[6] == "1") else(
          5 if (fp1[5] == "1") else (6 if (fp1[4] == "1") else(
          7 if (fp1[3] == "1") else (8 if (fp1[2] == "1") else(
          9 if (fp1[1] == "1") else (10 if (fp1[0] == "1") else(
          11))))))))))
    LD2 = 1 if (fp2[9] == "1") else (2 if (fp2[8] == "1") else(
          3 if (fp2[7] == "1") else (4 if (fp2[6] == "1") else(
          5 if (fp2[5] == "1") else (6 if (fp2[4] == "1") else(
          7 if (fp2[3] == "1") else (8 if (fp2[2] == "1") else(
          9 if (fp2[1] == "1") else (10 if (fp2[0] == "1") else(
          11))))))))))

    # print ("fp: ", fp1, fp2)
    # print ("LD: ", LD1, LD2) 
    
    Num1 = shift(fp1,LD1) if (iszero(fp1[10:15])) else fp1[0:10] + '1'
    Num2 = shift(fp2,LD2) if (iszero(fp2[10:15])) else fp2[0:10] + '1'

    # print ("Num: ", Num1, Num2)

    multipli = deinitial(Num1) * deinitial(Num2)
    multipli = initial(multipli, lenth=22)

    # print ("multipli: ", multipli, d2b(deinitial(multipli)))

    result_sig = '1' if (fp1[15] != fp2[15]) else '0'
    shiftex1 = 10-LD1 if (iszero(fp1[10:15])) else 10
    shiftex2 = 10-LD2 if (iszero(fp2[10:15])) else 10
    exp1 = deinitial(fp1[10:15])
    exp2 = deinitial(fp2[10:15])
    exp1 = 1 if exp1 == 0 else exp1
    exp2 = 1 if exp2 == 0 else exp2
    add = exp1 + exp2 + 1 + shiftex1 + shiftex2 if (multipli[21] == '1') else exp1 + exp2 + shiftex1 + shiftex2
    
    # print("add: ", add, add-50)

    is_overflow = True if (add > 65) else False

    

    is_underflow = True if ((add < 26) or (iszero(fp1[0:15])) or (iszero(fp2[0:15])))  else False
    result_exp = '00000' if (add < 36) else initial(add - 35,lenth=5)

    # print("result_exp: ", deinitial(result_exp))

    result_manti = (multipli[11:21] if (multipli[21] == '1') else multipli[10:20]) if (add >= 36)  else  (multipli[12:22]  if (multipli[21] == '1') else multipli[11:21])
    
    # print("result_manti: ", result_manti,  d2b(deinitial(result_manti),lenth=10))

    resultpre = "0000000000000000" if is_underflow else result_manti + result_exp + result_sig
    result = ('111111111101111' + result_sig) if is_overflow else resultpre
    # print ("result: ", result)

    
    return deinitial(result)

def FP16add(fp1,fp2):
    fp1 = initial(fp1)
    fp2 = initial(fp2)

    if (deinitial(fp2[0:15]) > deinitial(fp1[0:15])) :
        big = fp2
        small = fp1
    else :
        big = fp1
        small = fp2
    
    big_sig = big[15]
    big_exp = big[10:15]
    big_manti = big[0:10]
    small_sig = small[15]
    small_exp = small[10:15]
    small_manti = small[0:10]

    # print("exp: ", big_exp, small_exp)

    big_manti_recover = (big_manti + "1") if(big_exp!="00000") else big_manti + '0'
    small_manti_recover = (small_manti + "1") if(small_exp!="00000") else small_manti + '0'
    
    # print("recover: ", big_manti_recover, small_manti_recover)
    
    exp1 = deinitial(big_exp)
    exp1 = 1 if exp1 == 0 else exp1
    exp2 = deinitial(small_exp)
    exp2 = 1 if exp2 == 0 else exp2
    exp_diff = initial(exp1 - exp2)

    # print("exp_diff:",exp_diff)

    if(deinitial(exp_diff) == 0) :
        small_manti_shift = small_manti_recover
    elif (deinitial(exp_diff) == 1):
        if(small_manti_recover[deinitial(exp_diff)-1:deinitial(exp_diff)+1]=="11"):
            small_manti_shift = shift(small_manti_recover,deinitial(exp_diff),out=10,direction="right")
            small_manti_shift = initial(deinitial(small_manti_shift) + 1)
        else:
            small_manti_shift = shift(small_manti_recover,deinitial(exp_diff),out=10,direction="right")
    else :
        if(small_manti_recover[deinitial(exp_diff)-2:deinitial(exp_diff)+1]=="111" or small_manti_recover[deinitial(exp_diff)-2:deinitial(exp_diff)+1]=="011" or small_manti_recover[deinitial(exp_diff)-2:deinitial(exp_diff)+1]=="110"):
            small_manti_shift = shift(small_manti_recover,deinitial(exp_diff),out=10,direction="right")
            small_manti_shift = initial(deinitial(small_manti_shift) + 1)
        else:
            small_manti_shift = shift(small_manti_recover,deinitial(exp_diff),out=10,direction="right") 

    # print("small_manti_shift:",small_manti_shift)

    if (big_sig == small_sig):
        result_initial = initial(deinitial(big_manti_recover) + deinitial(small_manti_shift), lenth=12)
        if(result_initial[11] == "1" and big_exp != "01111" and big_exp != "00000"):
            result_exp = initial(deinitial(big_exp) + 1, lenth=5)
            if(result_initial[0:2] == "11"):
                result_manti = initial(deinitial(result_initial[1:11]) +1, lenth=10)
            else:
                result_manti = result_initial[1:11]
        elif (result_initial[11]=='1' and big_exp =="01111"):
            result_exp = big_exp
            result_manti = "1111111111"
        elif (result_initial[10]=='1' and big_exp =="00000"):
            result_exp = "10000"
            result_manti = result_initial[0:10]
        else :
            result_exp = big_exp
            result_manti = result_initial[0:10] 
        result_sign = big_sig
    else :
        result_initial = initial(deinitial(big_manti_recover) - deinitial(small_manti_shift),lenth=12)
        if (result_initial[10] == '1') : LOP = 0  
        elif (result_initial[9] == '1') : LOP = 1 
        elif (result_initial[8] == '1') : LOP = 2 
        elif (result_initial[7] == '1') : LOP = 3 
        elif (result_initial[6] == '1') : LOP = 4 
        elif (result_initial[5] == '1') : LOP = 5 
        elif (result_initial[4] == '1') : LOP = 6 
        elif (result_initial[3] == '1') : LOP = 7 
        elif (result_initial[2] == '1') : LOP = 8 
        elif (result_initial[1] == '1') : LOP = 9 
        elif (result_initial[0] == '1') : LOP = 10 
        else : LOP = 11

        # print ("result_initial: ", result_initial)
        # print ("LOP: ", LOP)

        if(LOP == 11):
            result_exp = "00000"
            result_shift = "000000000000"
            result_sign = "0"
        elif(deinitial(big_exp) < LOP):
            result_sign = big_sig
            result_exp = "00000"
            result_shift = shift(result_initial, deinitial(big_exp), out=11)
        elif(deinitial(big_exp) == LOP):
            result_sign = big_sig
            result_exp = "00000"
            result_shift = shift(result_initial, deinitial(big_exp)-1, out=11)
        else :
            result_sign = big_sig
            result_exp = initial(deinitial(big_exp) -LOP, lenth = 5)
            result_shift = shift(result_initial,LOP,out=11)
        result_manti = result_shift[0:10]

    # print ("result_shift: ",result_shift)
    
    result = result_manti + result_exp + result_sign

    # print ("result_manti: ",result_manti)

    # print ("result_exp: ",result_exp)

    return deinitial(result)

mode = input("0 : generate weight and adjacency\n1 : generate input \n2 : calculate real ans\n3 : generate adjacency\n4 : generate verilog golden\n5 : generate verilog input\n6 : all\nyour mode : ")
if (mode == '0' or mode == "6") : 
    with open("weight.txt","w") as f:
        for i in range(32):
            for j in range(8):
                wgt = random.randint(0,2**16-2**11)
                if wgt > 31*(2**10) :  
                    wgt += 2**10
                print(d2b(wgt),end=" ",file=f)
            print("", file=f)
    adjacency = np.zeros((100,100),dtype=np.int8)
    with open("adjacency.txt","w") as f:
        for i in range(100):
            adjacency[i][i] = 0
        for i in range(1,100):
            for j in range(i-1):
                adj = random.randint(0,20)
                if (adj == 3) : 
                    adjacency[i][j] = 1
        for i in range(1,100):
            for j in range(i-1):
                adjacency[j][i] = adjacency[i][j]
        for i in range(100):
            for j in range(100):
                print(adjacency[i][j],end=" ",file=f)
            print("", file=f)    

if (mode == '1' or mode == "6") : 
    with open("input.txt","w") as f:
        for i in range(100):
            for j in range(32):
                prob = random.randint(0,10)
                if (prob == 3):
                    ipt = random.randint(0,2**16-2**11)
                    if ipt > 31*(2**10) :  
                        ipt += 2**10
                else: ipt = 0
                print(d2b(ipt),end=" ",file=f)
            print("", file=f)
    
if (mode == '2' or mode == "6") :
    weight = np.zeros((32,8))
    adjacency = np.zeros((100,100),dtype=np.int8)
    input = np.zeros((100,32))
    with open ("weight.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0
            for j in i.split(" ")[:-1]:
                weight[x][y] = fp2int(int(j,2))
                y += 1
            x += 1
    with open ("adjacency.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0
            for j in i.split(" ")[:-1]:
                adjacency[x][y] = 0 if j == "0" else 1
                y += 1
            x += 1
    with open ("input.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0   
            for j in i[:-2].split(" "):
                input[x][y] = fp2int(int(j,2))
                y += 1
            x += 1

    out1 = np.zeros((100,8))
    out2 = np.zeros((100,8))
    for i in range(100) :
        for j in range(8):
            for k in range(32):
                out1[i][j] = out1[i][j] +input[i][k] * weight[k][j]
    for i in range(100) :
        for j in range(8):
            for k in range(100):
                out2[i][j] = out2[i][j] + adjacency[i][k] * out1[k][j]
    with open ("ans.txt","w") as f1:
        for i in range(100):
            for j in range(8):
                print(out2[i][j],end=" ",file=f1)
            print("",file=f1)

    outV1 = np.zeros((100,8))
    outV2 = np.zeros((100,8))
    for i in range(100) :
        for j in range(8):
            for k in range(32):
                outV1[i][j] = outV1[i][j] +input[i][k] * weight[k][j]
    for i in range(100) :
        for j in range(8):
            for k in range(100):
                outV2[i][j] = outV2[i][j] + adjacency[i][k] * outV1[k][j]
    with open ("golden.txt","w") as f1:
        for i in range(100):
            for j in range(8):
                print(outV2[i][j],end=" ",file=f1)
            print("",file=f1)
    
if (mode == '3' or mode == "6") :
    with open ("weight.txt","r") as f1:
        x = 0
    with open ("adjacency.txt","r") as f1:
        x = 0
        with open ("adjacency_v.txt","w") as f2:
            for i in f1.readlines():
                y = 0
                print("assign adj[",x,"] = 100'b",end="",file=f2)
                for j in i.split(" ")[:-1][::-1]:
                    print(j ,end="",file=f2)
                    y += 1
                print(";",file=f2)
                x += 1

if (mode == "4" or mode == "6") :
    weight = np.zeros((32,8),dtype=np.int32)
    adjacency = np.zeros((100,100),dtype=np.int8)
    input = np.zeros((100,32),dtype=np.int32)
    with open ("weight.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0
            for j in i.split(" ")[:-1]:
                weight[x][y] = int(j,2)
                y += 1
            x += 1
    with open ("adjacency.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0
            for j in i.split(" ")[:-1]:
                adjacency[x][y] = 0 if j == "0" else 1
                y += 1
            x += 1
    with open ("input.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0   
            for j in i[:-2].split(" "):
                input[x][y] = int(j,2)
                y += 1
            x += 1

    out1 = np.zeros((100,8),dtype=np.int32)
    out2 = np.zeros((100,8),dtype=np.int32)
    for i in range(100) :
        for j in range(8):
            for k in range(32):
                out1[i][j] = FP16add(out1[i][j],FP16multi(input[i][k], weight[k][j]))
    for i in range(100) :
        for j in range(8):
            for k in range(100):
                out2[i][j] = FP16add(out2[i][j],FP16multi(adjacency[i][k], out1[k][j]))
    with open ("golden.txt","w") as f1:
        for i in range(100):
            for j in range(8):
                print(d2b(out2[i][j]),file=f1)

if (mode == '5' or mode == "6") : 
    weight = np.zeros((32,8),dtype=np.int32)
    input = np.zeros((100,32),dtype=np.int32)
    with open ("weight.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0
            for j in i.split(" ")[:-1]:
                weight[x][y] = int(j,2)
                y += 1
            x += 1
    with open ("input.txt","r") as f1:
        x = 0
        for i in f1.readlines():
            y = 0   
            for j in i.split(" ")[:-1]:
                input[x][y] = int(j,2)
                y += 1
            x += 1
    
    with open ("input_v.txt","w") as f1:
        with open ("cmd_v.txt","w") as f2:
            w_column_cnt = 0
            for i in range(4):
                control = []
                print(d2b(w_column_cnt),file=f1)
                control.append("0")
                for j in range(32):
                    print(d2b(weight[j][w_column_cnt]),file=f1)
                    control.append("0")
                w_column_cnt += 1
                for j in range(32):
                    print(d2b(weight[j][w_column_cnt]),file=f1)
                    control.append("0")
                w_column_cnt += 1
                
                for k in range (100):
                    for m in range (32):
                        output = 0
                        if (input[k][m] != 0):
                            print(d2b(k,lenth=8),end="",file=f1)
                            print(d2b(m,lenth=8),file=f1)
                            control.append("0")
                            print(d2b(input[k][m]),file=f1)
                            output = 1
                        if k==99 and m==31:
                            control[-1] = "1"
                        elif output==1:
                            control.append("0")
                for x in control:
                    print(x,file=f2)
                        

# for k in range (100):
#                     for m in range (32):
#                         output = 0
#                         if (input[k][m] != 0):
#                             input_v.append()
#                             print(d2b(m,lenth=8),end="",file=f1)
#                             # print(k,m)
#                             print(d2b(k,lenth=8),file=f1)
#                             print('0',file=f2)
#                             print(d2b(input[k][m]),file=f1)
#                             output = 1
#                         if k==99 and m==31:
#                             print('1',file=f2)
#                         elif output==1:
#                             print('0',file=f2)
#                             print(k,m)

