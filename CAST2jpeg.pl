#!/usr/bin/env perl 
use strict;
use warnings;
use Getopt::Long;
my $race   = 'race';
my $height = 600;
my $width  = 800;
my $fg     = 'white';
my $bg     = 'black';
my $font_file = 'Impact.ttf';

GetOptions ( "race=s"   => \$race 
           , "height=i" => \$height
           , "width=i"  => \$width
           , "fg=s"     => \$fg
           , "bg=s"     => \$bg
           , "font=s"   => \$font_file
           );
use Imager;
 
my $font = Imager::Font->new(file=> $font_file)
       or die "Cannot load $font_file ", Imager->errstr;
 
mkdir($race);

my $i = 1;
foreach my $CAST (@ARGV) {
  my $image = Imager->new(xsize => $width, ysize => $height);
  $image->box(filled=>1, color=>$bg); #background
   
  $font->align( string => $CAST,
              , size => $height/1.5
              , color => $fg
              , x => $image->getwidth/2
              , y => $image->getheight/2
              , halign => 'center'
              , valign => 'center'
              , image => $image
              );
   
  $image->write(file=>sprintf "%s/%04d.jpg", $race, $i)
      or die "Cannot save $race/$i.jpg ", $image->errstr;
  $i++;
}
