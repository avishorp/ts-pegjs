// Simple Arithmetics Grammar
// ==========================
//
// Accepts expressions like "2 * (3 + 4)" and computes their value.

Expression
  = head:Term tail:(_ ("+" / "-") _ Term)* <number>{
      return tail.reduce(function(result: number, element: [any,string,any,number]) {
        if (element[1] === "+") { return result + element[3]; }
        if (element[1] === "-") { return result - element[3]; }
      }, head);
    }

Term
  = head:Factor tail:(_ ("*" / "/") _ Factor)* <number>{
      return tail.reduce(function(result: number, element: any[]) {
        if (element[1] === "*") { return result * element[3]; }
        if (element[1] === "/") { return result / element[3]; }
      }, head);
    }

Factor
  = "(" _ expr:Expression _ ")" <number>{ return expr; }
  / Integer

Integer "integer"
  = _ [0-9]+ <number>{ return parseInt(text(), 10); }

_ "whitespace"
  = [ \t\n\r]*
