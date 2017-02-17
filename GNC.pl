#!/usr/bin/perl
#yuan-B00755386
use warnings;
use strict;
use Text::Ngrams;

my %d_hash;
my @file_name;
while(<>){
    while(/^(\S+?):\s*(.*)$/gi){
        my $n = 3;
        my $ng = Text::Ngrams->new( windowsize => $n);
        $ng->process_text($2);
        my %a = $ng->get_ngrams( n=>$n, normalize => 1 );
        $d_hash{$1} = \%a;
        #create a hash whose key is the document name and value is its Ngrams and frequencies
        push @file_name, $1;
        #generate a set of all files' names
    }
}
while(scalar @file_name != 0){
    my $d1_name = shift @file_name;
    my @file_name_2 = @file_name;
    while(scalar @file_name_2 != 0){
        my $d2_name = shift @file_name_2;
        my %hash;
        my @character =grep{++$hash{$_}<2}(keys $d_hash{$d1_name},keys $d_hash{$d2_name});
        my $result = 0;
        foreach(@character){
            my $f1=0;
            my $f2=0;
            $f1 = $d_hash{$d1_name}{$_} if exists $d_hash{$d1_name}{$_};
            $f2 = $d_hash{$d2_name}{$_} if exists $d_hash{$d2_name}{$_};
            $result += (2*($f1-$f2)/($f1+$f2))*(2*($f1-$f2)/($f1+$f2));
        }#calculate CNG distance
        print "$d1_name $d2_name: $result\n";
    }
}
