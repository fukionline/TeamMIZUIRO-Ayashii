# core.pl v1.03 2022/06/01

##################################
# 投稿フォーム
##################################

sub form {

	local($name, $email, $value, $subject, $hpage, $button, ,$thread, $flag) = @_;
	local $reset = " <small><a href='$scriptrel' title='投稿者名その他全表\示設定のリセット'>*Reset</a></small>" if ($flag ne 'search1');
	print <<"EOF";
<form class="main" method="POST" enctype="multipart/form-data" action="$scriptrel">
<input type="hidden" name="action" value="$action">
投稿者 <input type="text" name="name" size="20" maxlength="40" value="$name">$reset<br>
メール <input type="text" name="email" size="30" value="$email"><br>
題名　 <input type="text" name="subject" size="30" value="$subject"> 
<input type="submit" value="$button"><input type="reset" value="消す"><br>
画像 <small>(GIF JPG PNG  幅${l_width}x${l_height}px サイズ${l_all_kb}KBまで)</small><br>
<input type=file size="30" name="filedata" accept=".gif,.jpeg,.jpg,.png"><br>
内容 <small>適当に改行を入れてください。画像と内容が両方とも無い状態で投稿ボタンを押すとリロードになります。</small><br>
<textarea name="value" rows="5" cols="70" wrap="off">$value</textarea>
<input type="hidden" name="hpage" value="$hpage"><br>
EOF
	if ($codemode) {
		&aacode($code);
	}
	else {
		print "<input type='hidden' name='code' value='$code'>\n";
	}

	if ($flag eq 'search1') {
		print <<"EOF";

URL自動Link<input type="checkbox" name="autolink" value="1"$chklink>
<input type="hidden" name="num" value="$num">
<input type="hidden" name="bgcolor" value="$bgc">
<input type="hidden" name="imgview" value="$imgview">
<input type="hidden" name="video" value="$video">
<input type="hidden" name="thread" value="$thread">
&nbsp;
<input type="submit" value="$button"><input type="reset" value="消す">
EOF
	}
	else {
	print <<"EOF";
<font size="-1">URL自動Link<input type="checkbox" name="autolink" value="1"$chklink>(投稿時に適用)&nbsp;
表\示件数<input type="text" name="num" size="2" value="$num">&nbsp;
背景色<input type="text" name="bgcolor" size="4" value="$bgc">&nbsp;
画像表\示<input type="checkbox" name="imgview" value="1"$chkimg>&nbsp;
YouTube動画<input type="checkbox" name="video" value="1"$chkvideo>
</font>
EOF
	}

}# form end (formタグは呼び出し元で閉じられる仕様です)

sub mbform {
	local($name, $email, $value, $subject, $hpage, $button, ,$thread, $flag) = @_;
	local $reset = " <a href='$scriptrel'>*Reset</a>" if($flag ne 'search1');
	local $pclink = "♪$counter &nbsp;<a href='./$scriptname'>PC</a>" if($flag ne 'search1');
	print <<"EOF";
<form class="main" method="POST" enctype="multipart/form-data" action="$scriptrel">
<input type="hidden" name="action" value="$action">
名前 <input type="text" name="name" size="14" value="$name">
$pclink<br>
<input type="hidden" name="email" size="12" value="$email">
題名 <input type="text" name="subject" size="14" value="$subject">
$reset<br>
<input type=file size="12" name="filedata" accept=".gif,.jpeg,.jpg,.png"><br>
<textarea name="value" rows="5" cols="37">$value</textarea>
<input type="hidden" name="hpage" value="$hpage"><br>
EOF
	if ($flag eq 'search1') { print "<input type='hidden' name='thread' value='$thread'>"; }
	if ($codemode == 2) {
		&aacode($code);
	}
	else {
		print "<input type='hidden' name='code' value='$code'>\n";
	}
	print <<"EOF";
<input type="submit" class="main" value="$button">
<input type="reset" value="消">
Lin<input type="checkbox" name="autolink" value="1"$chklink>
<input type="text" name="num" class="num" value="$num">
EOF

} # mbform end

sub aacode {

	local $code = shift;
	local($l1, $l2, $l3, $l4, $l5, $msg);
	local $codeA = substr($code, 0, -4);
	local $codeB = substr($code, -4, 4);
	local @lines = split(//, $codeB);
	foreach (@lines) {
if ($_ ==1 ) {
$l1 .= '　　■　';
$l2 .= '　　■　';
$l3 .= '　　■　';
$l4 .= '　　■　';
$l5 .= '　　■　';
}
elsif ($_== 2) {
$l1 .= '■■■　';
$l2 .= '　　■　';
$l3 .= '■■■　';
$l4 .= '■　　　';
$l5 .= '■■■　';
}
elsif ($_ == 3) {
$l1 .= '■■■　';
$l2 .= '　　■　';
$l3 .= '■■■　';
$l4 .= '　　■　';
$l5 .= '■■■　';
}
elsif ($_ == 4){
$l1 .= '■　■　';
$l2 .= '■　■　';
$l3 .= '■■■　';
$l4 .= '　　■　';
$l5 .= '　　■　';
}
elsif ($_ == 5){
$l1 .= '■■■　';
$l2 .= '■　　　';
$l3 .= '■■■　';
$l4 .= '　　■　';
$l5 .= '■■■　';
}
elsif ($_ == 6){
$l1 .= '■■■　';
$l2 .= '■　　　';
$l3 .= '■■■　';
$l4 .= '■　■　';
$l5 .= '■■■　';
}
elsif ($_ == 7){
$l1 .= '■■■　';
$l2 .= '　　■　';
$l3 .= '　■　　';
$l4 .= '■　　　';
$l5 .= '■　　　';
}
elsif ($_ == 8){
$l1 .= '■■■　';
$l2 .= '■　■　';
$l3 .= '■■■　';
$l4 .= '■　■　';
$l5 .= '■■■　';
}
elsif ($_ == 9){
$l1 .= '■■■　';
$l2 .= '■　■　';
$l3 .= '■■■　';
$l4 .= '　　■　';
$l5 .= '■■■　';
}
elsif ($_ == 0){
$l1 .= '■■■　';
$l2 .= '■　■　';
$l3 .= '■　■　';
$l4 .= '■　■　';
$l5 .= '■■■　';
}
	}
if (! $FORM{'mobile'}) { $msg = '下の4桁の数字を記入してください';}
else { $msg = '下の数字を記入' }
		print <<"EOF";
<input type="hidden" name="codeA" value="$codeA">
投稿コード <input type="text" class="code" name="codeB" size="4"><small> ($msg)</small>
<pre class="code">$l1
$l2
$l3
$l4
$l5</pre>
EOF

} # aacode end

##################################
# 記事の出力
##################################

sub disp {

	# ヌルコードに変換記録した半角カンマを復元
	foreach (@_) { $_ =~ s/\x00/,/g; } 
	local($date, $name, $email, $value, $subject, $hpage, $img, $w, $h, $search, $code, $thread, $flag) = @_;
	local $datenum = &digit($date);
	local( $mark, $thbutton, $size, $tagfront, $tagrear, $vflag, @vlines, $refdate, $refdatenum);
	# 旧バージョンデータ混在時用の安全装置
	chomp($thread); 

	print "<hr><font size='+1' color='#$subjc'><b>$subject</b></font>";

	if ($email) { print "　投稿者：<b><a href='mailto:$email'>$name</a></b>\n"; }
	else { print "　投稿者：<font color='#$subjc'><b>$name</b></font>\n"; }

	print <<"EOF";
<font size="-1">　投稿日：$date</font> &nbsp;
<input class="search" type="submit" name="$datenum" value="■">&nbsp;
<input class="search" type="submit" name="$search" value="★">&nbsp;
EOF

	if (&digit($date) == $thread) { print "<input class='search' type='submit' name='$thread' value='◇'>"; }
	elsif ($thread) { print "<input class='search' type='submit' name='$thread' value='◆'>"; }

	print '<p><blockquote><pre>';

	# 旧バージョンのWEB画像イメタグが残っていたらリンクに変換する
	$value =~ s!<img src="([^"]+)">!<a href="$1" target="_blank" rel="noopener noreferrer">$1</a>!gi; 

	if ($w && $h) { $size = " width='$w' height='$h'"; }
	else { $size = ' width="640" height="480"'; } # 安全装置

	if (($imgview == 0 || $flag eq 'search2' || $flag eq 'thread' || ! (-e "$imgdir/$img")) && $img) { 
		if (-e "$imgdir/$img") {
			print "<font color='#ff69b4'>アップロード画像：</font><a href='$imgdir/$img' target='_blank' rel='noopener noreferrer'>$img</a>\n";
		}
		else {
			print "<font color='#ff69b4'>アップロード画像：</font><font color='#$resc'>$img (削除済み)</font>\n";
		}
	}
	elsif ($img) {
		print "<img src='$imgdir/$img'$size>\n";
	}

	print "\n" if ($value && $img);

	if ($value) {
		$tagfront = "<iframe src='https://www.youtube.com/embed/";
		$tagrear = "' width='$videowidth' height='$videoheight' frameborder='0' rel='0' allowfullscreen></iframe>";
		@vlines = split(/\r/, $value);
		$vflag = 0;
		foreach (@vlines) {
			if (/^(&gt;|＞)/) {
				$_ = "<font color='#$resc'>$_</font>";
			}
			elsif ($video == 1 && ! $vflag && $flag ne 'search2' && $flag ne 'thread') {
				if (m!^[^<]*?<a href="https\://youtu\.be/! && ! $vflag) {
					$_ =~ s!^([^<]*?)<a href="https\://youtu\.be/([\w\-]+)[^"]*"[^>]*>[^<]*</a>(.*)$!$1$tagfront$2$tagrear$3!;
					$vflag++;
				}
				elsif (m!^[^<]*?<a href="https\://www\.youtube\.com/! && ! $vflag && $flag ne 'search2') {
					$_ =~ s!^([^<]*?)<a href="https\://www\.youtube\.com/(embed/|v/|watch\?v=)([\w\-]+)[^"]*"[^>]*>[^<]+</a>(.*)$!$1$tagfront$3$tagrear$4!;
					$vflag++;
				}
				elsif (m!^[^<]*?<a href="https\://www\.youtube\-nocookie\.com/! && ! $vflag && $flag ne 'search2') {
					$_ =~ s!^([^<]*?)<a href="https\://www\.youtube\-nocookie\.com/embed/([\w\-]+)[^"]*"[^>]*>[^<]+</a>(.*)$!$1$tagfront$2$tagrear$3!;
					$vflag++;
				}
			}
		}
		$value = join("\n", @vlines);
		$value =~ s!<a href="(https?://[^"]+)">[^<]+</a>!<a href="$redirect?$1" target="_blank" rel="noopener noreferrer">$1</a>!g if ($redirect);
		print "$value";
	}

	print "</pre><p>\n";

	# hpage関連のURLには./$scriptnameを使用
	if ($hpage =~ m!^\./$scriptname\?action=search1&search=(.*)$! && ! $FORM{'mobile'}) {
		$refdate = $1;
		$refdatenum = &digit($refdate);
		$hpage = "./$scriptname?action=search1&search=$refdatenum";
		print "<label><input class='rel' type='submit' name='$refdatenum' value='参考：'>";
		print "$refdate</label>\n";
	}

	print "</blockquote>\n";

} # disp end

