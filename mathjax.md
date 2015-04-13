Recuerde que una gramática $G$ es una cuaterna $G=(Σ,V,P,S)$.

1. $\sum$ es el conjunto de terminales.
2. $V$ es un conjunto (disjunto de $\sum$) que se denomina conjunto de variables sintácticas o categorías gramáticales,
3. $P$ es un conjunto de pares de $V \times (V \cup Σ)^∗$. En vez de escribir un par usando la notación $(A,α) \in P$ se escribe $A \to α$. Un elemento de $P$ se denomina producción.
4. Por último, $S$ es un símbolo del conjunto $V$ que se denomina símbolo de arranque.<br>Dada una gramática $G=(Σ,V,P,S)$ se denota por $L(G)$ o lenguaje generado por $G$ al lenguaje: <br> $$L(G)={x \in \sum^\ast : S \ast_\Rightarrow x}$$ <br> Esto es, el lenguaje generado por la gramática G esta formado por las cadenas de terminales que pueden ser derivados desde el símbolo de arranque.

Esta es la gramática para nuestra práctica:
Σ={;=,ID,P,IF,THEN,<,>,<=,>=,==,!=,+,∗,(,),NUM},
V={statements,statement,condition,expression,term,factor}
Productions:
statements → statement ';' statements | statement
statement → ID '=' expression | P expression | IF condition THEN statement
condition → expression ('=='|'!='|'<'|'<='|'>'|'>=') expression
expression → term '+' expression | term
term → factor '*' term | factor
factor → '(' expression ')' | ID | NUM
Start symbol: statements
