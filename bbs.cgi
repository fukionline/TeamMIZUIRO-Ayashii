#! /usr/bin/perl

# Error Checking. Please uncomment when editing scripts (Perl5 environment required).
use CGI::Carp qw(fatalsToBrowser); 

=header1 -- Intro --

@joshiana + Team MIZUIRO ver3.10d 2022/07/22

Example of permission settings for a server where CGI runs with owner authority

  [public_html] (home page directory)
        |
        |---- [cgi-bin]（701）
                  |
                  |-- bbs.cgi  (700)
                  |-- core.pl  (600)
                  |-- css.pl   (600)
                  |-- jacode.pl(600)
                  |                  
                  |-- bbs.dat(600)
                  |-- img.dat(600)
                  |-- dirinfo.dat(600)
                  |-- password.pl(600)
                  |
                  |-- [count](700)
                  |-- [rank] (700)
                  |-- [tmp]  (700)
                  |-- [data] (701)
                  |-- [log]  (701)

When the BBS is launched for the first time, the administrator password registration screen will be displayed.

If you move to a server with a different encryption system, please clear password.pl manually (delete the contents to 0 bytes
or delete the file itself) and then reset the password.

The way to switch to admin mode is to "enter the admin password in the submitter's name, the adminkey set in $adminkey in the post content, and press the submit button.
adminkey" and press the "Submit" button.

*For those who modify the script
All variables set in preferences and display parameter settings/branching process and associative array after core.pl decoding
%FORM($FORM{'name'}..etc)%GLOB($GLOB{'img'}..etc)is assumed to be global and can be referenced from anywhere.

Please see the distribution page for details.
 @Joshiana + Team MIZUIRO BBS Distribution & Installation Guide
 http://taiyaki.s8.xrea.com/TeamMIZUIRO/index.html

Please report bugs or ask questions here.
 @Joshiana + Team MIZUIRO Sample Bulletin Board
 http://taiyaki.s8.xrea.com/TeamMIZUIRO/cgi-bin/bbs.cgi

=cut

##################################
# Configurating
##################################

# ---------------- ADMIN PASS (CHANGE THIS!)

$adminkey = 'admin';

# ---------------- 設定(設置環境に合わせて変更)

$title = 'MiniBBS Team MIZUIRO Sample Board'; # Bulletin Board Name
$homeurl = ' http://taiyaki.s8.xrea.com/index.html';  # Home Page
$mailadd = 'renraku@mail.de.ne'; # Contact email
$countdate = '2000/xx/xx';       # Access Counter Start Date
$countlevel = 2;                 # Counter Intensity

# Admin name setting. If you are using an HN that ends with "so", please add \ at the end of your name.
# (For example, for Mr. Edeso: $namez='Edeso\';)
$namez = 'Kanririn';       # Name displayed when posting with admin password
$mailz = $mailadd;       # Email address attached when posting with admin password
$nameng = 'IDunnoWhatThisDoes';      # NG name (browser crashes when posting with this name)

# Color setting (hexadecimal notation. Dont add a hashtag to the beginning)
$bgcdef = '004040';      # Background color
$textc  = 'ffffff';
$linkc  = 'eeffee';
$vlinkc = 'dddddd';
$alinkc = 'ff0000';

$subjc  = 'fffffe';       # Subject
$resc   = 'a0a0a0';       # Greentext

$numdef = 20;             # Default number of items displayed per page (for PC)
$nummbdef = 10;           # Default number of items displayed per page (for Mobile)
$nummin = 1;              # Minimum number of items to be displayed on one page
$nummax = 50;             # Maximum number of items to be displayed on one page
$l_record = 300;          # Maximum number of postd

$l_all = 1024*1024;       # Maximum image size (measured in bytes)
$l_width = 1920;          # Maxmium image width (measured in px)
$l_height = 1920;         # Maximum image height (measured in px)

$imgctrl = 'size';        # How to manage saved images size: managed by storage directory size (Perl5 environment required) num: managed by total number of files (for both Perl4 and Perl5)
$l_imgdir = 50*1024*1024; # Maximum size of image storage directory (in bytes) (applicable if $imgctrl = 'size';)
$l_imgnum = 50;           # Maximum number of images to store (applicable if $imgctrl = 'num';)

