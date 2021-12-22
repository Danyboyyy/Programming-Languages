#ifndef PARSER_H
#define PARSER_H

class Parser {
  private:
    void verifyParse(vector<Tokens>);
    bool verifyTokenValue(vector<Tokens>&, Tokens);
  public:
    void parse(vector<Tokens>);
};

void Parser::parse(vector<Tokens> tokens) {
  verifyParse(tokens);
  cout << "No error found." << endl;
}

void Parser::verifyParse(vector<Tokens> tokens) {
  if (tokens.empty()) {
    cout << "SYNTACTIC ERROR: Expected a token, found nothing." << endl;
    exit(0);
  }
  if (tokens[0].getType() == "EOF") {
    Tokens tk("EOF", ";");
    verifyTokenValue(tokens, tk);
    return;
  }
  if (tokens[0].getType() == "OPERATION") {
    Tokens tk("REGISTER", "");
    Tokens tks("OPERATION", "");
    verifyTokenValue(tokens, tks);
    verifyTokenValue(tokens, tk);
  } else if (tokens[0].getType() == "ASSIGNMENT") {
    Tokens tk("ASSIGNMENT", "MOV");
    verifyTokenValue(tokens, tk);
    if (tokens[0].getType() == "REGISTER") {
      Tokens tkr("REGISTER", "");
      verifyTokenValue(tokens, tkr);
    } else if (tokens[0].getType() == "INTEGER"){
      Tokens tki("INTEGER", "");
      verifyTokenValue(tokens, tki);
    }
  } else {
    cout << "SYNTACTIC ERROR: Unexpected " << tokens[0].getValue() << "." << endl; 
    exit(0);
  }
  Tokens tkr("REGISTER", "");
  verifyTokenValue(tokens, tkr);
  verifyParse(tokens);
}

bool Parser::verifyTokenValue(vector<Tokens> &tokens, Tokens aux) {
  if (!tokens.empty() && tokens[0] == aux) {
    tokens.erase(tokens.begin());
    return true;
  } else {
    if (tokens.empty()) {
      cout << "SYNTACTIC ERROR: Expecting " << aux.getType() << ", found nothing." << endl;
    } else {
      cout << "SYNTACTIC ERROR: Expecting " << aux.getType() << ", found " << tokens[0].getValue() << ".\n";
    }
    exit(0);
  }
  return false;
}

#endif