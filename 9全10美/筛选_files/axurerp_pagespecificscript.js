﻿
var PageName = '筛选';
var PageId = 'c4748c1c3503409e8a9119b4c12bb4be'
var PageUrl = '筛选.html'
document.title = '筛选';
var PageNotes = 
{
"pageName":"筛选",
"showNotesNames":"False"}
var $OnLoadVariable = '';

var $CSUM;

var hasQuery = false;
var query = window.location.hash.substring(1);
if (query.length > 0) hasQuery = true;
var vars = query.split("&");
for (var i = 0; i < vars.length; i++) {
    var pair = vars[i].split("=");
    if (pair[0].length > 0) eval("$" + pair[0] + " = decodeURIComponent(pair[1]);");
} 

if (hasQuery && $CSUM != 1) {
alert('Prototype Warning: The variable values were too long to pass to this page.\nIf you are using IE, using Firefox will support more data.');
}

function GetQuerystring() {
    return '#OnLoadVariable=' + encodeURIComponent($OnLoadVariable) + '&CSUM=1';
}

function PopulateVariables(value) {
    var d = new Date();
  value = value.replace(/\[\[OnLoadVariable\]\]/g, $OnLoadVariable);
  value = value.replace(/\[\[PageName\]\]/g, PageName);
  value = value.replace(/\[\[GenDay\]\]/g, '21');
  value = value.replace(/\[\[GenMonth\]\]/g, '8');
  value = value.replace(/\[\[GenMonthName\]\]/g, '八月');
  value = value.replace(/\[\[GenDayOfWeek\]\]/g, '星期二');
  value = value.replace(/\[\[GenYear\]\]/g, '2012');
  value = value.replace(/\[\[Day\]\]/g, d.getDate());
  value = value.replace(/\[\[Month\]\]/g, d.getMonth() + 1);
  value = value.replace(/\[\[MonthName\]\]/g, GetMonthString(d.getMonth()));
  value = value.replace(/\[\[DayOfWeek\]\]/g, GetDayString(d.getDay()));
  value = value.replace(/\[\[Year\]\]/g, d.getFullYear());
  return value;
}

function OnLoad(e) {

}

var u3 = document.getElementById('u3');
gv_vAlignTable['u3'] = 'center';
var u21 = document.getElementById('u21');
gv_vAlignTable['u21'] = 'center';
var u16 = document.getElementById('u16');

var u12 = document.getElementById('u12');

var u15 = document.getElementById('u15');
gv_vAlignTable['u15'] = 'center';
var u4 = document.getElementById('u4');

u4.style.cursor = 'pointer';
if (bIE) u4.attachEvent("onclick", Clicku4);
else u4.addEventListener("click", Clicku4, true);
function Clicku4(e)
{
windowEvent = e;


if (true) {

	self.location.href="全部美酒1.html" + GetQuerystring();

}

}

var u0 = document.getElementById('u0');

var u8 = document.getElementById('u8');

var u19 = document.getElementById('u19');
gv_vAlignTable['u19'] = 'center';
var u10 = document.getElementById('u10');

var u17 = document.getElementById('u17');
gv_vAlignTable['u17'] = 'center';
var u22 = document.getElementById('u22');

var u25 = document.getElementById('u25');

u25.style.cursor = 'pointer';
if (bIE) u25.attachEvent("onclick", Clicku25);
else u25.addEventListener("click", Clicku25, true);
function Clicku25(e)
{
windowEvent = e;


if (true) {

	self.location.href="筛选到的美酒.html" + GetQuerystring();

}

}

var u5 = document.getElementById('u5');

var u1 = document.getElementById('u1');
gv_vAlignTable['u1'] = 'center';
var u9 = document.getElementById('u9');

var u14 = document.getElementById('u14');

var u20 = document.getElementById('u20');

var u6 = document.getElementById('u6');

var u2 = document.getElementById('u2');

var u11 = document.getElementById('u11');

var u23 = document.getElementById('u23');
gv_vAlignTable['u23'] = 'center';
var u24 = document.getElementById('u24');
gv_vAlignTable['u24'] = 'top';
var u13 = document.getElementById('u13');
gv_vAlignTable['u13'] = 'center';
var u18 = document.getElementById('u18');

var u7 = document.getElementById('u7');
gv_vAlignTable['u7'] = 'top';
if (window.OnLoad) OnLoad();