# Default value for conversion/display checkbox
$autolinkdef = 1;         # Default value for URL→Link auto-conversion (applied when posting) 0: without conversion 1: with conversion
$imgviewdef = 1;          # Default value for image display. 0: Display as Link 1: Display as Image
$videodef = 0;            # Youtube Video Link→Default value of video player display 0:Same as normal Link 1:Display video player in an iframe
$videowidth = 480;        # Width of YouTube video player (px)
$videoheight = 270;       # YouTube video player height (px)

# サーチ設定
$ngsearch = 0;            # Keywords to exclude in various searches 0:No excluded keywords 1:One half-width or one full-width space 2:One character (1byte) keyword
$l_search2 = 200;         # Maximum number of results displayed in the search results for the name of the contributor of the button
$l_thread = 200;          # ◇/◆Maximum number of button threads displayed
$l_logsearch = 1000;      # Maximum number of past log search results displayed
$l_keyword = 50;          # Maximum value of keywords for log search (bytes)

# 投稿コードとスパム対策
$codemode = 0;            # Posting code mode 0:Posting code hidden 1:Text picture posting code displayed only on PC 2:Text picture posting code displayed on both PC and Mobile
$spammode = 1;            # Anti-spam by post content (number of URLs/languages used, etc.) 0:Do not use 1:Apply only to posts without uploaded images 2:Apply to all posts

# Submission Code Details
$codekey = 12345678;      # Submission code 1 (8-digit number, CHANGE THIS!)
$codesalt = 56;           # Submission code 2 (2-digit number, CHANGE THIS!)
$l_time = 6*60*60;        # Posting code expiration date (sec If a longer time than this has passed, writing is not allowed.)
$s_time = 5;              # Posting interval limit (sec)

# ---------------- Setting (Other)

$bbsfile = './bbs.dat'; # Recorded file whose contents are written to
$imglog = './img.dat'; # Recorded file of image file number
$passfile = './password.pl'; # Admin password record file
$dirinfofile = './dirinfo.dat'; # image directory usage record file (created/used if $imgctrl = 'size';)
$jcpl = './jacode.pl'; # Path of the Japanese code conversion library jaocode.pl
$bbscore = './core.pl'; # Path of the BBS core library
$cssloader = './css.pl'; # path of CSS loader
$countdir = './count'; # directory to save count data
$rankdir = './rank'; # Directory for ranking data storage
$tmpdir = './tmp'; # Directory for temporary files
$logdir = './log'; # Directory for storing historical logs
$imgdir = './data'; # directory to store submitted images

$l_name = 40;                   # 名前の最大値(byte)
$l_email = 80;                  # Maximum value of e-mail address (byte)
$l_subject = 80;                # Maximum title value (byte)
$l_value = 30*1024;             # Maximum content value (byte)
$l_line = 200;                  # Maximum number of lines of content
$check = 5;                     # Number of double write checks (checks up to the latest -$check)

# *About the submission ranking.
# Two or more DB files are automatically generated each month. If you use the software for a long period of time, please clean up old files periodically.
# Old DB files may become unusable if you change the server you are using or if you update the version of Perl or server OS.
# The old DB files may not be usable if you change the operation server. It is deprecated to use this function for a long period of time due to low maintainability.

$rankkey = 0;                # Submission Ranking 0:Not used 1:Used
$rankdef = 3;                # Number of ranking displays (per month)
$action = "fuckin";          # Action name at time of submission --- by the way, I didnt edit this. Look in the og code lmao
# $redirect='http://redirectornoURL'; # redirectornoURL。redirectorIf you do not use '', comment it out with a blank '' or #.

# URL自動取得
$scriptname = substr($ENV{SCRIPT_NAME}, rindex($ENV{SCRIPT_NAME}, '/') + 1);              # bbs.cgi
if($ENV{'HTTPS'}){ $serverurl = 'https://' . $ENV{'SERVER_NAME'}; }
else{ $serverurl = 'http://' . $ENV{'SERVER_NAME'}; }
if ($ENV{'SERVER_PORT'} ne '80') { $serverurl .= ':' . $ENV{'SERVER_PORT'}; }             # hhtps?://taiyaki.s8.xrea.com(:port)?
$baseurl = $serverurl . substr($ENV{SCRIPT_NAME}, 0, rindex($ENV{SCRIPT_NAME}, '/') + 1); # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/
$scripturl = $baseurl . $scriptname;                                                      # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/bbs.cgi
$imgdirurl = $baseurl . substr($imgdir, rindex($imgdir, '/') + 1) . '/';                  # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/data/

