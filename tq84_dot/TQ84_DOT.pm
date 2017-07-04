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
  if ($^O eq 'MSWin32') {
    system "$filename_without_suffix.$out_type";
  }
  else {
    system "okular $filename_without_suffix.$out_type";
  }
} #_}

sub class { #_{
  my $class_name = shift;
 (my $class_name_clean = $class_name) =~ tr/a<>/a__/;
  my $class_name_html = html_decode($class_name);
print $dot <<DOT 
  $class_name_clean [
    label=<
      <table border="1" cellborder="0">
        <tr><td align="left"><font face="Helvetica"><b>$class_name_html</b></font></td></tr>
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

sub method_or_attribute_comment { #_{

   my $opts = shift;
   
   if ($opts->{comment}) {
      print $dot "<br align=\"left\"/><font color=\"green\" point-size=\"8\">$opts->{comment}<br align=\"left\"/></font>";
   }
} #_}

sub derives_from { #_{

  my $derived_class = shift;
  my $base_class    = shift;

 (my $derived_clean = $derived_class) =~ tr/a<>/a__/;
 (my $base_clean    = $base_class  ) =~ tr/a<>/a__/;

  print $dot "  $base_clean -> $derived_clean [arrowhead=invempty arrowtail=none dir=both];\n";

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

sub html_decode { #_{
  my $text = shift;
  $text =~ s/&/&amp;/g;
  $text =~ s/>/&gt;/g;
  $text =~ s/</&lt;/g;

  return $text;
} #_}

1;
