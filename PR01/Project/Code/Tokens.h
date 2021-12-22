#ifndef TOKENS_H
#define TOKENS_H

class Tokens {
  private:
    string type;
    string operation;
  public:
    Tokens(string, string);
    string getType() { return type; };
    string getValue() { return operation; };
    void setType(string type) { this->type = type; };
    void setValue(string operation) { this->operation = operation; } ;
    bool operator==(Tokens);
};

Tokens::Tokens(string type, string operation) {
  this -> type = type;
  this -> operation = operation;
}

bool Tokens::operator==(Tokens token) {
  if(token.operation.length() > 0) {
    if(type == token.type && operation == token.operation) {
      return true;
    }
  } else {
    return (type == token.type);
  }
}

#endif