# *If the above URL auto-retrieval does not work, comment out everything and set the following two variables manually.

# $scriptname = 'Script file name'; $baseurl = 'http://Hostname of installation server/Script installation Dir/'; 
# Example configuration
# $scriptname = 'bbs.cgi';
# $baseurl = 'http://taiyaki.s8.xrea.com/cgi-bin/';

# Relative path of this script
$scriptrel = './' . $scriptname;
##################################
# Im not translating the comments after this, assuming whom wants to install this wants a vanilla copy of the software or has a translator.
##################################

##################################
# パラメーター決定/分岐処理
##################################

# 掲示板コアライブラリ読み込み
require $bbscore;

# モバイル判定
if ($ENV{'QUERY_STRING'} =~ /mobile=1/) {
	$FORM{'mobile'} = 1;
	$scriptrel .= '?mobile=1' ;
}

# CSS読み込み
require $cssloader;
if (! $FORM{'mobile'}) { $css = &css($bgcdef, $textc, $linkc, $vlinkc, $alinkc, $subjc, $resc, 'pc'); }
else { $css = &css($bgcdef, $textc, $linkc, $vlinkc,$alinkc,$subjc, $resc, 'mobile'); }

# 時刻処理
$time = time;
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = gmtime($time + 9 * 60 * 60);
$mon++;
$year += 1900;
foreach ($sec, $min, $hour, $mday, $mon, $year) { $_ = sprintf("%02d", $_); }
$wdayja = ('Sun','Mon','Tues','Wed','Thurs','Fri','Sat')[$wday];
$datenow = "$year/$mon/$mday ($wdayja) at $hour:$min:$sec";

# 投稿コード発行
$code = ($time + $codekey) * $codesalt;

# 過去ログファイル名取得
$logfiledate = "$logdir/$year$mon.html";

#ランキングファイル名取得
$rankfile = "$rankdir/$year$mon";

# 表示用単位調整
$l_all_kb = int($l_all / 1024);
$l_all_mb = int(($l_all / 1024 / 1024) * 10) / 10;
$l_imgdir_mb = sprintf('%.f', $l_imgdir / 1024 / 1024);

# デコード
&decode;

# 表示件数の決定
if ($FORM{'num'} =~ /^\d+$/) {
	if ($FORM{'num'} < $nummin) { $num = $nummin; }
	elsif ($FORM{'num'} <= $nummax) { $num = $FORM{'num'}; }
	elsif ($nummax < $FORM{'num'}) { $num = $nummax; }
}
else {
	if (! $FORM{'mobile'}) { $num = $numdef; }
	else { $num = $nummbdef; }
}

# 表示色の決定
if ($FORM{'bgcolor'} =~ /^([0-9]|[a-f]){6}$/i) { $bgc = $FORM{'bgcolor'}; }
else { $bgc = $bgcdef; }
$body  = "<body id='top' bgcolor='#$bgc' text='#$textc' link='#$linkc' vlink='#$vlinkc' alink='#$alinkc'>";

# URL自動変換のON/OFF
if ($ENV{'REQUEST_METHOD'} eq 'GET' && !$FORM{'action'} && !$FORM{'autolink'}) { $autolink = $autolinkdef; }
elsif ($FORM{'autolink'} eq '1') { $autolink = 1; }
else { $autolink = 0; }
$chklink = ' checked' if ($autolink == 1);

# アップロード画像表示のON/OFF
if ($ENV{'REQUEST_METHOD'} eq 'GET' && !$FORM{'action'} && !$FORM{'imgview'} ) { $imgview = $imgviewdef; }
elsif ($FORM{'imgview'} eq '1') { $imgview = 1; }
else { $imgview = 0; }
$chkimg = ' checked' if ($imgview == 1);

# Youtube Video URL自動変換のON/OFF
if ($ENV{REQUEST_METHOD} eq 'GET' && ! $FORM{'action'} && ! $FORM{video}){ $video = $videodef; }
elsif ($FORM{'video'} == '1') { $video = 1;}
else { $video = 0; }
$chkvideo = ' checked' if ($video == 1);

