#ifndef ANALYZER_H
#define ANALYZER_H

#define error 9999

class Analyzer {
  private:
    vector< vector<int> > transitionMatrix;
  public:
    Analyzer();
    vector<Tokens> analyze(vector<char> instructions);
    int check(char);
};

Analyzer::Analyzer() {
  transitionMatrix = {
    {0, 1, 2, 3, 104, error},
    {101, 1, error, error, error, error},
    {error, 102, error, error, error, error},
    {103, error, error, 3, error, error}
  };
}

vector<Tokens> Analyzer::analyze(vector<char> instructions) {
  char x;
  int state = 0, i = 0, aux;
  string operation = "";
  vector<Tokens> tokens;

  while (i < instructions.size()) {
    do {
      x = instructions[i];
      i++;
      aux = check(x);
      state = transitionMatrix[state][aux];
      if (state > 0) 
        operation += x;
    } while (i < instructions.size() && state < 100);

    operation.erase(remove_if(operation.begin(), operation.end(), ::isspace), operation.end());

    if (state == 0) {
      return tokens;
    } else if (state == 101) {
      if (operation == "SUM" || operation == "SUB" || operation == "MUL" || operation == "DIV") {
        Tokens tk("OPERATION", operation);
        tokens.push_back(tk);
      } else if (operation == "MOV") {
        Tokens tk("ASSIGNMENT", operation);
        tokens.push_back(tk);
      } else {
        cout << "LEXICAL ERROR: " << operation << " is not a valid string in the language." << endl;
        exit(0);
      }
    } else if (state == 102) {
      if (operation == "#A" || operation == "#B" || operation == "#C" || operation == "#D") {
        Tokens tk("REGISTER", operation);
        tokens.push_back(tk);
      } else {
        cout << "LEXICAL ERROR: " << operation << " is not a valid string in the language." << endl;
        exit(0);
      }
    } else if (state == 103) {
      Tokens tk("INTEGER", operation);
      tokens.push_back(tk);
    } else if (state == 104) {
      Tokens tk("EOF", operation);
      tokens.push_back(tk);      
    } else if (state == error) {
      operation += x;
      cout << "LEXICAL ERROR: " << operation << " is not a valid string in the language." << endl;
      exit(0);
      return tokens;
    }
    state = 0;
    operation = "";
  }
  return tokens;
}

int Analyzer::check(char x) {
  if (x == ' ' || x == '\n') {
    return 0;
  } else if (x >= 65 && x <= 90) {
    return 1;
  } else if (x == '#') {
    return 2;
  } else if (x >= 48 && x <= 57) {
    return 3;
  } else if (x == ';') {
    return 4;
  } else {
    return 5;
  }
}

#endif