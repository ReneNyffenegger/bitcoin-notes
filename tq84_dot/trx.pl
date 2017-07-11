#!/usr/bin/perl
use warnings;
use strict;

use lib '/home/rene/github/lib/perl-GraphViz-ClassDiagram/lib/';

use GraphViz::ClassDiagram;

my $class_diagram = GraphViz::ClassDiagram->new("trx.pdf");

$class_diagram->title("Bitcoin TRX classes");

$class_diagram->create();
