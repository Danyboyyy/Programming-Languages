package mx.tec.project01.parser;

import java.util.List;
import mx.tec.project01.scanner.Token;
import mx.tec.project01.scanner.Token.Type;

public class Parser {

    public Parser() {

    }

    public void parse(List<Token> tokens) {
        parseS(tokens);
        System.out.println("The input is a well formed expresssion.");
    }

    private void parseS(List<Token> tokens) {
        if (tokens.isEmpty()) {
            System.out.println("SYNTACTIC ERROR: Expecting a token, found nothing.");
            System.out.println("The system will halt.");
            System.exit(0);
        }
        if (tokens.get(0).getType() == Type.EOF) {            
            match(tokens, new Token(Type.EOF, ";"));
            return;
        }
        switch (tokens.get(0).getType()) {
            case OPERATION:                
                match(tokens, new Token(Type.OPERATION, ""));
                match(tokens, new Token(Type.REGISTER, ""));                
                break;
            case ASSIGNMENT:                
                match(tokens, new Token(Type.ASSIGNMENT, "MOV"));
                if (tokens.get(0).getType() == Type.REGISTER) {
                    match(tokens, new Token(Type.REGISTER, ""));
                } else if (tokens.get(0).getType() == Type.INTEGER) {
                    match(tokens, new Token(Type.INTEGER, ""));
                }                
                break;
            default:
                System.out.println("ERROR: Unexpected \'" + tokens.get(0).getValue() + "\'.");
                System.out.println("The system will halt.");
                System.exit(0);
        }
        match(tokens, new Token(Type.REGISTER, ""));
        parseS(tokens);
    }

    private boolean match(List<Token> tokens, Token expectedToken) {
        if (!tokens.isEmpty() && tokens.get(0).equalsToken(expectedToken)) {
            tokens.remove(0);
            return true;
        } else {
            if (tokens.isEmpty()) {
                System.out.println("ERROR: Expecting \'" + expectedToken.getValue() + "\', found nothing.");
            } else {
                System.out.println("ERROR: Expecting \'" + expectedToken.getValue() + "\', found \'" + tokens.get(0).getValue() + "\'");
            }
            System.out.println("The system will halt.");
            System.exit(0);
        }
        return false;
    }

}
