#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <vector>
#include <sstream>
#include <iomanip>

int main() {

    std::ifstream file("input.txt");
    if(!file.is_open()){
        std::cerr << "Could not open the file!\n";
        return 1;
    }
    // read the file and then close it
    std::string line;
    std::getline(file, line);
    file.close();


    // split the line into a collection of integers
    std::vector<int> program;
    std::stringstream ss(line);
    std::string item;

    while (std::getline(ss, item, ',')) {
        program.push_back(std::stoi(item));
    }
    int pos = 0;
    std::vector<int> originalProgram = program;
    int noun;
    int verb;

    bool found = false;

    for (int i = 0; i <= 99 && !found; i += 1){
        for (int j = 0; j <= 99 && !found; j += 1) {
            program = originalProgram;
            pos = 0;
            program[1] = i;
            program[2] = j;

            //intcode execution
            int opcode; 
            int in1;
            int in2;
            int out; 
            while (program[pos] != 99) {
                opcode = program[pos];
                in1 = program[program[pos+1]];
                in2 = program[program[pos+2]];
                out = program[pos+3];

                if (opcode == 1) {
                    program[out] = in1 + in2;
                } else if (opcode == 2) {
                    program[out] = in1 * in2;
                } else if (opcode == 99){
                    break;
                }
                pos += 4;
            }

            if (program[0] == 19690720) {
                noun = i;
                verb = j;
                found = true;
            }

            std::cout << "At position 0 we now have " << program[0] << "\n";
        }
    }

    std::cout << "Noun = " << noun << ", Verb = " << verb << ", answer is " << (100 * noun + verb) << "\n";
    
    return 0;
}