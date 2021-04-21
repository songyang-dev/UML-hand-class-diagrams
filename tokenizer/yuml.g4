grammar Yuml;

// YumlSpec is 1 or more lines
yumlSpec : line+ ;

// and each line defines a box or connection
line : box | connection ;
box : '[' umlClass ']' ;

// read left-2-right, ignore numbers
connection : boxName End? role? DashType role? End? boxName ;
// BoxName = class or interface name

String: [a-zA-Z1-9_]*;

boxName : '[' String ']'
| '[' 'interface;' String ']'
;

DashType : '-' // solid line
| '-.-' // dashed line
;

End : '<>' // aggregation
| '++' // composition
| 'ˆ' // inheritance
| '<' // left arrow
| '>' // right arrow
;

// String that has no ']' and quote chars
role : String ;
// name only, name+meths only, name+flds+meths
umlClass : name
| name '|' String
| name '|' String '|' String
;

// String that has no ']' and quote chars
name : String ;

// ignore whitespace
WS  : [ \t\r\n]+ -> skip ;