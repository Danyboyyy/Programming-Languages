package mx.tec.project01.scanner;

import mx.tec.project01.scanner.Token.Type;
import java.util.ArrayList;
import java.util.List;

public class Scanner {

    private final int ERROR = 9999;
    private final int[][] transitionMatrix;

    public Scanner() {

        transitionMatrix = new int[][]{
            {0, 1, 3, 2, 104, ERROR},
            {101, 1, ERROR, ERROR, ERROR, ERROR},
            {ERROR, ERROR, 102, ERROR, ERROR, ERROR},
            {103, ERROR, 3, ERROR, ERROR, ERROR}
        };
    }

    public List<Token> scan(String string) {
        char c;
        int state, index;
        StringBuilder value;
        List<Token> tokens;
        state = 0;
        index = 0;
        tokens = new ArrayList();
        while (index < string.length()) {
            value = new StringBuilder();
            do {
                c = string.charAt(index);                
                index++;
                state = transitionMatrix[state][filter(c)];     //103         
                if (state > 0) {
                    value.append(c);                            //MOV ,
                }
            } while (index < string.length() && state < 100);
            /*
             * The token is recognized by the system.
             */
            switch (state) {
                case 0:
                    return tokens;
                case 101:
                    tokens.add(new Token(Type.INTEGER, value.toString().trim()));
                    break;
                case ERROR:
                    value.append(c);
                    System.out.println("LEXICAL ERROR: the string \'" + value.toString().trim() + "\' is not a valid element in the language.");
                    System.out.println("The system will halt.");
                    System.exit(0);
                    return tokens;
                case 102:
                    switch (value.toString().trim()) {
                        case "#A":
                        case "#B":
                        case "#C":
                        case "#D":
                            tokens.add(new Token(Type.REGISTER, value.toString().trim()));
                            break;
                        default:
                            System.out.println("LEXICAL ERROR: the string \'" + value.toString().trim() + "\' is not a valid element in the language.");
                            System.out.println("The system will halt.");
                            System.exit(0);
                    }
                    break;
                case 103:
                    switch (value.toString().trim()) {
                        case "SUM":
                        case "SUB":
                        case "MUL":
                        case "DIV":
                            tokens.add(new Token(Type.OPERATION, value.toString().trim()));
                            break;
                        case "MOV":
                            tokens.add(new Token(Type.ASSIGNMENT, value.toString().trim()));
                            break;
                        default:
                            System.out.println("LEXICAL ERROR: the string \'" + value.toString().trim() + "\' is not a valid element in the language.");
                            System.out.println("The system will halt.");
                            System.exit(0);
                    }
                    break;
                case 104:
                    tokens.add(new Token(Type.EOF, value.toString().trim()));
                    break;
            }
            state = 0;
        }
        return tokens;
    }

    private int filter(char c) {
        if (c == ' ' || c == '\t' || c == '\n') {
            return 0;
        }
        if (c > 47 && c < 58) {
            return 1;
        }
        if (c > 64 && c < 91) {
            return 2;
        }
        if (c== '#') {
            return 3;
        }
        if (c== ';') {
            return 4;
        }
        return 5;
    }

}
