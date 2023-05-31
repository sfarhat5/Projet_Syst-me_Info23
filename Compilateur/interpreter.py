def interpreter(binary_code_file):
    memory = [0] * 256  # Initialisation de la mémoire avec 256 emplacements
    count = 0  # Compteur de programme

    with open(binary_code_file, "r") as f:
        instructions = f.readlines()
        while count < len(instructions):
            binary_code = instructions[count].strip()
            opcode = binary_code[:4]
            

            if opcode == "0001":  # ADD
                result_address = int(binary_code[4:12], 2)
                operand1_address = int(binary_code[12:20], 2)
                operand2_address = int(binary_code[20:], 2)
                memory[result_address] = memory[operand1_address] + memory[operand2_address]

            elif opcode == "0010":  # MUL
                result_address = int(binary_code[4:12], 2)
                operand1_address = int(binary_code[12:20], 2)
                operand2_address = int(binary_code[20:], 2)
                memory[result_address] = memory[operand1_address] * memory[operand2_address]

            elif opcode == "0011":  # SOU
                result_address = int(binary_code[4:12], 2)
                operand1_address = int(binary_code[12:20], 2)
                operand2_address = int(binary_code[20:], 2)
                memory[result_address] = memory[operand1_address] - memory[operand2_address]
            elif opcode == "0110":  # AFC
                address = int(binary_code[4:12], 2)
                immediate_value = int(binary_code[12:], 2)
                memory[address] = immediate_value

            elif opcode == "0101":  # COP
                result_address = int(binary_code[4:12], 2)
                operand_address = int(binary_code[12:20], 2)
                memory[result_address] = memory[operand_address]
            elif opcode == "0100":  # DIV
                result_address = int(binary_code[4:12], 2)
                operand1_address = int(binary_code[12:20], 2)
                operand2_address = int(mabinary_codechine_code[20:], 2)
                memory[result_address] = memory[operand1_address] // memory[operand2_address]
            elif opcode == "1101":  # PRI
                address = int(binary_code[4:], 2)
                value = memory[address]
                print(value)
            count += 1 #passe à l'instruction suivante

            
binary_code_file = "binary_code.txt"
interpreter(binary_code_file)