sub mbdisp {

	foreach (@_) { $_ =~ s/\x00/,/g; } 
	local($date, $name, $email, $value, $subject, $hpage, $img, $w, $h, $search, $code, $thread, $flag) = @_;
	local $datenum = &digit($date);
	local( $mark, $thbutton, $size, $tagfront, $tagrear, $vflag, @vlines, $refdate, $refdatenum);
	chomp($thread); # 旧バージョンデータ混在時用
	(local $prtdate = $date) =~ s!.{6}(\d\d)..(\d\d)..(.{4})(\d\d)..(\d\d).*$!$1/$2$3$4:$5!;

	print "<hr>$subject ";
	print "：$prtdate &nbsp;<input class='search' type='submit' name='$datenum' value='■'>&nbsp;\n";
	if ($datenum == $thread) { print "<input class='search' type='submit' name='$thread' value='◇'>"; }
	elsif ($thread) { print "<input class='search' type='submit' name='$thread' value='◆'>"; }
	print "<br>\n";
	if ($email) { print "名前：<a href='mailto:$email'>$name</a>&nbsp;\n"; }
	else { print "名前：$name&nbsp;\n"; }
	# 旧バージョンのWEB画像をリンクに変換
	$value =~ s!<img src="([^"]+)">!<a href="$1" target="_blank" rel="noopener noreferrer">$1</a>!gi; 
	local @vlines = split(/\r/, $value);
	foreach (@vlines) {
		$_ = "<span class='c2'>$_</span>" if (/^(&gt;|＞)/);
	}
	$value = join("\n", @vlines);
	$value =~ s!<a href="(https?://[^"]+)">[^<]+</a>!<a href="$redirect?$1" target="_blank" rel="noopener noreferrer">$1</a>!g if ($redirect);
	if ($img) { 
		if(-e "$imgdir/$img"){
			print "<span class='c3'>画像：</span><a href='$imgdir/$img' target='_blank' rel='noopener noreferrer'>$img</a>\n";
		}
		else{
			print "<span class='c2'>画像：$img (削除済み)</span>\n";
		}
	}
	print "<br>\n";
	print "<span class='article'>$value</span>\n";

} # mbdisp end

##################################
# デコードとアップロード画像の記録
##################################

sub decode {

	if ($l_all < $ENV{'CONTENT_LENGTH'}) { &error("投稿内容が大きすぎます。アップロードは画像を含めて最大${l_all_kb}KBまでです。", __LINE__); }
	local($name, $value);
	require $jcpl;
	binmode(STDIN);

	if ($ENV{'CONTENT_TYPE'} =~ m!multipart/form-data; boundary=(.*)!){
		local $bound = $1;
		$bound =~ s/^"(.*)"$/$1/;
		while (1) {
			while (<STDIN>) {
				last if ($_ =~ /$bound/);
				if ($_ =~ /^Content-Disposition: form-data; name="([^\"]*)"/){
					$name = $1;
					if ($name eq 'filedata') {
						&binary($_, $bound);
						$name = '';
						$value = '';
					}
					next;
				}
				$value .= $_;
			}
			$value =~ s/^\r\n//;
			$value =~ s/\r\n$//;

			&jcode'convert(*value,'sjis');
			$value = &sanitaize($value, $name);

			$FORM{$name} = $value;

			$name = '';
			$value = '';
			last if eof(STDIN);
		}
	}
	else {
		if ($ENV{'REQUEST_METHOD'} eq 'POST') { read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}); }
		else { $buffer = $ENV{'QUERY_STRING'}; }
		foreach (split (/&/, $buffer)) {
			($name, $value) = split(/=/,$_);
			$value =~ tr/+/ /;
			$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("H2", $1)/eg;
			&jcode'convert(*value, 'sjis');
			$value = &sanitaize($value, $name);
			if ($name eq 'data') {
				push(@{$GLOB{'logs'}}, $value);
			}
			elsif ($name eq 'delnum') {
				push(@{$GLOB{'delmsg'}}, $value);
			}
			else {
				$FORM{$name} = $value;
			}
		}
	}

	# 投稿内容が改行/空白のみの投稿は操作ミスと判断して投稿内容を消去
	if ($FORM{'value'} =~ /^\s+$/) { $FORM{'value'} = ''; }

} # decode end

