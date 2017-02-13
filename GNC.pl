#!/usr/bin/perl
#yuan-B00755386
use warnings;
use strict;
use Text::Ngrams;

my %d_hash;
my @file_name;
my @Output;
while(<>){
    while(/^(\S+?):\s*(.*)$/gi){
        my $n = 3;
        my $ng = Text::Ngrams->new( windowsize => $n);
        $ng->process_text($2);
        my %a = $ng->get_ngrams( n=>$n, normalize => 1 );
        my @k = keys %a;
        $d_hash{$1} = \%a;
        #create a hash whose key is the document name and value is its Ngrams and frequencies
        push @file_name, $1;
        #generate a set of all files' names
    }
}
while(scalar @file_name != 0){
    my $d1_name = shift @file_name;
    my @file_name_2 = @file_name;
    my @d1_character = keys $d_hash{$d1_name};
    while(scalar @file_name_2 != 0){
        my $d2_name = shift @file_name_2;
        my @d2_character = keys $d_hash{$d2_name};
        my %merge = map {$_ => 1} @d1_character,@d2_character;
        my @merge = keys (%merge);#generate the union set of Ngrams
        
        my @f1;
        my @f2;
        foreach(@merge){
            if (exists $d_hash{$d1_name}{$_}){push @f1,$d_hash{$d1_name}{$_} ;}
            else{push @f1,0;}
            if (exists $d_hash{$d2_name}{$_}){push @f2,$d_hash{$d2_name}{$_} ;}
            else{push @f2,0;}
        }# array of two files' ngrams frequencies
        
        my $result = 0;
        for(my $i=0;$i<scalar @f1;$i++){
            
            my $temp = (2*($f1[$i]-$f2[$i])/($f1[$i]+$f2[$i]));
            $result += ($temp*$temp);
        }#calculate CNG distance
        push @Output, "$d1_name $d2_name: $result\n";
    }
}
print @Output;
