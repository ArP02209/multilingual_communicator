#!/usr/bin/perl

use utf8;
use Encode;

$| = 1;
while (<>) {
  $_ = decode("utf-8",$_);
  chomp;
  if (/^> (.*)/) {
    $word = $1;
    next;
  }
  if (/^no result for /) {
    next;
  }

  s/schla:äge:<>n:<><V>:<><SUFF>/schlag<V>:<><SUFF>/;
  s/ma:ärschi:<>e:<>r:<>e:<>n:<><V>:<><SUFF>/marsch<V>:<><SUFF>/;
  s/bre:üche:<>n:<><V>:<><SUFF>/bruch<V>:<><SUFF>/;
  s/schi:üe:<>ß:se:<>n:<><V>:<><SUFF>/schuss<V>:<><SUFF>/;
  s/schi:ue:<>ß:se:<>n:<><V>:<><SUFF>/schuss<V>:<><SUFF>/;
  s/ko:üm:nm:f<>:te:<>n:<><V>:<><SUFF>/kunft<V>:<><SUFF>/;
  s/fa:älle:<>n:<><V>:<><SUFF>/fall<V>:<><SUFF>/;


  # Jugendlicher
  s/<ADJ>:<>((<>:[a-z])*<Sup>:<><ADJ>:<><SUFF>:<>)?<SUFF>:<><\+NN>/<ADJ>:<>$1e<+NN>/;
  # Geliebter
  s/<>:e<>:t<PPast>:<><ADJ>:<><SUFF>:<><SUFF>:<>/ete/;
  s/<>:t<PPast>:<><ADJ>:<><SUFF>:<><SUFF>:<>/te/;
  s/<>:e<>:n<PPast>:<><ADJ>:<><SUFF>:<><SUFF>:<>/ene/;
  # Abschluss
  s/ß:se:<>n:<><V>:<><SUFF>:<><NEWORTH>:s/ß<V>:<>/;
  s/s:<>s:ß/ss/g;

  s/<(PPres|PPast)>:(<>|e<>:n<>:d)(<SUFF>:<><\+ADJ>:<><Pos>.*)/$2$3<$1>/;

  my $flag;
  $flag = $1 if s/<(CAP|SS|UC|GUESSER|ASCII)>:<>//;
  s/<(VPART|NEWORTH|OLDORTH|DA|GA|GD|GDA|MN|NA|NDA|NGA|NGDA|PA)>:<>//g;
  s/<(VPART|NEWORTH|OLDORTH|DA|GA|GD|GDA|MN|NA|NDA|NGA|NGDA|PA)>:/<>:/g;
  s/In<SUFF>/in<SUFF>/g;

  if (!/<\+VPART>/ && s/^(.*<[A-Z]+>:<>)//) {
    $x = $1;
    $x =~ s/<[^<>]*>://g;
    $x =~ s/[^\\]://g;
    $x =~ s/<>//g;
    $x =~ s/<>//g;
    if ($flag eq 'CAP' or $flag eq 'UC') {
      $x =~ tr/[A-ZÄÖÜ]/[a-zäöü]/;
      $x = ucfirst($x) if $_ =~ /<\+N/;
    }
    $_ = $x.$_;
  }

  s/([^\\]):<[^<>]*>/$1/g;
  s/([^\\]):./$1/g;
  s/<>//g;
  s/\\:/:/g;

  if (s/(<[^<>]*>.*)//) {
    my $tag2;
    $tag = $1;
    $tag =~ s/<(Old|Simp)>//;
    if (s/^(.*-)?([^A-Za-zÀ-ÿ]*)(.)(.*[a-zäöüß][A-ZÄÖÜ][a-zäöüß].*)//) {
      $_ = $1.$2.$3.lowercase($4);
    }
    $tag =~ s/<\^ABBR>//;
    $tag =~ s/^<\+(NN|CARD|ADV|ART|TRUNC)>(.*)/$1$2/;
    $tag =~ s/^<\+ADJ>(.*)<(Adv|Pred)>/ADJD$1/;
    $tag =~ s/^<\+ADJ>/ADJA/;
    $tag =~ s/^<\+ORD>/ADJA.Pos/;
    $tag =~ s/^<\+PUNCT>/\$./;
    $tag =~ s/^<\+(PUNCT|Norm)>/\$./;
    $tag =~ s/^<\+REL><Subst>/PRELS/;
    $tag =~ s/^<\+REL><Attr>/PRELAT/;
    $tag =~ s/^<\+DEM><Subst>/PDS/;
    $tag =~ s/^<\+DEM><Attr>/PDAT/;
    $tag2 = "PDS$1" if $tag =~ s/^<\+DEM><Pro>(.*)/PDAT$1/;
    $tag =~ s/^<\+INDEF><Attr>(.*)/PIAT$1/;
    $tag =~ s/^<\+INDEF><Subst>(.*)/PIS$1/;
    $tag2 = "PIS$1" if $tag =~ s/^<\+INDEF><Pro>(.*)/PIAT$1/;
    $tag =~ s/^<\+PROADV>(.*)/PAV$1/;
    $tag =~ s/^<\+WADV>(.*)/PWAV$1/;
    $tag =~ s/^<\+WPRO><Attr>(.*)/PWAT$1/;
    $tag =~ s/^<\+WPRO><Subst>(.*)/PWS$1/;
    $tag2 = "PWS$1" if $tag =~ s/^<\+WPRO><Pro>(.*)/PWAT$1/;
    $tag =~ s/^<\+PPRO><(Refl|Rec)>(.*)/PRF$2/;
    $tag =~ s/^<\+PPRO><(Pers|Prfl)>(.*)/PPER$2/;
    $tag =~ s/^<\+POSS><Attr>(.*)/PPOSAT$1/;
    $tag =~ s/^<\+POSS><Subst>(.*)/PPOSS$1/;
    $tag2 = "PPOSS$1" if $tag =~ s/^<\+POSS><Pro>(.*)/PPOSAT$1/;
    $tag =~ s/^<\+NPROP>(.*)/NE$1/;
    $tag =~ s/^<\+CONJ>(.*)/KON$1/;
    $tag =~ s/^<\+PTCL><Ans>(.*)/PTKANT$1/;
    $tag =~ s/^<\+PTCL><zu>(.*)/PTKZU$1/;
    $tag =~ s/^<\+PTCL><Adj>(.*)/PTKA$1/;
    $tag =~ s/^<\+PTCL><Neg>(.*)/PTKNEG$1/;
    $tag =~ s/^<\+PREP>(.*)/APPR$1/;
    $tag =~ s/^<\+POSTP>(.*)/APPO$1/;
    $tag =~ s/^<\+CIRCP>(.*)/APZR$1/;
    $tag =~ s/^<\+INTJ>(.*)/ITJ$1/;
    $tag =~ s/^<\+SYMBOL>(.*)/XY$1/;
    $tag =~ s/^<\+CHAR>(.*)/XY$1/;
    $tag =~ s/^<\+PREPART>(.*)/APPRART$1/;
    $tag =~ s/^<\+VPRE>(.*)/PTKVZ$1/;
    $tag =~ s/^<\+VPART>(.*)/PTKVZ$1/;
    $tag =~ s/^<\+V><Inf><zu>(.*)/VVIZU$1/;
    $tag =~ s/^<\+V><Inf>(.*)/VVINF$1/;
    $tag =~ s/^<\+V>(<[123]+>.*)/VVFIN$1/;
    $tag =~ s/^<\+V><Imp>(.*)/VVIMP$1/;
    $tag =~ s/^<\+V><PPast>(.*)/VVPP$1/;
    next if $tag =~ s/^<\+V><PPres>(.*)/VVPPres$1/;

    $tag =~ s/</./g;
    $tag =~ s/>//g;

    s/\{(.*?)\}-/$1-/g;
    if (defined $tag2) {
	$tag2 =~ s/</./g;
	$tag2 =~ s/>//g;
	printline($word, "$tag2 $_");
    }
    $_ = "$tag $_";
  }

  printline($word,$_);
}


sub printline {
  my $word = shift;
  my $tag = shift;
  if ($word ne $lastword) {
    undef %analysis;
    $lastword = $word;
  }
  unless (exists $analysis{$_}) {
    my $output = "$word\t$tag\n";
    print encode("utf-8", $output);
    $analysis{$tag} = 1;
  }
}

sub lowercase {
  $s = shift;
  $s =~ tr/[A-ZÄÖÜ]/[a-zäöü]/;
  return $s;
}
