#include <iostream>
#include <fstream>
#include <string>
#include <vector>

int main() {
    std::ifstream file("input.txt");
    if (!file) {
        std::cerr << "Could not open input.txt\n";
        return 1;
    }

    std::vector<std::string> input;
    std::string line;

    while (std::getline(file, line)) {
        if (!line.empty()) {
            input.push_back(line);
        }
    }

    int paused_pos = 50;
    int counter = 0;
    int counter_2 = 0;

    for (const std::string &temp : input) {
        char direction = temp[0];
        int steps = std::stoi(temp.substr(1));

        for (int s = 0; s < steps; ++s) {
            if (direction == 'L') {
                paused_pos -= 1;
            } else {
                paused_pos += 1;
            }

            // MATLAB mod behaviour: always positive
            paused_pos = (paused_pos % 100 + 100) % 100;

            if (paused_pos == 0) {
                counter_2++;
            }
        }

        if (paused_pos == 0) {
            counter++;
        }

        std::cout << "Rotation " << temp
                  << ": paused at " << paused_pos
                  << " | Part1: " << counter
                  << " | Part2: " << counter_2 << "\n";
    }

    std::cout << "\nFinal passwords:\n";
    std::cout << "Part 1 (ends at 0): " << counter << "\n";
    std::cout << "Part 2 (passes 0): " << counter_2 << "\n";

    return 0;
}