sub binary {

	if($_[0] !~ /^Content-Disposition: form-data; name="filedata"; filename="(.+)"/) { return; }
	local $bound = $_[1];
	local($type, $data, $range, $pos, @data);

	while (<STDIN>) { last if ($_ =~ /^\r\n/); } # 空白行をスキップ

	open(DB, $imglog) || &error(1, __LINE__);
	eval 'flock (DB, 2);';
	seek(DB, 0, 0);
	$GLOB{'id'} = <DB>;
	eval 'flock (DB, 8);';
	close(DB);
	$GLOB{'id'} = sprintf ("%03d", ++$GLOB{'id'});
	open(DB, ">$imglog") || &error(1,__LINE__);
	eval 'flock(DB, 2);';
	seek(DB, 0, 0);
	print DB $GLOB{'id'};
	eval 'flock (DB, 8);';
	close(DB);

	open(TMP, ">$tmpdir/$GLOB{'id'}.tmp") || &error(1, __LINE__);
	binmode(TMP);

	read(STDIN, $_, 10);
	if (/^GIF8[7,9]a/) {
		print TMP $_;
		$type = 'gif';
		$range = 10;
	}
	elsif (/^\xFF\xD8/) {
		print TMP $_;
		$type = 'jpg';
		$range = 256*1024;
	}
	elsif (/^\x89PNG\x0d\x0a\x1a\x0a/) {
		print TMP $_;
		$type = 'png';
		$range = 24;
	}
	else{ &error('GIF JPG PNG画像以外はアップロードできません。', __LINE__); }

	local $crlf = '';
	while (<STDIN>) {
		if ($_ =~ /$bound/) { last; }
		elsif ($crlf && $_ =~ /^(.*)\r\n/) { print TMP $crlf, $1; }
		elsif( $crlf && $_ =~ /[^\r]*\n/) {
			print TMP "$crlf$_";
			$crlf = '';
		}
		elsif (! $crlf && $_ =~ /^(.*)\r\n/) {
			$crlf = "\r\n";
			print TMP $1;
		}
		else{ print TMP $_; }
	}

	close(TMP);

	open(DATA, "$tmpdir/$GLOB{'id'}.tmp"); 
	binmode (DATA);
	read(DATA, $data, $range);
	close(DATA);

	if ($type eq 'jpg') {
		if ($data =~ /ImplantArchive/) { $pos = index($data, "\xff\xc0"); }
		elsif ($data =~ /\xff\xc2/) { $pos = rindex($data, "\xff\xc2"); }
		else{ $pos = rindex($data, "\xff\xc0"); }
		if ($pos == -1) { &error('画像サイズ(width/height)の取得に失敗しました。', __LINE__); }
		@data = split(//, substr($data, $pos + 5, 4));
		foreach (@data) { $_ = ord; };
		$GLOB{'imgw'} = 256 * $data[2] + $data[3];
		$GLOB{'imgh'} = 256 * $data[0]+ $data[1];
	}
	elsif ($type eq 'gif') {
		@data = split (//, substr($data, 6, 4));
		foreach (@data) { $_ = ord; }
		$GLOB{'imgw'} = 256 * $data[1] + $data[0];
		$GLOB{'imgh'} = 256 * $data[3] + $data[2];
	}
	elsif ($type eq 'png'){
		@data = split(//, substr($data, 16, 8));
		foreach (@data) { $_ = ord; }
		$GLOB{'imgw'} = 65536 * $data[0] + 4096 * $data[1] + 256 * $data[2] + $data[3];
		$GLOB{'imgh'} = 65536 * $data[4] + 4096 * $data[5] + 256 * $data[6] + $data[7];
	}

	if ($l_width < $GLOB{'imgw'} || $l_height < $GLOB{'imgh'}) { &error("アップロードできる画像は長辺${l_width}pxまでです。", __LINE__); }

	$GLOB{'img'} = "$GLOB{'id'}.$type";
	if (-e "$imgdir/$GLOB{'img'}") {
		unlink("$tmpdir/$GLOB{'id'}.tmp");
		&error(3, __LINE__);
	}
	rename("$tmpdir/$GLOB{'id'}.tmp", "$imgdir/$GLOB{'img'}");

	$GLOB{'imgsize'} = -s "$imgdir/$GLOB{'img'}";

} # binary end

sub sanitaize {

	local($value, $name) = @_;
	$value =~ s/\r\n/\r/g;
	$value =~ s/\n/\r/g;
	if ($name eq 'hpage'){
		$value =~ s/[<>"'\s]//g;
	}
	else{
		$value =~ s/&/&amp\;/g;
		$value =~ s/</&lt\;/g;
		$value =~ s/>/&gt\;/g;
		$value =~ s/"/&quot;/g;
		$value =~ s/'/&#39;/g;
	}
	return $value;

} # sanitaize end

##################################
# 投稿記録処理
##################################

sub register {

	local $name = $FORM{'name'};
	local $subject = $FORM{'subject'};
	$name = ' ' if ($name eq ''); 
	$subject = ' ' if ($subject eq '');
	$FORM{'thread'} = &digit($datenow) if (! $FORM{'thread'});

	# $FORM{'hpage'}(旧レス参照元リンクor一般リンク、現行はレス参照元リンク専用)の処理#(hpage関連のURLには./$scriptnameを使用)
	if ($FORM{'hpage'} !~ m!^\./$scriptname\?action=search1&search=\d{4}年\d{2}月\d{2}日\(..\)\d{2}時\d{2}分\d{2}秒$!) { $FORM{'hpage'} = ''; }

	if ($l_name < length $FORM{'name'})       { &error("名前が長すぎます。最大$l_name byteまでです。", __LINE__); }
	if ($l_email < length $FORM{'email'})     { &error("メールアドレスが長すぎます。最大$l_email byteまでです。", __LINE__); }
	if ($l_subject < length $FORM{'subject'}) { &error("題名が長すぎます。最大$l_subject byteまでです。", __LINE__); }
	if ($l_value < length $FORM{'value'})     { &error("内容が長すぎます。最大$l_value byteまでです。", __LINE__); }
	if ($l_line < ($FORM{'value'} =~ tr/\r/\r/) + 1) { &error("内容の行数が多すぎます。最大$l_line 行までです。", __LINE__); }

	# スパム対策
	if ($spammode == 2 || ($spammode == 1 && ! $GLOB{'img'})) {
		local $urlcount = 0;
		local $value = $FORM{'value'};
		local $valuecode = &jcode'getcode(*value);
		while ($value =~ m!https?://!gi) {
			$urlcount++;
			if (2 < $urlcount && $ENV{'HTTP_ACCEPT_LANGUAGE'} !~ /^ja/) {
				&error('日本語非対応のブラウザかつ投稿内容にURLが3個以上あるためスパムとみなされました。', __LINE__);
			}
			elsif (2 < $urlcount && $valuecode !~ /sjis|jis|euc|utf8/) {
				&error('投稿内容にURLが3個以上あり、日本語も含まれていないためスパムとみなされました。', __LINE__);
			}
			elsif (5 <$urlcount) {
				&error('投稿内容にURLが多すぎるためスパムとみなされました。一度に書き込めるURLは5個までです。', __LINE__);
			}
		}
	}

	local $adminpass;
	open(PAS, $passfile) || &error(1, __LINE__);
	chomp($adminpass = <PAS>);
	close(PAS);

	local $formname = $name;
	local($formnameord, $namezord);

	if ($formname eq $nameng) { &error('xx', __LINE__); }

	if (crypt($formname, $adminpass) eq $adminpass) {
		if ($FORM{'value'} eq $adminkey) {
			if ($GLOB{'img'}) {
				&del_currentimg;
				&reset_currentid;
				&cleanup_tmpdir;
			}
			&admintop($formname);
		}
		else {
			$formname = $namez;
			$FORM{'email'} = $mailz;
		}
	}
	else {
		foreach (split(//, $formname)) {
			$formnameord .= ord($_);
		}
		foreach (split(//, $namez)) {
			$namezord .= ord($_);
		}
		if ($formnameord =~ /$namezord/) {
			$formname = "<small>$formname</small>";
		}
		$formname =~ s/しぱ/しは゜/g;
	}

	local $search = &encode($formname);

	$FORM{'value'} =~ s!(https?://)!\x00$1!g if ($FORM{'autolink'}); # URLを一時的に分離

	local @lines = split(/\r/, $FORM{'value'});
	local $i = 0;
	foreach (@lines) {
		next if (/^&gt;|＞/ || /^\s$/);
		$i++;
		last;
	}
	if (! $i && $FORM{'hpage'} && ! $GLOB{'img'}) { &error('フォロー投稿で引用行(+改行/空白)のみの投稿はできません。何かコメントを書くか画像を選択してください。', __LINE__); }

	if ($FORM{'autolink'}) {
		foreach (@lines) {
			next if (/^&gt;|＞/);
			$_ =~ s!(https?://)([\w/=~@#%&';:,\.\-\+\?\(\)\[\]\{\}\^\|\*\$\!\\]+)!<a href="$1$2" target="_blank" rel="noopener noreferrer">$1$2</a>!g;
		}
		$FORM{'value'} = join("\r", @lines);
		$FORM{'value'} =~ s/\x00//g; # URL分離に使用したセパレータを消す
	}

	@lines = ();
	open(DB, $bbsfile) || &error(1, __LINE__);
	binmode(DB);
	eval 'flock (DB, 2);';
	@lines = <DB>;
	eval 'flock (DB, 8);';
	close(DB);

	if (($codemode == 1 && ! $FORM{'mobile'}) || $codemode == 2) {
		$FORM{'code'} = $FORM{'codeA'} . $FORM{'codeB'};
		if ($FORM{'codeB'} !~ /^\d{4}$/) { &error('投稿コードが未入力か半角数字以外のものになっています。', __LINE__); }
	}

	foreach (@lines) {
		local $code0 = (split(/\,/, $_))[10];
		chomp $code0;
		if ($code0 == $FORM{'code'}) { &error('投稿コードが使用済みです。掲示板をリロードして下さい。', __LINE__); }
	}

	&chkcode($FORM{'code'});

	$i = 0;
	local(@new);
	foreach (@lines) {
		$i++;
		last if ($i == $l_record);
		push (@new, $_);
	}

	foreach (@lines[0..($check - 1)]) {
		local($d, $d, $d, $value, $d, $d, $img) = split(/,/, $_);
		if ($GLOB{'img'} && $img && (-s "$imgdir/$img") == (-s "$imgdir/$GLOB{'img'}") && $FORM{'value'} eq $value) {
			&error('投稿内容が重複しています。画像もしくは内容(コメント)を変更してください。', __LINE__);
		}
		elsif (! $GLOB{'img'} && ! $img && $FORM{'value'} eq $value) {
			&error('投稿内容(コメント)が重複しています。', __LINE__);
		}
	}

	local @values = ($datenow, $formname, $FORM{'email'}, $FORM{'value'}, $subject, $FORM{'hpage'}, $GLOB{'img'}, $GLOB{'imgw'}, $GLOB{'imgh'}, $search, $FORM{'code'}, $FORM{'thread'},'');
	foreach (@values) { $_ =~ s/,/\x00/g; } # データ中の全ての , を\x00に変換
	local $newmsg = join(',', @values) . "\n";
	unshift(@new, $newmsg);

	open(DB, ">$bbsfile") || &error(1, __LINE__);
	binmode(DB);
	eval 'flock (DB, 2);';
	print DB @new;
	eval 'flock (DB, 8);';
	close(DB);

	# 画像容量/ファイル数管理
	if ($GLOB{'img'} && $imgctrl eq 'size') {
		local @tmp = &dirinfo($imgdir);
		local $sum = shift(@tmp);
		local $delsum = 0;
		local $usage = sprintf('%.1f', $sum / 1024 /1024);
		if ($l_imgdir < $sum + $l_all) {
			foreach (@tmp){
				last if ($sum - $delsum < $l_imgdir - $l_all);
				$delsum += $$_[1];
				unlink("$imgdir/$$_[0]");
			}
			$usage = sprintf('%.1f', ($sum - $delsum) / 1024 /1024);
		}
		open(DB, ">$dirinfofile");
		print DB $usage;
		close(DB);
		&cleanup_tmpdir;
	}
	elsif ($GLOB{'img'} && $imgctrl eq 'num') {
		&del_oldimg;
		&cleanup_tmpdir;
	}

	&pushlog(@values);
	&add($formname) if ($rankkey);

	&html;

} # register end

sub pushlog {

	# 変換した半角カンマを復元
	foreach (@_) { $_ =~ s/\x00/,/g; }

	local($date, $name, $email, $value, $subject, $hpage, $img) = @_;

	# 変換された改行記号を統一
	$value =~ s/\r\n|\r/\n/g if ($value);

	if (!(-s $logfiledate)) {
		open(LOG,">$logfiledate") || &error(2, __LINE__);
		print LOG "<html><head><title>$title</title></head>\n";
		print LOG qq!<body bgcolor="#$bgcdef" text="#$textc" link="#$linkc" vlink="#$vlinkc" alink="#$alinkc">\n!;
		print LOG "<big><b>$title $year年$mon月過去ログ</b></big>\n";
		close (LOG);
	}

	open (LOG, ">>$logfiledate") || &error(2, __LINE__);
	print LOG qq!<hr><font size="+1" color="#$subjc"><b>$subject</b></font>!;
	
	if ($email) { print LOG qq!　投稿者：<b><a href="mailto:$email">$name</a></b>\n!; }
	else { print LOG qq!　投稿者：<font color="#$subjc"><b>$name</b></font>\n!; }

	print LOG qq!<font size="-1">　投稿日：$datenow</font><p>\n<blockquote><pre>\n!;

	# logディレクトリからの相対指定でアップロード画像は../$imgdir/$img

	print LOG qq!<font color="#ff69b4">アップロード画像：</font><a href="../$imgdir/$img" target="img">$img</a>\n! if ($img);

	print LOG "\n" if($value && $img);

	print LOG "$value" if($value);

	print LOG "</pre><p>\n";
	# hpage関連のURLには./$scriptnameを使用
	if ($hpage =~ m!^\./$scriptname\?action=search1\&search=(.*)$!) {
		print LOG "<u>参考：$1</u><p>\n";
	}

	print LOG "</blockquote>\n";

	close(LOG);

} # pushlog end

##################################
# フォロー投稿サーチ
##################################

sub search1 {

	&header;
	print <<"EOF";
<title>$title</title>
$css
</head>
$body
<form class="article" method="POST" action="$scriptrel">
$baseinput
<font size=+1><b>フォロー記事投稿</b></font> &nbsp;
<input type="submit" value="戻る">

EOF

	local($found, $value, @lines, @data, @vlines);

	open(DB, $bbsfile) || &error(2, __LINE__);
	@lines = <DB>;
	close(DB);

	foreach (@lines) {
		@data = split(/,/, $_);
		chomp($data[11]); # 旧データ混在時用にここでchomp
		local $date = &digit($data[0]);
		if ($date eq $FORM{'search'}) { 
			push(@data, 'search1'); # &dispに渡すフラグ追加
			$found++; 
			last; 
		}
	}

	if ($found) {
		if (! $FORM{'mobile'}) { &disp(@data); }
		else{ &mbdisp(@data); }
		print "</form><hr>\n";
		$value = $data[3];
		if ($value) {
			$value =~ s/<img src="(.*?)">/$1/g;
			$value =~ s/<a href=[^>]+>([^<]+)<\/a>/$1/g;
			@vlines = split(/\r/,$value); # レス内容に引用符を付ける（引用は最大3段まで）
			$value = '';
			foreach (@vlines) {
				if ($_ !~ /^&gt; &gt; &gt; .*/) { $value .= "&gt; $_\n"; }
			}
			$value .= "\n";
		}
		# hpage関連のURLには./$scriptnameを使用
		print "<font color='#ff69b4'></font>※引用文中のURLはcheckboxの状態を問わずリンクに自動変換されません。アップロード画像は引用されません。<br><br>\n\n";
		local @parm = ($FORM{'name'}, $FORM{'email'}, $value, "＞$data[1]", "./$scriptname?action=search1&search=$data[0]", '      投稿      ', $data[11], 'search1');
		if (! $FORM{'mobile'}) { &form(@parm); }
		else{ &mbform(@parm); }
		print "</form><p>\n";
	}
	else {
		print "　みつかりません。元記事が削除された可能\性があります。<br>";
	}

	&footer;

} # search1 end


##################################
# 投稿者名サーチ
##################################

sub search2 {

	local($name, $found, @lines, @data);
	local $searchname = $FORM{'searchname'};
	$searchname =~ s/%25/%/g;
	$searchname =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("H2", $1)/eg;
	local $name = $searchname;
	$searchname =~ s/,/\x00/g; # 記録ファイルデータとフォーマットを合わせる

	&header;
	print <<"EOF";
<title>$title</title>
$css
</head>
$body
<form class="article" method="POST" action="$scriptrel">
$baseinput
<font size="+1"><b>投稿者名サーチ「$name」</b></font><small>(最大$l_search2件表\示)</small> &nbsp;
<input type="submit" value="戻る">
EOF

	open(DB, $bbsfile) || &error(2, __LINE__);
	chomp(@lines = <DB>);
	close(DB);
	
	if( $ngsearch == 1 && ( $name eq ' ' || $name eq '　' ) ) { 
		print "<br><br>エラー : 半角or全角スペース1個の投稿者名をサーチすることはできません。\n";
		&footer;
	}
	elsif ($ngsearch == 2 && length ( $name ) == 1) {
		print "<br><br>エラー : 半角1文字(1byte)の投稿者名をサーチすることはできません。\n";
		&footer;
	}

	$found = 0;
	foreach (@lines) {
		@data = split(/,/, $_);
		chomp($data[11]); # 旧データ混在時用
		if ($data[1] eq $searchname) {
			$found++;
			push(@data, 'search2'); # &dispに渡すフラグ追加
			&disp(@data);
		
		}
		if ( $l_search2 <= $found ) {
			print "<hr>記事が$l_search2件を超えました。これ以降の記事は省略されています。\n"; 
			last;
		}
	}
	print "</form>\n";
	
	if ($rankkey) {
		print "<hr>今月の投稿数：";
		print &how_much($searchname);
	}
	print "みつかりません<br>" if ($found == 0);

	print "<br><a href='$scriptrel#top'>△TOP</a>\n";

	&footer;

} # search2 end

##################################
# スレッド表示
##################################

sub thread {

	local($found, @lines, @data);
	local $threadname = substr($FORM{'thread'}, 4, 4);
	&header;
	print <<"EOF";
<title>$title</title>
$css
</head>
$body
<form class="article" method="POST" action="$scriptrel">
$baseinput
<font size="+1"><b>スレッド $threadname*</b></font> &nbsp;
<input type="submit" value="戻る">
EOF

	open(DB, $bbsfile) || &error(2, __LINE__);
	$found = 0;
	while (<DB>) {
		chomp $_;
		@data = split(/,/, $_);
		if ($data[11] eq $FORM{'thread'}) {
			$found++;
			push(@data, 'thread'); # &dispに渡すフラグ追加
			if (! $FORM{'mobile'}) { &disp(@data); }
			else{ &mbdisp(@data); }
			last if (&digit($data[0]) eq $FORM{'thread'});
		
		}
		if ( $l_thread <= $found ) {
			print "<hr>記事が$l_thread件を超えました。これ以降の記事は省略されています。\n"; 
			last;
		}
	}
	close(DB);

	print "</form>\n";
	print "みつかりません<br>" if ($found == 0);
	print "<br><a href='$scriptrel#top'>△TOP</a>\n";
	
	&footer;

} # thread end

##################################
# 投稿ランキング(by うらべ氏)
##################################

sub viewrank {

	&header;
	print <<"EOF";
<title>$title</title>
</head>
$body
<center>
<table width=80% border=0><tr><td align="center">
	<font size=+1><b>$title 投稿ランキングTOP10</b></font>
</tr></td></table>
<p>
EOF
	opendir(DIR, $rankdir) || &error(2, __LINE__);

	foreach(grep(/^\d+/,readdir(DIR))){ # DBファイル名(拡張子を除いた先頭部分)取得
		$_ =~ s/\D//g;
		push(@rankfiles, $_);
	}

	%count=();
	@rankfiles = reverse sort grep(! $count{$_}++, @rankfiles); # 重複排除

	$page = ($FORM{'rankpage'} || 0);
	(($pageend = $page+$rankdef-1) > $#rankfiles) && ($pageend = $#rankfiles);

	foreach $rankfile (@rankfiles[$page..$pageend]){
		$rankyear = substr($rankfile,0,4);
		$rankmon = substr($rankfile,4,2);
		dbmopen(%DB,"$rankdir/$rankfile",0666);
		$total=0;
		foreach(values(%DB)){ $total += $_; }
		print <<"EOF";
<table width=80% border=0><tr><td align="left">
<font size=+1>$rankyear年$rankmon月</font>　投稿数：$total
</td></tr></table>
<table width=80% border=1>
<tr><th>順位</th><th>名前</th><th>数</th><th>割合</th></tr>
EOF
		$kazu = $i = 1;
		foreach(sort {$DB{$b} <=> $DB{$a}} keys(%DB)){
			if ($kazu != $DB{$_}){ last if ($i>10); $rank="$i位";}
			else { $rank="　"; }
			$kazu = $DB{$_};
			$percent = sprintf("%4.1f",($DB{$_} / $total*100));
			print <<"EOF";
<tr>
<th align="center">$rank</th>
<td><b>$_</b></td>
<td align="right"><b>$DB{$_}</b></td>
<td align="right"><b>$percent</b>%</td>
</tr>
EOF
			$i++;
		}
		dbmclose(%DB);
		print "</table>\n<p>\n";
	}

	(($rankfront = $page-$rankdef) < 0) && ($rankfront = 0);
	(($ranknext = $page+$rankdef) > ($rankend = $#rankfiles-$rankdef+1)) && ($ranknext = $rankend);
	if ($pageend < $#rankfiles){
		print "<a href=\"$scriptrel?bgcolor=$bgc&action=ranking&rankpage=$rankend\">＜＜</a>\n";
		print "<a href=\"$scriptrel?bgcolor=$bgc&action=ranking&rankpage=$ranknext\">＜古いほうへ</a>\n";
	}
	if ($page > 0){
		print "<a href=\"$scriptrel?bgcolor=$bgc&action=ranking&rankpage=$rankfront\">新しいほうへ＞</a>\n";
		print "<a href=\"$scriptrel?bgcolor=$bgc&action=ranking&rankpage=0\">＞＞</a>\n";
	}
	print <<"EOF";
</center>
</body></html>
EOF

	exit;

} # viewrank end

sub add {

	$name = $_[0];
	dbmopen(%DB,$rankfile,0666);
	$DB{$name}++;
	dbmclose(%DB);

} # add end

sub how_much {

	$name = $_[0];
	dbmopen(%DB,$rankfile,0666);
	$kazu = $DB{$name};
	dbmclose(%DB);
	$kazu = 0 if ($kazu eq '');
	return($kazu);

} # how_much end


##################################
# 過去ログ選択ページ
##################################

sub selectlog {

	local(@logs, $i, $chk, $count, $log, $size, $logyear, $logmon, $logname, $sel);

	opendir(LOG, $logdir) || &error(2, __LINE__);
	@logs = sort { $a <=> $b } grep(/\.html$/, readdir(LOG));
	close (LOG);

	&header;
	print <<"EOF";
<title>$title過去ログ</title>
</head>
$body
<p>
<font size=4><b>$title過去ログ</b></font>
<form method="POST" action="$scriptrel">
<input type="hidden" name="action" value="getlog">
<hr><pre>
EOF

	foreach $log (@logs) {
		$chk = '';
		$count = 0;
		open(IN, "$logdir/$log");
		while (<IN>) { $count++ if (/<blockquote>/); }
		close (IN);
		$size = (stat("$logdir/$log"))[7];
		$logyear = substr($log, 0, 4);
		$logmon = substr($log, 4, 2);
		$logname = "$logyear年$logmon月";
		if ($i == $#logs) { $chk = ' checked'; }
		printf("<input type='checkbox' name='data' value='$log'$chk> <a href='$logdir/$log'>$logname</a>    %6s byte   $count件\n", $size);
		$i++;
	}

	print "</pre>日付：<select name='start'>\n";
	for ($i = 1; $i <= 31; $i++) {
		$sel = ' selected' if ($i == 1);
		print "<option value='$i'$sel>";
		printf("%02d\n", $i);
		$sel = '';
	}
	print "</select>日から\n";
	print "<select name='end'>\n";
	for ($i = 1; $i <= 31; $i++){
		$sel = ' selected' if ($i == 31);
		print "<option value='$i'$sel>";
		printf("%02d\n", $i);
	}

	print <<"_HTML_";
</select>日まで
<p>
<select name="search">
<option value="all" selected>全文
<option value="name">投稿者
<option value="subject">題名
</select>
<select name="command">
<option value="NORMAL" selected>通常検索
<option value="AND">AND検索
<option value="OR">OR検索
</select>
<input type="text" name="keyword" size="30" maxlength="$l_keyword"><p>
<input type="submit" value="読み込み/検索">　
<input type="checkbox" name="opt_i" value="1" checked>大文字小文字を区別しない<p>
※検索文字列無しで [読み込み/検索] ボタンを押すと選択したログをすべて表\示します(最大$l_logsearch件)
</form>
_HTML_

	&footer;

} # selectlog end


##################################
# 過去ログ表示
##################################

sub getlog {

	local(@logs, $warn, $search, $command, $keyword, @keyword, $line, $hitlimit, $printed, @re, $hit, $hitall);

	@logs = sort { $a <=> $b } grep (/^\d{6}\.html$/, @{$GLOB{'logs'}});

	&header;
	print <<"EOF";
<title>$title過去ログ</title>
$css
</head>
$body
<p><font size="+1"><b>
EOF

	foreach (@logs) { print "$_ "; }

	print "</b></font> (最大$l_logsearch件) &nbsp; <a href='$scriptrel?action=selectlog'>ログ選択画面に戻る</a><hr>\n";

	$warn = '';

	if ($l_keyword < length$FORM{'keyword'}) { 
		$warn .= "<br><br>検索キーワードは半角$l_keyword文字以内にしてください。\n";
	}

	if($ngsearch == 1 && ($FORM{'keyword'} eq ' ' || $FORM{'keyword'} eq '　')) { 
		$warn .= "<br><br>エラー : キーワード\"半角or全角スペース1個\"で過去ログサーチすることはできません。\n";
	}
	elsif($ngsearch == 2 && length( $FORM{'keyword'} ) == 1) {
		$warn .=  "<br><br>エラー : キーワード\"半角1文字(1byte)\"で過去ログサーチすることはできません。2文字以上のキーワードを指定してください。\n";
	}

	if ($warn) {
		print $warn;
		&footer;
	}

	if ($FORM{'keyword'}) {
		if ($FORM{'search'} eq 'all') { $search = "全文 $FORM{'command'}検索"; }
		elsif ($FORM{'search'} eq 'name') { $search = "投稿者 $FORM{'command'}検索"; }
		elsif ($FORM{'search'} eq 'subject') { $search = "題名 $FORM{'command'}検索"; }

		$command = $FORM{'command'};
		if ($command eq 'NORMAL') {
			$keyword = quotemeta($FORM{'keyword'});
			$keyword = qr/$keyword/i if ($FORM{'opt_i'});
		}
		else {
			$FORM{'keyword'} =~ tr/ / /s;
			$FORM{'keyword'} =~ s/^ | $//g;
			@keyword = split (/ /, $FORM{'keyword'});
			foreach (@keyword) {
				$_ = quotemeta($_);
				$_ = qr/$_/i if($FORM{'opt_i'});
			}
			$keyword = join("|", @keyword) if ($command eq 'OR');
		}
	}

	$/ = '<hr>'; #入力レコードセパレータを\nから<hr>に変更

	$hitlimit = 0;
	$printed = 0;
	foreach $logdata (@logs){ # 過去ログ出力

		open(LOG,"$logdir/$logdata") || print '今月の過去ログはまだ作成されていません。<br><br>';

		LOOP: while ($line = <LOG>) {
			chomp $line;
			$line =~ />　投稿日：[^<]*(\d{2}).?.?\(..\)/;
			next if ($1 < $FORM{'start'} || $FORM{'end'} < $1);

			if ($FORM {'keyword'}) {
				if ($FORM{'search'} eq 'all') {
					if ($command eq 'AND') {
						foreach $keyword (@keyword) { next LOOP if ($line !~ /$keyword/); }
					}
					else { next LOOP if($line !~ /$keyword/); }
				}
				elsif ($FORM{'search'} eq 'name') {
					if ($command eq 'AND') {
						foreach $keyword (@keyword) { next LOOP if ($line !~ /投稿者：<[^>]+><b>[^<]*$keyword[^<]*</); }
					}
					else { next LOOP if($line !~ /投稿者：<[^>]+><b>[^<]*$keyword[^<]*</); }
				}
				elsif ($FORM{'search'} eq 'subject') {
					if ($command eq 'AND') {
						foreach $keyword (@keyword) { next LOOP if ($line !~ /<font size=[^>]+><b>[^<]*$keyword[^<]*</); }
					}
					else { next LOOP if ($line !~ /<font size=[^>]+><b>[^<]*$keyword[^<]*</); }
				}
			}

			# アップロード画像の処理（じょしあな固有）
			$line =~ s!<a href="\.\./([^"]*?\.(jpg|gif|png))"!<a href="$1"!g;
			# 引用部分
			@re = split(/\r\n|\r|\n/, $line);

			foreach (@re) {
				if (/^(＞|&gt;)/) { $_ = "<font color='#$resc'>$_</font>"; }
				elsif(/^<blockquote><pre>((＞|&gt;).*)/){ # ver3.01以降の過去ログではこの部分は不要
					$_ = "<blockquote><pre><font color=\"#$resc\">$1</font>";
				}
			}

			$line =join("\n", @re);
			$line =~ s/<a href="(https?:\/\/[^"]+)">[^<]+<\/a>/<a href="$redirect?$1">$1<\/a>/g if ($redirect);
			print "$line<hr>";
			$hit++;
			$printed++;

			if( $l_logsearch <= $printed ) {
				$hitlimit = 1;
				last;
			}
		}

		close(LOG);

		if ($FORM{'keyword'} && $hit) {
			print "<font size='+1' color='#ff69b4'><b>$logdata $search：$FORM{'keyword'} は$hit件みつかりました。</b></font><hr>\n";
			$hitall += $hit;
		}
		elsif ($FORM{'keyword'}) {
			print "<font size='+1' color='#ff69b4'><b>$logdata $search：$FORM{'keyword'} はみつかりませんでした。</b></font><hr>\n";
		}

		$hit = '';
		last if ($hitlimit);

	} # 過去ログ出力終了

	$/ = "\n"; # セパレータを元に戻す

	if ($hitlimit) {
		print "<font size='+1' color='#ff69b4'><b>Hit数が$l_logsearch件を超えたため出力が中断されました。検索ワードまたは選択ログ数を見直してください。</b></font><hr>\n";
	}

	if ($FORM{'keyword'} && $hitall) {
		print "<font size='+1'><b>";
		print "$search：$FORM{'keyword'} は合計$hitall件みつかりました。</b></font>　 \n";
	}

	print "<a href='$scriptrel?action=selectlog'>ログ選択画面に戻る</a>\n";

	&footer;

} # getlog end


##################################
# 管理モード
##################################

#------------------パスワード認証

sub chkpass {

	local $pass = $FORM{'pass'};
	local $adminpass;
	open(PAS, $passfile) || &error(2, __LINE__);;
	chomp($adminpass = <PAS>);
	close(PAS);
	if (crypt ($pass, $adminpass) ne $adminpass) { &error('パスワードが不正です。再入力して下さい。', __LINE__); }

} # chkpassword end

#------------------ログイン画面

sub admintop {

	$FORM{'pass'} = $_[0] if ($_[0]);

	&header;
	print <<"EOF";
<title>$title管理モード</title>
$css
</head>
$body
<form class="back" method="POST" action="$scriptrel">
$baseinput
<p><font size=+1><b>$title管理モード</b></font> &nbsp;
<input type="submit" value="掲示板に戻る">
</form>
<hr>
<form class="admin" method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="pass" value="$FORM{'pass'}">
記事削除 <input type="radio" name="action" value="delform" checked> &nbsp;
パスワード変更 <input type="radio" name="action" value="passform"><p>
<input type="submit" value="    決定    ">
</form>
EOF

	&footer;

} # admintop end

#------------------パスワード作成フォーム

sub passform {

	local $warn = $_[0];
	local $info;
	if( $warn) { $info = "<p><font color='red'>$warn</font><br>"; }
	if ($FORM{'pass'}) { $info .= "<p>現在のパスワード：$FORM{'pass'}"; }

	&header;
	print <<"EOF";
<title>$title管理モード</title>
$css
</head>
$body
<form class="admin" method="POST" action="$scriptrel">
<input type="hidden" name="action" value="admintop">
$baseinput
<input type="hidden" name="pass" value="$FORM{'pass'}">
<input type="submit" value="管理モードTOP">
</form> &nbsp;

<form class="back" method="POST" action="$scriptrel">
$baseinput
<input type="submit" value="掲示板に戻る">
</form><br><br>

<font size="+1"><b>パスワード設定/変更</b></font><hr>
<p>$info
<form method="POST" action="$scriptrel">
<input type="hidden" name="action" value="registerpass">
$baseinput
<input type="hidden" name="pass" value="$FORM{'pass'}">
新しいパスワード：<input type="text" name="newpass" size="12" maxlength="12">
（半角英数4～12文字で入力）<p>
<input type=submit value="パスワード設定"></form>
EOF
	&footer;

} # passform end

#------------------削除フォーム

sub delform {

	open(IN, $bbsfile) || &error(2, __LINE__);
	local @lines = <IN>;
	close(IN);

	&header;
	print <<"EOF";
<title>$title管理モード</title>
$css
</head>
$body
<form class="admin" method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="action" value="admintop">
<input type="hidden" name="pass" value="$FORM{'pass'}">
<input type="submit" value="管理モードTOP">
</form> &nbsp;

<form class="back" method="POST" action="$scriptrel">
$baseinput
<input type="submit" value="掲示板に戻る">
</form><br><br>

<font size="4"><b>削除モード</b></font>
<p>投稿日時 : 名前 : 題名 : 内容
<hr><form method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="action" value="delmsg">
<input type="hidden" name="pass" value="$FORM{'pass'}">
<input type="submit" value="　　削除　　"><p>
<pre>
EOF

	foreach (@lines) {
		local ($date, $name, $email, $value, $subject) =  split(/,/ ,$_);
		foreach ($name, $subject, $value) { $_ =~ s/\x00/,/g; }
		local $datenum = &digit($date);
		$name = substr($name, 0, 20);
		$subject = substr($subject, 0, 20);
		$value = substr($value, 0, 30);
		foreach ($name, $subject, $value) {
			$_ =~ s/</&lt;/g;
			$_ =~ s/>/&gt;/g;
			$_ =~ s/\s/ /g;
		}
		local $out = sprintf("$date : %-20s : %-20s : %-30s ", $name, $subject, $value);
		print "<input type='checkbox' name='delnum' value='$datenum'>$out\n";
	}

	print <<"EOF";
</pre>
<p><input type="submit" value="    削除    "></form><hr>
<form class="admin" method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="action" value="admintop">
<input type="hidden" name="pass" value="$FORM{'pass'}">
<input type="submit" value="管理モードTOP">
</form> &nbsp;

<form class="back" method="POST" action="$scriptrel">
$baseinput
<input type="submit" value="掲示板に戻る">
</form><br>
EOF
	&footer;

} # delform end

#------------------暗号化パスワード出力

sub registerpass {

	local $warn = '';
	if (length $FORM{'newpass'} < 4)     { $warn = 'パスワードは4文字以上の半角英数文字を使用して下さい。'; }
	elsif (12 < length $FORM{'newpass'}) { $warn = 'パスワードは12文字以内の半角英数文字を使用して下さい。'; }
	elsif ($FORM{'newpass'} =~ /\W/)     { $warn = 'パスワードは半角英数文字を使用して下さい。'; }

	if ($warn) {
		&passform($warn);
		exit; # 安全装置
	}

	local $crpass = crypt($FORM{'newpass'}, em);

	open(PAS, ">$passfile") || &error(2, __LINE__);
	print PAS $crpass;
	close(PAS);

	&header;
	print <<"EOF";
<title>$title管理モード</title>
$css
</head>
$body
<form class="admin" method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="action" value="admintop">
<input type="hidden" name="pass" value="$FORM{'newpass'}">
<input type="submit" value="管理モードTOP">
</form> &nbsp;

<form class="back" method="POST" action="$scriptrel">
$baseinput
<input type="submit" value="掲示板に戻る">
</form><br><br>
<hr>
<font size=4><b>管理者パスワード登録完了</b></font><br><br>
新しい管理者パスワードは「<font color="#cc0000">$FORM{'newpass'}</font>」です。
<br><br>
EOF
	&footer;

} # registerpass end

#------------------削除処理

sub delmsg {

	open(IN, $bbsfile) || &error(2, __LINE__);
	binmode(IN);
	local @lines = <IN>;
	close(IN);

	local @new;
	foreach (@lines) {
		local $i = '';
		local @data = split(/\,/, $_);
		$target = &digit($data[0]);
		foreach (@{$GLOB{'delmsg'}}) {
			if ($_ eq $target) { 
				unlink("$imgdir/$data[6]");
				$i = 1;
				last;
			}
		}
		push(@new, $_) if (! $i);
	}

	open(OUT, ">$bbsfile") || &error(2, __LINE__);
	binmode(OUT);
	print OUT @new;
	close(OUT);

} # delmsg end

##################################
# 共通サブルーチン
##################################

sub chkcode {

	local $code = shift;
	local $de_code = ($code / $codesalt) - $codekey;
	if ($code % $codesalt) {&error('投稿コードが壊れています。掲示板をリロードして下さい。', __LINE__);}
	if ($time < $de_code) { &error('投稿コードが壊れています。掲示板をリロードして下さい。', __LINE__); }
	elsif ($l_time < $time - $de_code) { &error("投稿コードの有効期限（$l_time秒）が過ぎています。掲\示板をリロードして下さい。", __LINE__);}
	elsif ($time - $de_code < $s_time) { &error("投稿間隔が短かすぎます。$s_time秒以上経過してから投稿して下さい。", __LINE__);}

}

sub encode {

	local $str = shift;
	local(@array) = unpack('C*',$str);
	foreach (@array) {
		$_ = '%' . sprintf('%2.2x' ,$_);
	}
	return (join('', @array));

}

sub set_parmdef {

	$num = $numdef;
	$bgc = $bgcdef;
	$autolink = $autolinkdef;
	$imgview = $imgviewdef;
	$video = $videodef;
	if( $autolink == 1){ $chklink = ' checked'; }
	if( $imgview == 1){ $chkimg = ' checked'; }
	if( $video == 1){ $chkvideo = ' checked'; }

}

sub del_currentimg {

	unlink("$imgdir/$GLOB{'img'}");
	$GLOB{'img'} = '';

}

sub reset_currentid {

	$GLOB{'id'} = sprintf ("%03d", --$GLOB{'id'});
	open(DB, ">$imglog") || &error(2, __LINE__);
	eval 'flock (DB, 2);';
	seek(DB,0,0);
	print DB $GLOB{'id'};
	eval 'flock (DB, 8);';
	close(DB);

}

sub del_oldimg {

	opendir(DIR, $imgdir) || &error(2, __LINE__);
	local(@list) = grep(! /^\.{1,2}/, readdir(DIR));
	closedir(DIR);
	@list = sort { $a <=> $b } @list;
	local $i = @list;
	foreach (@list) {
		last if ($i <= $l_imgnum);
		unlink("$imgdir/$_");
		$i--;
	}

}

sub cleanup_tmpdir {

	opendir(DIR, $tmpdir) || &error(2, __LINE__);
	local(@list) = grep(! /^\.{1,2}/, readdir( DIR ));
	closedir(DIR);
	return if (! @list);
	foreach (@list) {
		unlink("$tmpdir/$_");
	}

}

sub digit {

	local $str = shift;
	$str =~ s/\D//g;
	return $str;

}

sub dirinfo {

	local $dir = shift;
	local($i, $sum, $size, $time, @list);
	opendir(DIR, $dir);
	$i = 0;
	$sum = 0;
	foreach (sort { $a <=> $b } readdir(DIR)) {
		next if ($_ =~ /^\./);
		($size, $time) = (stat("$dir/$_"))[7,9];
		 @{$list[$i]} = ($_, $size, $time);
		$sum += $size;
		$i++;
	}
	closedir(DIR);
	unshift(@list, $sum);
	return @list;

}

sub pagination {

	local($num, $page, $page_all) = @_;
	print <<"EOF";
<form class="page" method="POST" action="$scriptrel">
$baseinput
<input type="hidden" name="page" value="$page">
EOF

	if ($page == 1 && $page_all != 1) {
		$prev = "<input type='button' class='prev' value='開始ページ'>\n";
		$next = "<input type='submit' class='next' name='next' value='次のページ &gt;'>\n";
	}
	elsif ($page == 1 && $page_all == 1) {
		$prev = "<input type='button' class='prev' value='   (((*'-')'>\n";
		$next = "<input type='button' class='next' value='■■ ﾁｮｺﾚｰﾄ'>\n";
	}
	elsif ($page != $page_all) {
		$prev = "<input type='submit' class='prev' name='prev' value='&lt; 前のページ'>\n";
		$next = "<input type='submit' class='next' name='next' value='次のページ &gt;'>\n";
	}
	else {
		$prev = "<input type='submit' class='prev' name='prev' value='&lt; 前のページ'>\n";
		$next = "<input type='button' class='next' value='最終ページ'>\n";
	}

	print $prev;
	print $next;
	print "<input type='submit' class='reload' name='start' value='Reload' title='開始ページ/リロード'>";
	if (! $FORM{'mobile'}) {
		print "<input type='submit' class='jump' value='P' title='指定ページにジャンプ'>";
		print "<input type='text' class='page' name='page' value='$page' size='1'>";
		if ($page ne $page_all) {
			print "<input type='submit' class='end' name='end' value='End.$page_all' title='最終ページ'>\n";
		}
		else {
			print "<input type='button' class='end' name='end' value='End.$page_all' title='最終ページ'>\n";
		}
	}

	print "</form>\n";

} # pagination end

sub max {
	return (sort { $b <=> $a } @_)[0];
}

sub min {
	return (sort { $a <=> $b } @_)[0];
}

sub counter {

	local($i, $maxcount, $mincount, @count, @filenumber, @sortedcount);
	for( $i=0 ; $i < $countlevel ; $i++){
		open(IN,"$countdir/count$i.txt");
		$count[$i] = <IN>;
		$bbsfilenumber[$count[$i]] = $i;
		close(IN);
	}
	@sortedcount = sort { $a <=> $b } @count;
	$maxcount = $sortedcount[$countlevel-1];
	$mincount = $sortedcount[0];
	$maxcount++;
	open(OUT,">$countdir/count$bbsfilenumber[$mincount].txt");
	print OUT $maxcount;
	close(OUT);
	return $maxcount;

}

##################################
# エラー処理
##################################

sub error {

	local($error, $line) = @_;
	local $msg;

	if (($GLOB{'img'} || $GLOB{'id'}) && $error != 2 && $error != 3) { 
		&del_currentimg if ($GLOB{'img'});
		&reset_currentid if ($GLOB{'id'});
		&cleanup_tmpdir;
	}

	if    ($error == 1) { $msg = 'ファイル/ディレクトリを開けませんでした。(1)'; }
	elsif ($error == 2) { $msg = 'ファイル/ディレクトリを開けませんでした。(2)'; } # UP画像削除なし
	elsif ($error == 3) { $msg = '画像ファイル名が重複しています。img.datの数値とアップロード画像番号の最大値を一致させてください。'; } # UP画像削除なし
	elsif ($error eq 'x')  { $msg = '以下の情報が記録されました。けけ'; }
	elsif ($error eq 'xx') { $msg = 'かわいそう'; }
	else  { $msg =  $error; }
	
	if (! $baseinput) {
		 &set_parmdef;
	}

	&header;
	print <<"EOF";
<title>$title</title>
$css
</head>
<body bgcolor="#$bgc" text="#$textc" link="#$linkc" vlink="#$vlinkc" alink="#$alinkc">
<h3>Line:$line $msg</h3>
<form class="back" method="POST" action="$scriptrel">
<input type="hidden" name="name" value="$FORM{'name'}">
<input type="hidden" name="email" value="$FORM{'email'}">
<input type="hidden" name="num" value="$num">
<input type="hidden" name="bgcolor" value="$bgc">
<input type="hidden" name="autolink" value="$autolink">
<input type="hidden" name="imgview" value="$imgview">
<input type="hidden" name="video" value="$video">
<input type="submit" value="掲示板に戻る">
</form><br><br>
EOF

	if($FORM{value}){
		$FORM{value} =~ s!<a href="([^"]*)">[^<]*</a>!$1!g;
		$FORM{value} =~ s/\x00/,/g;
		print <<"EOF";
<p>※以下の投稿内容は記録されませんでした。投稿内容をコピー後上のリンクから掲示板に戻って下さい（ブラウザのBackでは戻れない場合があります）
<hr><pre>$FORM{value}</pre>
EOF
	}

	if ($error eq "x") {
		while (($a,$b) = each %ENV) {
			print "$a=$b<br><br>\n";
		}
	}

	if ($error eq "xx") {
		print "<table><tr><td>" x 60, "\n　";
		print "</td></tr></table>" x 60, "\n\n";
	}

	&footer;

} # error end

1;