# 戻るLink等で使用する基本パラメーターのクエリ/inputタグ
$basequery = "num=$num&bgcolor=$bgc&autolink=$autolink&imgview=$imgview&video=$video";
$baseinput = <<"EOF";
<input type="hidden" name="name" value="$FORM{'name'}">
<input type="hidden" name="email" value="$FORM{'email'}">
<input type="hidden" name="num" value="$num">
<input type="hidden" name="bgcolor" value="$bgc">
<input type="hidden" name="autolink" value="$autolink">
<input type="hidden" name="imgview" value="$imgview">
<input type="hidden" name="video" value="$video">
EOF

# ■★◇◆参考：ボタン経由のサーチパラメーター再定義
if ($ENV{'REQUEST_METHOD'} eq 'POST' && !$FORM{'action'}) {
	foreach $key (keys %FORM) {
		if ($FORM{$key} eq '■' && $key =~ /^\d{14}$/) {
			$FORM{'action'} = 'search1';
			$FORM{'search'} = $key;
			last;
		}
		elsif ($FORM{$key} eq '★' && $key =~ /^(%25[0-9a-f][0-9a-f])+$/) {
			$FORM{'action'} = 'search2';
			$FORM{'searchname'} = $key;
			last;
		}
		elsif (($FORM{$key} eq '◇' || $FORM{$key} eq '◆') && $key =~ /^\d{14}$/) {
			$FORM{'action'} = 'thread';
			$FORM{'thread'} = $key;
			last;
		}
		elsif ($FORM{$key} eq 'Ref：' && $key =~ /^\d{14}$/) {
			$FORM{'action'} = 'search1';
			$FORM{'search'} = $key;
			last;
		}
	}
}

# 掲示板初回起動時
if (!(-s $passfile)) {
	if (! $FORM{'action'}) { &passform; }
	else { &registerpass; }
	exit;
}

# 分岐処理
if ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq $action && ($FORM{'value'} || $GLOB{'img'})) { &register;  }
elsif ($FORM{'action'} eq 'ranking' && $rankkey) { &viewrank; }
elsif ($FORM{'action'} eq 'search1') { &search1; }
elsif ($FORM{'action'} eq 'search2') { &search2; }
elsif ($FORM{'action'} eq 'thread') { &thread; }
elsif ($FORM{'action'} eq 'selectlog') { &selectlog; }
elsif ($FORM{'action'} eq 'getlog') { &getlog; }
elsif ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq 'admintop') {
	&chkpass;
	&admintop;
}
elsif ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq 'passform') {
	&chkpass;
	&passform;
}
elsif ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq 'registerpass') {
	&chkpass;
	&registerpass;
}
elsif ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq 'delform') {
	&chkpass;
	&delform;
}
elsif ($ENV{'REQUEST_METHOD'} eq 'POST' && $FORM{'action'} eq 'delmsg') {
	&chkpass;
	&delmsg;
	&delform;
}
else { &html; }

##################################
# html出力
##################################

# ---------------- Header
sub header {

	print "Content-type: text/html\n\n";
	print <<"EOF";
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<!-- Line 344 of bbs.cgi if you want to change it -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<base href="$baseurl">
<link rel="canonical" href="$baseurl$scriptname">
EOF

}

