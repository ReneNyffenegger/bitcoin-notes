package TQ84_DOT;
use warnings;
use strict;

my $dot;
my $filename_without_suffix;

sub start { #_{

  $filename_without_suffix = shift;
  open ($dot, '>', "$filename_without_suffix.dot") or die;

  print $dot 'digraph G {
  
    fontname="Helvetica";
    node [shape=plaintext];
    edge [arrowhead=normal];

    label="Bitcoin-Core: Wallet related classes"; labelloc=t;
  
  ';

} #_}

sub end { #_{

  print $dot '}
';

} #_}

sub open { #_{

  my $out_type = 'pdf';

  print system "dot $filename_without_suffix.dot -T$out_type -o$filename_without_suffix.$out_type\n";
  system "okular $filename_without_suffix.$out_type";
} #_}

sub class { #_{
  my $class_name = shift;
print $dot <<DOT 
  $class_name [
    label=<
      <table border="1" cellborder="0">
        <tr><td align="left"><font face="Helvetica"><b>$class_name</b></font></td></tr>
DOT

} #_}

sub file { #_{
  my $filename = shift;
print $dot <<DOT 
      <tr><td align="left"><font face="Courier" point-size="8">$filename</font></td></tr>
DOT

} #_}

sub attribute { #_{
  my $attribute_name = shift;

  my $opts = shift;
# my %opts;
# if (@_) {
#   
#   my $o = shift;
#   %opts = %$o;
# }

   print $dot "<tr><td align=\"left\" port=\"$attribute_name\"><font face=\"Helvetica\">$attribute_name</font>";
   method_or_attribute_comment($opts);


   print $dot "</td></tr>\n";

} #_}

sub method { #_{
  my $method_name = shift;
  my $opts = shift;

print $dot "<tr><td align=\"left\"><font face=\"Helvetica\" color=\"blue\">$method_name()</font>";

  method_or_attribute_comment($opts);
  print $dot "</td></tr>\n";

} #_}

sub comment { #_{
  my $comment = shift;
print $dot <<DOT 
      <tr><td align="left"><font face="Helvetica" color="green" point-size="9"><i>$comment</i></font></td></tr>
DOT

} #_}

sub method_or_attribute_comment {

   my $opts = shift;
   
   if ($opts->{comment}) {
      print $dot "<br align=\"left\"/><font color=\"green\" point-size=\"8\">$opts->{comment}<br align=\"left\"/></font>";
   }
}

sub derives_from { #_{

  my $derived_class = shift;
  my $base_class    = shift;

  print $dot "  $base_class -> $derived_class [arrowhead=invempty arrowtail=none dir=both];\n";

} #_}

sub link { #_{
  my $from = shift;
  my $to   = shift;

  my %opts;
  if (@_) {
    
    my $o = shift;
    %opts = %$o;
  }
  $opts{dir} //= 'forward';

  if ($opts{dir} eq 'back') {
    ($to, $from) = ($from, $to);
  }
  my $arrowhead = '';
  if ($opts{head}) {
    $arrowhead = " arrowhead=$opts{head}";
  }

  print $dot "  $from -> $to [dir=$opts{dir}$arrowhead];\n";
} #_}

sub same_rank { #_{
  print $dot "  {rank=same ";

  print $dot "$_ " for @_;

  print $dot "}\n";


} #_}

sub class_end { #_{
print $dot <<DOT 
      </table>
    >
  ];
DOT

} #_}
1;
