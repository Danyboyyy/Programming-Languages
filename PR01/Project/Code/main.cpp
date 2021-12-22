// Daniel Alejandro David Sánchez A00824566
// Santiago Cano Herrera A01651319
// Project 01
// 09/03/2021

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;

#include "Tokens.h"
#include "Analyzer.h"
#include "Parser.h"

bool emptyFile(ifstream &file) {
  return file.peek() == ifstream::traits_type::eof();
}

int main() {
  ifstream arch;
  
  string name;
  string str;

  vector<Tokens> tokens;
  vector<char> instructions;

  Analyzer analyzer;
  Parser parser;

  cout << "Provide an input text file: " << endl;
  cin >> name;
  arch.open(name);

  if (arch.fail()) {
    cout << "File " << name << " not found." << endl;
    exit(0);
  }

  while (!arch.eof()) {
    getline(arch, str);
    for (int i = 0; i < str.size(); i++) {
      instructions.push_back(str[i]);
    }
    instructions.push_back('\n');
  }  

  tokens = analyzer.analyze(instructions);
  parser.parse(tokens);

  arch.close();
}