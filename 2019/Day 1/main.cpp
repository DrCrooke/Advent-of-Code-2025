#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <iomanip>

int main() {
    std::ifstream file("input.txt");
    if (!file.is_open()) {
        std::cerr << "Could not open file\n";
        return 1;
    }

    long long totalFuel = 0;
    std::string line;

    std::cout << std::fixed << std::setprecision(0);

    while (std::getline(file, line)) {
        if (line.empty()) continue;

        try {
            int mass = std::stoi(line);
            int moduleFuel = std::floor(mass / 3.0) - 2;
            int extraFuel = moduleFuel;

            // calculate fuel for the fuel
            while (extraFuel > 0) {
                extraFuel = std::floor(extraFuel / 3.0) - 2;
                if (extraFuel > 0) moduleFuel += extraFuel;
            }

            totalFuel += moduleFuel;
            std::cout << "Input: " << mass << ", Total Fuel: " << moduleFuel << "\n";

        } catch(const std::exception& e) {
            std::cerr << "Invalid number in line: " << line << "\n";
        }
    }

    std::cout << "The total amount of fuel required is: " << totalFuel << "\n";

    return 0;
}
