def translate_instruction_binary(opcode, args) : 
    binary_code = " "

    if opcode == "ADD" : 
        binary_code += "0001"
    elif opcode == "SUB" : 
        binary_code += "0011"
    elif opcode == "MUL" : 
        binary_code += "0010"
    elif opcode == "DIV" : 
        binary_code += "0100"
    elif opcode == "COP" : 
        binary_code += "0101"
    elif opcode == "AFC" :
        binary_code += "0110"
    elif opcode == "PRI":
        binary_code += "1101"
    
    for arg in args: 
        binary_code += format(arg, "08b")
    return binary_code


def cross_assembler(input_file, output_file):
    with open(input_file, "r") as f_in, open(output_file, "w") as f_out:
        for line in f_in:
            line = line.strip()
            if line:
                parts = line.split()
                opcode = parts[0]
                args = [int(arg) for arg in parts[1:]]
                binary_code = translate_instruction_binary(opcode, args)
                f_out.write(binary_code + "\n")

input_file = "fileasm"
output_file = "binary_code.txt"
cross_assembler(input_file, output_file)