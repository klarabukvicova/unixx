#!/bin/sed -Enf
# OPTIONY
# E: rozsirene regexy
# n: nevypisuj pattern space, pokud ti to explicitne nereknu prikazem p
# f: sedovy skript je soubor

#zistime, ci riadok obsahuje vyraz "A + B", skopirujeme si riadok do ulozneho priestoru

/[0-9][0-9]*( \+ |\+)[0-9][0-9]*/ {
h


#Upravime riadok, aby obsahoval iba "A B", tj. pouzijeme substitucny prikaz
#    s vhodnym regularnym vyrazom, aby upravil riadok ktory moze byt v tvare
#    "text text A + B text text C + D" na "A B"
:cele
{
s/([0-9][0-9]*)( \+ |\+)([0-9][0-9]*)/,\1 \3/
s/(.*)(,)([0-9]+ [0-9]+)(.*)/\2\3/
#na zaciatok som pridal ciarku)
#    z oboch cisel vezmem posledne dve cifry a dam ich pred ciarku
#    opakujem kym sa daju brat cifry z oboch cisel

:oboji
s/(,.*)([0-9])( .*)([0-9])/\2\4\1\3/
/,[0-9]+ [0-9]+/b oboji

#ak jednemu cislu dosli cifry, pridavam implicitne nuly, kym nedojdu cifry
# aj druhemu cislu, y konca odstranim ciarku a medzeru za nou
:prvniNe
s/(, .*)([0-9])/0\2\1/
/, [0-9]+/b prvniNe;

:druhyNe
s/(,.*)([0-9])( )/\20\1\3/
/,[0-9]+ $/b druhyNe;

s/, //
s/([0-9][0-9])/,0\1:/


#Kazdu cifru medzi ciarkou a dvojbodkou substituujem za prislusny pocet
#      znakov O (10 substitucnych prikazov).
#      Priklady:
#        ,187:
#        ,134:
#      sa substituuje za:
#        ,OOOOOOOOOOOOOOOO:
#        ,OOOOOOOO:
#      Ak je tam 10 znakov O, substituujem ich za znak 1, ak ich tam nebolo 10,
#      tak za nich pridam 0:
#        ,OOOOOO1:
#        ,OOOOOOOO0:
#      Dostal som zvysok po scitani tych troch cisel :)
#      Zostalo mi maximalne 9 znakov O. Urobim substitucie, ktore mi znaky O
#      nahradia za ich pocet:
#        ,61:
#        ,80:
#      Teraz mam dve moznosti:
#        a) za dvojbodkou su dalsie cifry:
#             nnn,61:ddee
#           Subtituciou prevediem prvu cifru medzivysledku uplne na zaciatok a
#           k cifre zvysku pridam dalsi par cifier aby som mohol pokracovat
#           vypocet:
#             6nnn,1dd:ee
#        b) za dvojbodkou uz nie su dalsie cifry:
#             nnn,61:
#             nnn,80:
#           Substituciou prevediem na:
#             16nnn
#             8nnn
#      A mam scitane.
:soucet
{

:nula
s/(,.*)(0)(.*:)/\1\3/
/,[0-9]*0[0-9]*:/ b nula
:jedna
s/(,.*)(1)(.*:)/\1O\3/
/,[0-9]*1[0-9]*:/ b jedna
:dva
s/(,.*)(2)(.*:)/\1OO\3/
/,[0-9]*2[0-9]*:/ b dva
:tri
s/(,.*)(3)(.*:)/\1OOO\3/
/,[0-9]*3[0-9]*:/ b tri
:ctyry
s/(,.*)(4)(.*:)/\1OOOO\3/
/,[0-9]*4[0-9]*:/ b ctyry
:pet
s/(,.*)(5)(.*:)/\1OOOOO\3/
/,[0-9]*5[0-9]*:/ b pet
:sest
s/(,.*)(6)(.*:)/\1OOOOOO\3/
/,[0-9]*6[0-9]*:/ b sest
:sedm
s/(,.*)(7)(.*:)/\1OOOOOOO\3/
/,[0-9]*7[0-9]*:/ b sedm
:osm
s/(,.*)(8)(.*:)/\1OOOOOOOO\3/
/,[0-9]*8[0-9]*:/ b osm
:devet
s/(,.*)(9)(.*:)/\1OOOOOOOOO\3/
/,[0-9]*9[0-9]*:/ b devet

/OOOOOOOOOO:/ s/OOOOOOOOOO:/1:/
/O:/ s/(,.*)(:)/\10\2/
/,:/ s/(,)(:)/\10\2/



s/(,)(OOOOOOOOO)([0-1]:)/\19\3/
s/(,)(OOOOOOOO)([0-1]:)/\18\3/
s/(,)(OOOOOOO)([0-1]:)/\17\3/
s/(,)(OOOOOO)([0-1]:)/\16\3/
s/(,)(OOOOO)([0-1]:)/\15\3/
s/(,)(OOOO)([0-1]:)/\14\3/
s/(,)(OOO)([0-1]:)/\13\3/
s/(,)(OO)([0-1]:)/\12\3/
s/(,)(O)([0-1]:)/\11\3/
s/(,)([0-1]:)/\10\2/
s/(.*,)([0-9])([0-1])(:)([0-9][0-9])/\2\1\3\5\4/
s/(.*,)([0-9])([0-1])(:$)/\2\1\3\4/
s/(.*)(,)(1)(:$)/\3\1/
s/(.*)(,)(0:$)/\1/
}
/:/ b soucet

#Na koniec cisla v hlavnom priestore dam ciarku
s/(.*)/\1,/

G
s/([0-9][0-9]*( \+ |\+)[0-9][0-9]*)/:\1/
s/([0-9][0-9]*)(,)(.*)(:)([0-9][0-9]*( \+ |\+)[0-9][0-9]*)/\3\1/
h
#mozna by tu melo bejt nejkay next, pokud procitam soubor
}
/[0-9][0-9]*( \+ |\+)[0-9][0-9]*/ b cele
s/\n//g
}
p