# ---------------- HTML Main
sub html {

	local ($usage, $imgnum, $info, @lines, $total, $page, $page_all, $start, $end, $next, $i, $j);
	local $rankinfo = qq(<a href="$scriptrel?action=ranking" target="_blank" rel="noopener noreferrer">Submission Ranking TOP 10</a>) if ($rankkey);
	local $counter = &counter;

	if ($imgctrl eq 'size') {
		open(DB, $dirinfofile);
		$usage = <DB>;
		close(DB);
		$usage = 0 if(! $usage);
		$info = "$usage/${l_imgdir_mb}MB";
	}
	elsif ($imgctrl eq 'num') {
		opendir(DIR, $imgdir);
		$imgnum = grep(/^[^\.]/, readdir(DIR));
		close(DIR);
		$imgnum = 0 if(! $imgnum);
		$info = "$imgnum/${l_imgnum}Files";
	}

	open(DB, $bbsfile) || &error("$bbsfile could not be opened, please create a 0-byte file or check the path.", __LINE__);
	@lines = <DB>;
	close(DB);
	$total = @lines;

	if (0 < $total) {
		if ($total % $num) { $page_all = int($total / $num) + 1; }
		else{ $page_all = int($total / $num); }
	}
	else{
		$page_all = 1;
		$page = 1;
	}

	# 表示ページ番号決定
	$FORM{'page'} =~ s/\D//g;
	if (! $page) {
		if ($FORM{'start'}  || $FORM{'reload'}) { $page = 1; }
		elsif ($FORM{'end'}) { $page = $page_all; }
		elsif( 0 < $FORM{'page'} && $FORM{'page'} <= $page_all ){
			if ($FORM{'prev'}) { $page = max($FORM{'page'} - 1 , 1); }
			elsif ($FORM{'next'}) { $page = min($FORM{'page'} + 1, $page_all); }
			else { $page = $FORM{'page'}; }
		}
		elsif ($page_all < $FORM{'page'}) { $page = $page_all; }
		else{ $page = 1; }
	}
	$start = &max(($page - 1) * $num, 0);
	$end = &min(($page * $num) - 1, $total - 1);

	&header;

	print <<"EOF";
<title>$title</title>
$css
</head>
EOF

# ---------------- 上部ナビ/投稿フォーム
	if (! $FORM{'mobile'}) { # PCモード
		print <<"EOF";
$body

<font size="+1"><b>$title</b></font>
<font size="-1"><b>
<a href="./$scriptname?mobile=1">Mobile</a>
<a href="$homeurl" target="_blank" rel="noopener noreferrer">Index</a> $rankinfo
<a href="mailto:$mailadd">Contact</a>
</b></font><br><br>
EOF

	&form($FORM{'name'}, $FORM{'email'}, '', '', '', 'Post/Reload', ''); 

	print <<"EOF";
<br><br>
<font size="-1">$countdate from $counter (Debris resistance level $countlevel)<br>
<hr>The recent logs are<a href="$scriptrel?action=getlog&data=$year$mon.html&start=1&end=31" target="_blank" rel="noopener noreferrer">these</a>.
The old logs are <a href="$scriptrel?action=selectlog"  target="_blank" rel="noopener noreferrer">these</a>。
The Ayashii Warudo instance is created by <a href="http://taiyaki.s8.xrea.com/TeamMIZUIRO/index.html" target="_blank" rel="noopener noreferrer">TeamMIZUIRO</a>.<br>
<hr>■ Reply to Post &nbsp;★Poster search &nbsp;◇Thread (New) &nbsp;◆Thread (Reply)&nbsp;&nbsp; 
Maximum number of registrations $l_record件 &nbsp;&nbsp; Preserved images $info
</font>
<hr><input type="submit" value="Post／Reload">
</form>
EOF
	}
	else { # Mobileモード
		print "$body\n";

		&mbform($FORM{'name'}, $FORM{'email'}, '', '', '', 'Post/Reload', '');

		print "</form>\n";
	}

# ---------------- 記事本文
	print "<form class='article' method='POST' action='$scriptrel'>\n";
	print "$baseinput\n";

	foreach (@lines[$start .. $end]) {
		if (! $FORM{'mobile'}) {
			&disp(split(/,/, $_));
		}
		else{
			&mbdisp(split(/,/, $_));
		}
	}

	print "</form><hr>\n";

# ---------------- ページ送り
	&pagination($num, $page, $page_all);

# ---------------- 下部ナビ
	if (! $FORM{'mobile'}) {
		print "<small>&nbsp;Most Recent Arrivals", $start + 1, '-', $end + 1, "The second post is shown in the table.</small>\n";
		print "<small>We cannot find any more posts.</small>\n" if ($page == $page_all);
		print "<br>\n";
	}
	else{
		print "<br><span class='c2'>", $start + 1, '-', $end + 1, "The second post is shown in the table. \n";
		print "We cannot find any more posts.。" if ($page == $page_all);
		print "</span>\n";
	}

	print "<br><a href='$scriptrel#top'>△TOP</a>\n";

	&footer;

} # html end


# ---------------- フッター
sub footer{

	if (! $FORM{'mobile'}) {
	print <<"EOF";
<hr size="5"><div align="right"><font size="-1">
AyashiiWorld@joshiana + <a href="http://taiyaki.s8.xrea.com/TeamMIZUIRO/index.html" target="_blank" rel="noopener noreferrer">TeamMIZUIRO</a> v3.10d + <a href="https://github.com/ShockAwer/TeamMIZUIRO-Ayashii">translated by jr</a>
</font></div>
EOF
	}
print '</body></html>';
exit;

}

