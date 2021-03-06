import java.io.*;
public class Main {
    public static boolean isUgly(long num){
        if (num == 0) return true;
        if (num % 2 == 0) return true;
        if (num % 3 == 0) return true;
        if (num % 5 == 0) return true;
        if (num % 7 == 0) return true;
        return false;
    }
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        String[] opopts = {"+", "-", ""};
        String[] numbers = new String[16];
        int i = 0;
        int j = 0;
        String evstring = "\0";
        int maincount = 0;
        int[] counter = new int[15];
        while ((line = buffer.readLine()) != null) {
            line = line.trim();
            numbers = line.split("");
            maincount = 0;
            for (i = 0; i < numbers.length-1; i++) counter[i]=0;
            i=0;
            j=0;
            while (i < Math.pow(3,(numbers.length-1)) ){
                evstring = numbers[0].toString();
                for(j=1; j<numbers.length; j++){
                    evstring = evstring + opopts[counter[j-1]] +
                        numbers[j].toString();
                }
                if (isUgly(Math.round(eval(evstring)))) maincount++;
                counter[0]++;
                i++;
                for (j=1; j < numbers.length; j++){
                    if (counter[j-1] == 3){
                        counter[j]++;
                        counter[j-1] = 0;
                    }
                }
            }
            System.out.printf("%d\n", maincount);
        }
    }
    public static double eval(final String str) {
        return new Object() {
            int pos = -1, ch;

            void eatChar() {
                ch = (++pos < str.length()) ? str.charAt(pos) : -1;
            }

            boolean eatChar(int ch) {
                if (this.ch == ch) {
                    eatChar();
                    return true;
                }
                return false;
            }

            void eatSpace() {
                while (Character.isWhitespace(ch)) eatChar();
            }

            double parse() {
                eatChar();
                double x = parseExpression();
                if (pos < str.length()) throw new RuntimeException("Unexpected: " + (char)ch);
                return x;
            }

            // Grammar:
            // expression = term | expression `+` term | expression `-` term
            // term = factor | term `*` factor | term `/` factor
            // factor = `+` factor | `-` factor | `(` expression `)`
            //        | number | functionName factor | factor `^` factor

            double parseExpression() {
                double x = parseTerm();
                for (;;) {
                    eatSpace();
                    if      (eatChar('+')) x += parseTerm(); // addition
                    else if (eatChar('-')) x -= parseTerm(); // subtraction
                    else return x;
                }
            }

            double parseTerm() {
                double x = parseFactor();
                for (;;) {
                    eatSpace();
                    if      (eatChar('*')) x *= parseFactor(); // multiplication
                    else if (eatChar('/')) x /= parseFactor(); // division
                    else return x;
                }
            }

            double parseFactor() {
                eatSpace();
                if (eatChar('+')) return parseFactor(); // unary plus
                if (eatChar('-')) return -parseFactor(); // unary minus

                double x;
                int startPos = this.pos;
                if (eatChar('(')) { // parentheses
                    x = parseExpression();
                    eatChar(')');
                } else if ((ch >= '0' && ch <= '9') || ch == '.') { // numbers
                    while ((ch >= '0' && ch <= '9') || ch == '.') eatChar();
                    x = Double.parseDouble(str.substring(startPos, this.pos));
                } else if (ch >= 'a' && ch <= 'z') { // functions
                    while (ch >= 'a' && ch <= 'z') eatChar();
                    String func = str.substring(startPos, this.pos);
                    x = parseFactor();
                    if (func.equals("sqrt")) x = Math.sqrt(x);
                    else if (func.equals("sin")) x = Math.sin(Math.toRadians(x));
                    else if (func.equals("cos")) x = Math.cos(Math.toRadians(x));
                    else if (func.equals("tan")) x = Math.tan(Math.toRadians(x));
                    else throw new RuntimeException("Unknown function: " + func);
                } else {
                    throw new RuntimeException("Unexpected: " + (char)ch);
                }

                eatSpace();
                if (eatChar('^')) x = Math.pow(x, parseFactor()); // exponentiation

                return x;
            }
        }.parse();
    }
}
