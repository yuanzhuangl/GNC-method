# GNC-method
measures CNG distance between lines of text

The program should read the standard input using the Perl operator <>. The input will be 
provided in the following form:
d1: the dog eat homework
d2: the cat eat homework
d3: the dog and the cat eat the hot dog
d4: the dog play with the cat
d5: the cat play with the cat

We will call each line of text a ‘document’, since this is a toy example of larger document
processing. As we can see from the example above, each line will start with document
identifier, such as d1, followed by a colon, some arbitrary spaces and the document content,
which is the rest of the line.


The program should compare each document with each other document that follows it
in the order given in the input and print their CNG distance (as discussed in class). You
should use character trigrams (n = 3) and to ensure exactly the same interpretation of the
n-grams, you should use the Ngrams module over each document content.
The output format should be obvious from the following sample output (obtained from
the give sample input):
d1 d2: 36.4444444444444
d1 d3: 94.2188998879476
d1 d4: 108.626347738663
d1 d5: 120.447882539377
d2 d3: 91.2342778616658
d2 d4: 112.566859338901
d2 d5: 93.7366103490376
d3 d4: 104.966653644337
d3 d5: 119.021744036803
d4 d5: 29.3333333333333
As can be seen from the sample output, you should iterate through all document pairs in
the order that they appear in input, and print their CNG distances in the above format.

• The following code snippet shows how to get character trigrams from a piece of text
  and have them ready in an associative array: 
  $n = 3;
  my $ng = Text::Ngrams->new( windowsize => $n);
  $ng->process_text($text);
  my %a = $ng->get_ngrams( n=>$n, normalize => 1 );
  # The associative array %a contains ngrams and their frequencies.
  
run by command:
    ./GNC.pl GNC.in > GNC.out
