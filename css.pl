# css.pl v1.05 2022/06/18

sub css {

local($bgcdef, $textc, $linkc, $vlinkc, $alinkc, $subjc, $resc, $mode) = @_;
local $css;

	if ($mode ne 'mobile') {

#---------- CSS for PC

	$css = <<"EOF";
<style type="text/css">
/* CSS for PC */

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

body {
	font-size: 16px;
	line-height: 1.3;
}

pre {
	white-space: pre-wrap;
	word-break:break-all;
}

pre.code {
	font-size: 0.6rem;
	line-height:1;
}

form.admin,
form.back,
form.log,
form.page {
	display: inline-block;
}

form.back input,
form.article input,
label {
	font-family: inherit;
	border: none;
	margin: 0 2px;
	padding:0;
	font-size: 1rem;
	background-color: transparent;
	color: #$textc;
	text-decoration: underline;
}

form.article input.search {
	font-size: 1rem;
}

form.back input:hover,
form.article input:hover,
label:hover {
	cursor: pointer;
}

iframe{
	display: block;
	margin: 5px 5px 5px 0;
}

form.page input.start,
form.page input.end,
form.page input.page {
	min-width: 2rem;
}

form.page input.reload {
	margin-left: 1rem;
}

form.page input[type=text].page {
	text-align: center;
	width: 2rem;
}

form.page input.prev,
form.page input.next {
	min-width: 6rem;
}

form.page input[type=button] {
	border-color:transparent;
	background-color: transparent;
	color: #$resc;
}

</style>
EOF
	}
	else {

#---------- CSS for Mobile

	$css = <<"EOF";
<style type="text/css">
/* CSS for Mobile */

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	font-family: inherit;
}

html {
	font-size: 16px;
}

body {
	background-color: #$bgcdef;
	color: #$textc;
	line-height: 1.3;
	word-break: break-word;
	overflow-wrap: break-word;
	-webkit-text-size-adjust: 100%;
}

.c1 {
	color:#$textc;
}

.c2 {
	color:#$resc;
}

.c3 {
	color:#ff69b4;
}

form {
	display: inline-block;
}

form.main,
form.page {
	line-height: 2;
}

form.main,
form.article {
	display:block;
}

textarea {
	line-height: 1.2;
	width:21rem;
	height: 5.5rem;
}

span.article {
	word-break: break-all;
	white-space: pre-wrap;
}

pre.code {
	font-family:monospace;
	font-size: 0.6rem;
	line-height:1;
}

input[type=submit],
input[type=button],
input[type=reset] {
	color: #textc; 
	margin: 0.5rem 0.2rem;
	padding: 2px;
}

input[type=reset] {
	min-width: 2rem;
}

input[type=checkbox] {
	margin-right: 0.5rem;
	width: 16px;
	height: 16px;
}

input[type=file] {
	color: #$resc;
	font-size: 0.9rem;
	min-width: 10rem;
}

form.main input[type=submit] {
	margin-left: 0;
}

form.main input[type=text] {
	width: 10rem;
}

form.main input[type=text].num {
	width: 2.3rem;
}

form.main input[type=text].code {
	width: 4rem;
}

form.back input,
form.article input,
label {
	border: none;
	margin: 0 2px;
	padding:0;
	font-size: 1rem;
	background-color: transparent;
	color: #$textc;
	text-decoration: underline;
}

form.page input {
	min-width: 6.5rem;
	margin: 0.5rem 0;
}

form.page input[type=button] {
	border-color:transparent;
	background-color: transparent;
	color: #$resc;
}

form.page .prev {
	margin-left: 0;
}

form.page .reload {
	min-width: 4rem;
	margin-left: 0.5rem;
}

</style>
EOF

	}

	return $css;

} # css end

1;