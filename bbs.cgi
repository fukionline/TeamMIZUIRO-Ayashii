#! /usr/local/bin/perl

# エラーチェック。スクリプト編集時にコメントを外してお使いください(要Perl5環境)
use CGI::Carp qw(fatalsToBrowser); 

=header1 -- ごあいさつ --

＠じょしあな + Team MIZUIRO ver3.10d  2022/07/22

所有者権限でCGIが動くサーバーの場合のパーミッション設定例

  [public_html]（ホームページディレクトリ）
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

掲示板初回起動時は管理者パスワード登録画面になります。

暗号システムが異なるサーバへ移転した場合はpassword.plを手動でクリア(中身を消して0byteにする、
またはファイル自体を削除)して再設定して下さい。

管理者モードに移行する方法は「投稿者名に管理者パスワード、投稿内容に$adminkeyで設定した
管理モード移行キーを記入して投稿ボタンを押す」です。

※スクリプトを改造する方へ
環境設定および表示パラメーター設定/分岐処理で設定したすべての変数とcore.plデコード終了後の連想配列
%FORM($FORM{'name'}..etc)%GLOB($GLOB{'img'}..etc)はグローバルとしてどこからでも参照可能としています。

詳しくは配布ページをご覧下さい。
 ＠じょしあな + Team MIZUIRO BBS 配布 & 設置の手引き
 http://taiyaki.s8.xrea.com/TeamMIZUIRO/index.html

