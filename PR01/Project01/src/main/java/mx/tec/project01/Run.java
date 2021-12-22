package mx.tec.project01;


import java.util.List;
import mx.tec.project01.parser.Parser;
import mx.tec.project01.scanner.Scanner;
import mx.tec.project01.scanner.Token;

public class Run {
    
    public static void main(String[] args) {

        String string;
        Scanner scanner;        
        scanner = new Scanner();        
        List<Token> tokens;
        
        string = "MOV 2354 #A MOV #A #C SUM #A #B ;";
        System.out.println(string);

        // Runs the scanner on the string
        tokens = scanner.scan(string);

        // Prints the list of tokens
        for (Token token : tokens) {
            System.out.println(token);
        }
        
        Parser parser;
        parser = new Parser();
        parser.parse(tokens);
    }
    
}
