#!/usr/bin/env perl 
use strict;
use warnings;
use EBook::EPUB;
use Getopt::Long;
my $race = 'race';
GetOptions ( "race=s" => \$race );

my $epub = EBook::EPUB->new;
 
# Set metadata: title/author/language/id
$epub->add_title(sprintf "CAST: $race [%s]", localtime);
$epub->add_language('en');
 
my $page = 1;
foreach my $data (@ARGV) {
  warn "DATA: $data\n";
  $epub->add_navpoint( label       => "CAST $page"
                     , id          => $epub->copy_file("./$data", $data, 'image/jpeg') # TODO
                     , content     => $data
                     , play_order  => $page 
                     );
  $page++;
}
  
$epub->pack_zip("CAST_$race.epub");
__END__

#$epub->add_author('Jerome K. Jerome');
#$epub->add_identifier('1440465908', 'ISBN');
# Add package content: stylesheet, font, xhtml and cover
#$epub->copy_stylesheet('/path/to/style.css', 'style.css');



#$epub->copy_file('/path/to/figure1.png', 'figure1.png', 'image/png');
#$epub->encrypt_file('/path/to/CharisSILB.ttf', 'CharisSILB.ttf', 'application/x-font-ttf');
#my $chapter_id = $epub->copy_xhtml('/path/to/page1.xhtml', 'page1.xhtml');
#$epub->copy_xhtml('/path/to/notes.xhtml', 'notes.xhtml', linear => 'no');
 
# Add top-level nav-point
my $navpoint = $epub->add_navpoint(
        label       => "Chapter 1",
        id          => $chapter_id,
        content     => 'page1.xhtml',
        play_order  => 1 # should always start with 1
);
 
# Add cover image
# Not actual epub standart but does the trick for iBooks
#my $cover_id = $epub->copy_image('/path/to/cover.jpg', 'cover.jpg');
#$epub->add_meta_item('cover', $cover_id);
 