バグ報告、ご質問はこちらにどうぞ ヽ(´ー`)ノ
 ＠じょしあな + Team MIZUIRO サンプル掲示板
 http://taiyaki.s8.xrea.com/TeamMIZUIRO/cgi-bin/bbs.cgi

=cut

##################################
# 環境設定
##################################

# ---------------- 管理モード移行キー(要変更)

$adminkey = 'admin';

# ---------------- 設定(設置環境に合わせて変更)

$title = '＠じょしあな + Team MIZUIRO サンプル掲示板'; # 掲示板の名前
$homeurl = ' http://taiyaki.s8.xrea.com/index.html';  # ホームページ
$mailadd = 'renraku@mail.de.ne'; # 連絡先
$countdate = '2000/xx/xx';       # アクセスカウンタ開始日
$countlevel = 2;                 # カウンタ強度

# 管理者名設定。最後が「ソ」で終わるＨＮをお使いの方は名前の最後に\を付けて下さい。
#（例えばエデソさんの場合：$namez='エデソ\';）
$namez = '管理人';       # 管理者パスワードで投稿時に表示される名前
$mailz = $mailadd;       # 管理者パスワードで投稿時に添付されるメールアドレス
$nameng = 'アニキ';      # ＮＧネーム（この名前で投稿するとブラウザがクラッシュ）

# 色設定(16進表記。先頭に#は不要）
$bgcdef = '004040';      # body部の色
$textc  = 'ffffff';
$linkc  = 'eeffee';
$vlinkc = 'dddddd';
$alinkc = 'ff0000';

$subjc  = 'fffffe';       # 題名の色
$resc   = 'a0a0a0';       # 引用行(> or ＞ で始まる行)の色

$numdef = 20;             # １ページに表示する件数のデフォルト値(PC用)
$nummbdef = 10;           # １ページに表示する件数のデフォルト値(Mobile用)
$nummin = 1;              # １ページに表示する件数の最小値
$nummax = 50;             # １ページに表示する件数の最大値
$l_record = 300;          # 投稿記事の最大記録件数

$l_all = 1024*1024;       # 画像を含む全ての送信データの合計(byte)
$l_width = 1920;          # 画像の横幅の最大値(px)
$l_height = 1920;         # 画像の高さの最大値(px)

$imgctrl = 'size';        # 保存画像の管理方法 size:保存ディレクトリの容量で管理(要Perl5環境) num:合計ファイル数で管理(Perl4,Perl5両用)
$l_imgdir = 50*1024*1024; # 画像保存ディレクトリの最大容量(byte)($imgctrl = 'size';の場合適用)
$l_imgnum = 50;           # 画像の最大保存数($imgctrl = 'num';の場合適用)

# 変換/表示checkboxのデフォルト値
$autolinkdef = 1;         # URL→Link自動変換(投稿時に適用)のデフォルト値 0:変換無し 1:変換あり
$imgviewdef = 1;          # 画像表示のデフォルト値。0:Linkで表示 1:画像で表示
$videodef = 0;            # Youtube動画Link→動画プレーヤ表示のデフォルト値 0:通常Linkと同じ扱い 1:iframeで動画プレーヤーを表示
$videowidth = 480;        # YouTube動画プレーヤーの横幅(px)
$videoheight = 270;       # YouTube動画プレーヤーの高さ(px)

# サーチ設定
$ngsearch = 0;            # 各種サーチで除外するキーワード 0:除外キーワード無し 1:半角or全角スペース1個 2:1文字(1byte)のキーワード
$l_search2 = 200;         # ★ボタン投稿者名サーチ結果の最大表示件数
$l_thread = 200;          # ◇/◆ボタンスレッド表示の最大表示件数
$l_logsearch = 1000;      # 過去ログ検索結果の最大表示件数
$l_keyword = 50;          # 過去ログ検索キーワードの最大値(byte)

# 投稿コードとスパム対策
$codemode = 1;            # 投稿コードモード 0:投稿コード非表示 1:PCのみ文字絵投稿コード表示 2:PC/Mobile共に文字絵投稿コード表示
$spammode = 1;            # 投稿内容(URL個数/使用言語等)によるスパム対策 0:不使用 1:アップロード画像が無い投稿のみ適用 2:すべての投稿に適用

# 投稿コード詳細
$codekey = 12345678;      # 投稿コード1 (8桁の数値、要変更)
$codesalt = 56;           # 投稿コード2 (2桁の数値、要変更)
$l_time = 6*60*60;        # 投稿コード有効期限(sec これより長い時間が経過した場合は書き込み不可)
$s_time = 5;              # 投稿間隔制限(sec これより短い間隔の書き込み不可)

# ---------------- 設定(その他)

$bbsfile = './bbs.dat';         # 内容が書き込まれる記録ファイル
$imglog = './img.dat';          # イメージファイル番号の記録ファイル
$passfile = './password.pl';    # 管理者パスワード記録ファイル
$dirinfofile = './dirinfo.dat'; # 画像ディレクトリ使用量記録ファイル($imgctrl = 'size';の場合作成/使用)
$jcpl =  './jacode.pl';         # 日本語コード変換ライブラリjaocode.plのパス
$bbscore = './core.pl';         # 掲示板コアライブラリのパス
$cssloader = './css.pl';        # CSSローダーのパス
$countdir = './count';          # カウントデータ保存ディレクトリ
$rankdir = './rank';            # ランキングデータ保存ディレクトリ
$tmpdir = './tmp';              # テンポラリファイル用ディレクトリ
$logdir = './log';              # 過去ログ保存ディレクトリ
$imgdir = './data';             # 投稿画像保存ディレクトリ

$l_name = 40;                   # 名前の最大値(byte)
$l_email = 80;                  # メールアドレスの最大値(byte)
$l_subject = 80;                # 題名の最大値(byte)
$l_value = 30*1024;             # 内容の最大値(byte)
$l_line = 200;                  # 内容の行数の最大値
$check = 5;                     # 二重書き込みチェック件数(最新-$check件までチェック)

# ※投稿ランキングについて
# 毎月2種類以上のDBファイルが自動生成されます。長期間使用する場合は定期的に古いファイルを掃除してください。
# 運用サーバーを変更した場合は古いDBファイルが使用できない場合があります。PerlやサーバーOSのバージョン更新で
# 使用できなくなる場合もあります。等々保守性が低いのでこの機能を長期間使い続けるのは非推奨とします。
$rankkey = 0;                # 投稿ランキング 0:不使用 1:使用
$rankdef = 3;                # ランキング表示件数（月単位）
$action = "fuckin";          # 投稿時のaction名
# $redirect='http://redirectorのURL'; # redirectorのURL。redirectorを使用しない場合は空欄''または#でコメントアウトして下さい

# URL自動取得
$scriptname = substr($ENV{SCRIPT_NAME}, rindex($ENV{SCRIPT_NAME}, '/') + 1);              # bbs.cgi
if($ENV{'HTTPS'}){ $serverurl = 'https://' . $ENV{'SERVER_NAME'}; }
else{ $serverurl = 'http://' . $ENV{'SERVER_NAME'}; }
if ($ENV{'SERVER_PORT'} ne '80') { $serverurl .= ':' . $ENV{'SERVER_PORT'}; }             # hhtps?://taiyaki.s8.xrea.com(:port)?
$baseurl = $serverurl . substr($ENV{SCRIPT_NAME}, 0, rindex($ENV{SCRIPT_NAME}, '/') + 1); # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/
$scripturl = $baseurl . $scriptname;                                                      # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/bbs.cgi
$imgdirurl = $baseurl . substr($imgdir, rindex($imgdir, '/') + 1) . '/';                  # https?://taiyaki.s8.xrea.com(:port)?/cgi-bin/data/

# ※上記URL自動取得が動作しない場合はすべてコメントアウトして下記の2つの変数を手動で設定してください。
# $scriptname = 'スクリプトファイル名'; $baseurl = 'http://設置サーバーのホスト名/スクリプト設置Dir/'; 
# 設定例
# $scriptname = 'bbs.cgi';
# $baseurl = 'http://taiyaki.s8.xrea.com/cgi-bin/';

# このスクリプトの相対パス
$scriptrel = './' . $scriptname;

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
$wdayja = ('日','月','火','水','木','金','土')[$wday];
$datenow = "$year年$mon月$mday日($wdayja)$hour時$min分$sec秒";

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
		elsif ($FORM{$key} eq '参考：' && $key =~ /^\d{14}$/) {
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

# ---------------- ヘッダー
sub header {

	print "Content-type: text/html\n\n";
	print <<"EOF";
<!DOCTYPE html>
<html><head>
<meta charset="shift-jis">
<meta name="viewport" content="width=device-width, initial-scale=1">
<base href="$baseurl">
<link rel="canonical" href="$baseurl$scriptname">
EOF

}

# ---------------- HTMLメイン
sub html {

	local ($usage, $imgnum, $info, @lines, $total, $page, $page_all, $start, $end, $next, $i, $j);
	local $rankinfo = qq(<a href="$scriptrel?action=ranking" target="_blank" rel="noopener noreferrer">投稿ランキングTOP10</a>) if ($rankkey);
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

	open(DB, $bbsfile) || &error("$bbsfileを開けませんでした。0byteのファイルを作成するかパスを確認してください。", __LINE__);
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
<a href="$homeurl" target="_blank" rel="noopener noreferrer">ホームページ</a> $rankinfo
<a href="mailto:$mailadd">連絡先</a>
</b></font><br><br>
EOF

	&form($FORM{'name'}, $FORM{'email'}, '', '', '', '投稿／リロード', ''); 

	print <<"EOF";
<br><br>
<font size="-1">$countdateから $counter (こわれにくさレベル$countlevel)<br>
<hr>最近の過去ログは<a href="$scriptrel?action=getlog&data=$year$mon.html&start=1&end=31" target="_blank" rel="noopener noreferrer">ここ</a>。
昔のログは<a href="$scriptrel?action=selectlog"  target="_blank" rel="noopener noreferrer">ここ</a>。
あやしいわーるど関連は<a href="http://www.geocities.com/Tokyo/Dojo/5886/link/" target="_blank" rel="noopener noreferrer">ここ</a>で調査。<br>
<hr>■フォロー投稿画面 &nbsp;★投稿者検索 &nbsp;◇スレッド(新規) &nbsp;◆スレッド(子記事)&nbsp;&nbsp; 
最大登録件数 $l_record件 &nbsp;&nbsp; 保存画像 $info
</font>
<hr><input type="submit" value="投稿／リロード">
</form>
EOF
	}
	else { # Mobileモード
		print "$body\n";

		&mbform($FORM{'name'}, $FORM{'email'}, '', '', '', '投稿／リロード', '');

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
		print "<small>&nbsp;新着順", $start + 1, '-', $end + 1, "番目の記事を表\示しました。</small>\n";
		print "<small>これ以下の記事はありません。</small>\n" if ($page == $page_all);
		print "<br>\n";
	}
	else{
		print "<br><span class='c2'>", $start + 1, '-', $end + 1, "番目の記事を表\示しました。\n";
		print "これ以下の記事はありません。" if ($page == $page_all);
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
あやしいわーるど＠じょしあな + <a href="http://taiyaki.s8.xrea.com/TeamMIZUIRO/index.html" target="_blank" rel="noopener noreferrer">TeamMIZUIRO</a> v3.10d
</font></div>
EOF
	}
print '</body></html>';
exit;

}

