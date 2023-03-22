##############################################################################
#This is a program to clalculate the floating point value of a binary number.#
#Author - Colton Belleau                                                     #
#Date 03-20-23                                                               #
##############################################################################
userInput = input("Welcome to the floating point calculator. \nTo continue, input 1.\nTo exit, input 2.\n")

while  userInput != "2":

    border = "======================================================"
    # recieve input from user
    signBin = input("Input the sign bit, 1 or 0\n")
    exponentBin = input("Input the exponent bits (include leading zeros)\n")
    mantissaBin = input("Input the mantissa bits (include leading zeros)\n")
    #convert string of bits to int
    signInt = int(signBin,2)
    exponentInt = int(exponentBin,2)
    mantissaInt = int(mantissaBin,2)
    #stores length of bit string
    signLen = len(signBin)
    exponentLen = len(exponentBin)
    mantissaLen = len(mantissaBin)
    #checks if exponent bit string is all 1's
    def checkInfinity(expInt,expLen):
        max = (2**expLen)-1
        if expInt == max:
            return 1
        else:
            return 0
    #checks if exponent bit string is all 0's
    def checkSubnormal(expInt):
        if expInt == 0:
            return 1
        else: 
            return 0
    #calculates the bias 
    def calcBias(expLen):
        bias = ((2 ** (expLen - 1)) - 1)
        print("Bias = 2^(bits_of_exponent - 1) - 1")
        print("Bias = 2^("+str(expLen)+" - 1) - 1 =",bias)
        return bias
    #calculates the E if noraml
    def normCalcE(expInt, bias):
        E = expInt - bias
        print("Normal E = Exponent - Bias")
        print("Noraml E = "+str(expInt)+" - "+str(bias)+" =",E)
        return E
    #calculates the E if subnormal
    def subNormCalcE(bias):
        print("Subnormal E = 1 - Bias")
        print("Subnoraml E = 1 - "+str(bias)+" =",1 - bias)
        return 1 - bias
    #calculates the M if noraml
    def normCalcM(manInt,manLen):
        M = 1+(manInt/(2**manLen))
        print("Normal M = 1 + (Mantissa/2^(bits_of_mantissa))")
        print("Noraml M = 1 + ("+str(manInt)+"/2^("+str(manLen)+")) =",M)
        return M
    #calculates the M if subnoraml
    def subNormCalcM(manInt,manLen):
        M = (manInt/(2**manLen))
        print("Subnormal M = 0 + (Mantissa/2^(bits_of_mantissa))")
        print("Suboraml M = 0 + ("+str(manInt)+"/2^("+str(manLen)+")) =",M)
        return M
    #main function
    def floatingPoint():
        E = 0
        M = 0
        print(border)
        #prints users input
        print("You inputed: "+signBin+exponentBin+mantissaBin)
        #checks if exponent is all 1's. returns either infinity or negative infinity based on sign
        if checkInfinity(exponentInt,exponentLen):
            print(border)
            if signInt == 0:
                return "Infinity"
            else:
                return "Negative Infinity"
            
        print(border)
        #calculates the bias
        Bias = calcBias(exponentLen)
        #checks if input is normal or subnormal and preforms E and M calculations accordingly
        if checkSubnormal(exponentInt) == 0:
            print(border)
            E = normCalcE(exponentInt,Bias)
            print(border)
            M = normCalcM(mantissaInt, mantissaLen)
        else:
            print(border)
            E = subNormCalcE(Bias)
            print(border)
            M = subNormCalcM(mantissaInt,mantissaLen)

        print(border)
        print("E =", E,", M =", M)
        print(border)
        #calculates N, the floating point value of the user input
        print("N = ((-1)^sign) * (2^E) * M")
        print("N = ((-1)^"+str(signInt)+") * (2^"+str(E)+") * ("+str(M)+")")
        return ((-1)**signInt) * (2 ** E) * M
    #prints N
    print("N = ",floatingPoint())

    userInput = input("\nTo continue, input 1.\nTo exit, input 2.\n")