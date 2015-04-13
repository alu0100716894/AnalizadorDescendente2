Recuerde que una gramática $G$ es una cuaterna $G=(\Sigma,V,P,S)$.

1. $\Sigma$ es el conjunto de terminales.
2. $V$ es un conjunto (disjunto de $\Sigma$) que se denomina conjunto de variables sintácticas o categorías gramáticales,
3. $P$ es un conjunto de pares de $V \times (V \cup \Sigma)^∗$. En vez de escribir un par usando la notación $(A,α) \in P$ se escribe $A \to α$. Un elemento de $P$ se denomina producción.
4. Por último, $S$ es un símbolo del conjunto $V$ que se denomina símbolo de arranque.<br>Dada una gramática $G=(\Sigma,V,P,S)$ se denota por $L(G)$ o lenguaje generado por $G$ al lenguaje: <br> $$L(G)=\\{x \in \Sigma^\ast : S \stackrel{*}{\Longrightarrow} x\\}$$ <br> Esto es, el lenguaje generado por la gramática $G$ esta formado por las cadenas de terminales que pueden ser derivados desde el símbolo de arranque.

Esta es la gramática para nuestra práctica:

1. $\Sigma = \\{;=,ID,P,IF,THEN,<,>,<=,>=,==,!=,+,∗,(,),NUM\\},$
2. $V=\\{statements,statement,condition,expression,term,factor\\}$
3. Productions: <br> statements $\to$ statement ';' statements | statement <br> statement $\to$ ID '=' expression | P expression | IF condition THEN statement <br> condition $\to$ expression ('=='|'!='|'<'|'<='|'>'|'>=') expression <br> expression $\to$ term '+' expression | term <br> term $\to$ factor '*' term | factor <br> factor $\to$ '(' expression ')' | ID | NUM
4. Start symbol: $statements$
