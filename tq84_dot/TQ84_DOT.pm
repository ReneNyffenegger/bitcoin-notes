package TQ84_DOT;
use warnings;
use strict;

my $dot_fh;
my $dot_file_path;
my $out_path = "../web/umls/";
my $filename_without_suffix;

sub start { #_{

     $filename_without_suffix = shift;
  my $title                   = shift // "Without title";
     $dot_file_path = "$out_path$filename_without_suffix.dot";

  open ($dot_fh, '>', $dot_file_path) or die;

  print $dot_fh <<D;
digraph G {
  
    fontname="Helvetica";
    node [shape=plaintext];
    edge [arrowhead=normal];

    label="$title"; labelloc=t;
  
D

} #_}

sub end { #_{

  print $dot_fh '}
';

  run_dot('png');
  run_dot('pdf');

} #_}

sub run_dot { #_{

  my $out_type = shift;
  system "dot $dot_file_path -T$out_type -o$out_path$filename_without_suffix.$out_type\n";

} #_}

sub open { #_{

# print system "dot $dot_file_path -T$out_type -o$out_path$filename_without_suffix.$out_type\n";

  my $pdf_path = "$out_path$filename_without_suffix.pdf"; 
  if ($^O eq 'MSWin32') {
    $pdf_path =~ s!/!\\!g;
    system $pdf_path;
  }
  else {
    system "okular $pdf_path";
  }
} #_}

sub class { #_{
  my $class_name = shift;
 (my $class_name_clean = $class_name) =~ tr/a<>/a__/;
  my $class_name_html = html_decode($class_name);
print $dot_fh <<DOT 
  $class_name_clean [
    label=<
      <table border="1" cellborder="0">
        <tr><td align="left"><font face="Helvetica"><b>$class_name_html</b></font></td></tr>
DOT

} #_}

sub file { #_{
  my $filename = shift;
print $dot_fh <<DOT 
      <tr><td align="left"><font face="Courier" point-size="8">$filename</font></td></tr>
DOT

} #_}

sub attribute { #_{
  my $attribute_name = shift;

  my $opts = shift;


  print $dot_fh "<tr><td align=\"left\" port=\"$attribute_name\"><font face=\"Helvetica\">$attribute_name</font>";
  if (exists $opts->{type}) {
    print $dot_fh "<font color=\"grey\">: $opts->{type}</font>";
  }
  method_or_attribute_comment($opts);


  print $dot_fh "</td></tr>\n";

} #_}

sub method { #_{
  my $method_name = shift;
  my $opts = shift;

print $dot_fh "<tr><td align=\"left\"><font face=\"Helvetica\" color=\"blue\">$method_name()</font>";

  method_or_attribute_comment($opts);
  print $dot_fh "</td></tr>\n";

} #_}

sub comment { #_{
  my $comment = shift;
print $dot_fh <<DOT 
      <tr><td align="left"><font face="Helvetica" color="green" point-size="9"><i>$comment</i></font></td></tr>
DOT

} #_}

sub method_or_attribute_comment { #_{

   my $opts = shift;
   
   if ($opts->{comment}) {
      print $dot_fh "<br align=\"left\"/><font color=\"green\" point-size=\"8\">$opts->{comment}<br align=\"left\"/></font>";
   }
} #_}

sub derives_from { #_{

  my $derived_class = shift;
  my $base_class    = shift;

 (my $derived_clean = $derived_class) =~ tr/a<>/a__/;
 (my $base_clean    = $base_class  ) =~ tr/a<>/a__/;

  print $dot_fh "  $base_clean -> $derived_clean [arrowhead=invempty arrowtail=none dir=both];\n";

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

  print $dot_fh "  $from -> $to [dir=$opts{dir}$arrowhead];\n";
} #_}

sub same_rank { #_{
  print $dot_fh "  {rank=same ";

  print $dot_fh "$_ " for @_;

  print $dot_fh "}\n";


} #_}

sub class_end { #_{
print $dot_fh <<DOT 
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
