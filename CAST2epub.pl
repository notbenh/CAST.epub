#!/usr/bin/env perl 
use strict;
use warnings;
use EBook::EPUB;
use Getopt::Long;
my $race   = 'race';
my $height = 600;
my $width  = 800;
my $fg     = 'white';
my $bg     = 'black';
my $font_file = 'Impact.ttf';
my $font_factor = 1.1;

GetOptions ( "race=s"   => \$race 
           , "height=i" => \$height
           , "width=i"  => \$width
           , "fg=s"     => \$fg
           , "bg=s"     => \$bg
           , "font=s"   => \$font_file
           , "factor=s" => \$font_factor
           );
use Imager;
 
my $font = Imager::Font->new(file=> $font_file)
       or die "Cannot load $font_file ", Imager->errstr;
 
mkdir($race);

my $epub = EBook::EPUB->new;
$epub->add_language('en');
$epub->add_title(sprintf "CAST: $race [%s]", localtime);

my $i = 1;
foreach my $CAST (@ARGV) {
  my $image = Imager->new(xsize => $width, ysize => $height);
  $image->box(filled=>1, color=>$bg); #background
   
  $font->align( string => $CAST,
              , size => $height/$font_factor
              , color => $fg
              , x => $image->getwidth/2
              , y => $image->getheight/2
              , halign => 'center'
              , valign => 'center'
              , image => $image
              );
   
  my $filename = sprintf "%s/%04d.jpg", $race, $i;
  $image->write(file=>$filename)
      or die "Cannot save $filename ", $image->errstr;
  my $id = $epub->copy_image($filename, "$i.jpg", "image/jpeg");
  #my $data;
  #$image->write(data=>\$data, type=>"jpeg")
  #    or die "Cannot save $filename ", $image->errstr;
  #my $id = $epub->add_image($filename, $data, "image/jpeg");
  
  $i++;
}
  
$epub->pack_zip("CAST_$race.epub");
