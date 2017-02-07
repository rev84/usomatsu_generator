// Generated by CoffeeScript 1.10.0
var Utl, convertNum, exec, generate, getNow, getWord, tweet;

$().ready(function() {
  $('#generate').on('click', exec);
  $('.fontawesome-retweet').on('click', tweet);
  return exec();
});

exec = function() {
  var heartCount, replayCount, retweetCount;
  $('#twitter_body').html(generate());
  replayCount = Utl.rand(10, 100);
  retweetCount = Utl.rand(1000, 20000);
  heartCount = retweetCount + Utl.rand(1000, 20000);
  $('.fontawesome-reply').html(convertNum(replayCount));
  $('.fontawesome-retweet').html(convertNum(retweetCount));
  $('.fontawesome-heart').html(convertNum(heartCount));
  return $('.postdate').html(getNow());
};

tweet = function() {
  var text, url, w;
  text = decodeURIComponent($('#twitter_body').html() + ' %23嘘松ジェネレータ');
  url = 'http://twitter.com/share?url=' + location.href + '&text=' + text + ',scrollbars=yes,Width=575,Height=400';
  w = window.open(url);
  return w.focus();
};

generate = function() {
  var rand1, text;
  text = '';
  text += getWord('いつ');
  text += getWord('どこ') + 'で';
  text += getWord('誰') + 'が';
  text += getWord('どうし') + 'てるのに';
  text += getWord('誰') + 'が';
  text += getWord('どうし') + 'たので';

  /*
  if Utl.rand(1, 100) <= 50
    rand1 = Utl.rand(1, 100)
    if rand1 <= 30
      text += 'とりあえず'
    else if rand1 <= 60
      text += '思わず'
    text += getWord('どうし')+'た'
  else
    text += getWord('どう感じた')
   */
  rand1 = Utl.rand(1, 100);
  if (rand1 <= 30) {
    text += 'とりあえず';
  } else if (rand1 <= 60) {
    text += '思わず';
  }
  text += getWord('どう感じた');
  return text;
};

getWord = function(pattern) {
  return window.words[pattern][Utl.rand(0, window.words[pattern].length - 1)];
};

convertNum = function(num) {
  if ((1000 <= num && num <= 9999)) {
    return num.toLocaleString();
  } else if (10000 <= num) {
    return '' + (Math.floor(num / 1000) / 10) + '万';
  }
  return num;
};

getNow = function() {
  var NowDay, NowHour, NowMin, NowMon, NowSec, NowWeek, NowYear, Nowymdhms;
  Nowymdhms = new Date;
  NowYear = Nowymdhms.getYear() + 1900;
  NowMon = Nowymdhms.getMonth() + 1;
  NowDay = Nowymdhms.getDate();
  NowWeek = Nowymdhms.getDay();
  NowHour = ('0' + Nowymdhms.getHours()).slice(-2);
  NowMin = ('0' + Nowymdhms.getMinutes()).slice(-2);
  NowSec = ('0' + Nowymdhms.getSeconds()).slice(-2);
  return '' + NowHour + ':' + NowMin + ' - ' + NowYear + '年' + NowMon + '月' + NowDay + '日';
};

Utl = (function() {
  function Utl() {}

  Utl.numFormat = function(num) {
    return String(num).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
  };

  Utl.rand = function(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  };

  Utl.genPassword = function(length) {
    var chars, i, j, ref, res;
    if (length == null) {
      length = 4;
    }
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    res = '';
    for (i = j = 0, ref = length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      res += chars.substr(this.rand(0, chars.length - 1), 1);
    }
    return res;
  };

  Utl.adrBar = function(url) {
    return window.history.replaceState('', '', '' + url);
  };

  Utl.getQuery = function(key, defaultValue) {
    var j, k, len, p, params, query, ref, res, v;
    if (key == null) {
      key = null;
    }
    if (defaultValue == null) {
      defaultValue = null;
    }
    query = document.location.search.substring(1);
    params = query.split('&');
    res = {};
    for (j = 0, len = params.length; j < len; j++) {
      p = params[j];
      ref = p.split('='), k = ref[0], v = ref[1];
      res[k] = v;
    }
    if (key === null) {
      return res;
    }
    if (res[key] != null) {
      return res[key];
    }
    return defaultValue;
  };

  Utl.normalize = function(num, min, max) {
    var range;
    if (min == null) {
      min = 0;
    }
    if (max == null) {
      max = 1;
    }
    range = Math.abs(max - min);
    if (num < min) {
      num += range * Math.ceil(Math.abs(num - min) / range);
    } else if (max <= num) {
      num -= range * (Math.floor(Math.abs(num - max) / range) + 1);
    }
    return num;
  };

  Utl.time = function(date) {
    if (date == null) {
      date = null;
    }
    if (date === null) {
      date = new Date();
    }
    return Math.floor(+date / 1000);
  };

  Utl.militime = function(date, getAsFloat) {
    if (date == null) {
      date = null;
    }
    if (getAsFloat == null) {
      getAsFloat = false;
    }
    if (date === null) {
      date = new Date();
    }
    return +date / (getAsFloat ? 1000 : 1);
  };

  Utl.dateStr = function(date, dateSep) {
    if (date == null) {
      date = null;
    }
    if (dateSep == null) {
      dateSep = '-';
    }
    if (date === null) {
      date = new Date();
    }
    return '' + this.zerofill(date.getFullYear(), 4) + dateSep + this.zerofill(date.getMonth() + 1, 2) + dateSep + this.zerofill(date.getDate(), 2);
  };

  Utl.datetimeStr = function(date, dateSep, timeSep, betweenSep) {
    if (date == null) {
      date = null;
    }
    if (dateSep == null) {
      dateSep = '-';
    }
    if (timeSep == null) {
      timeSep = ':';
    }
    if (betweenSep == null) {
      betweenSep = ' ';
    }
    if (date === null) {
      date = new Date();
    }
    return this.dateStr(date, dateSep) + betweenSep + this.zerofill(date.getHours(), 2) + timeSep + this.zerofill(date.getMinutes(), 2) + timeSep + this.zerofill(date.getSeconds(), 2);
  };

  Utl.difftime = function(targetDate, baseDate, nowSec, nowStr, agoStr, secStr, minStr, hourStr, dayStr, monStr, yearStr) {
    var baseTime, d, diffTime, h, m, mo, targetTime, y;
    if (baseDate == null) {
      baseDate = null;
    }
    if (nowSec == null) {
      nowSec = 0;
    }
    if (nowStr == null) {
      nowStr = 'ついさっき';
    }
    if (agoStr == null) {
      agoStr = '前';
    }
    if (secStr == null) {
      secStr = '秒';
    }
    if (minStr == null) {
      minStr = '分';
    }
    if (hourStr == null) {
      hourStr = '時間';
    }
    if (dayStr == null) {
      dayStr = '日';
    }
    if (monStr == null) {
      monStr = '月';
    }
    if (yearStr == null) {
      yearStr = '年';
    }
    if (baseDate === null) {
      baseTime = this.time();
    }
    targetTime = this.time(targetDate);
    diffTime = baseTime - targetTime;
    if (diffTime < 0) {
      return null;
    }
    if (nowSec >= diffTime) {
      return nowStr;
    }
    y = Math.floor(diffTime / (60 * 60 * 24 * 30 * 12));
    if (y > 0) {
      return '' + y + yearStr + agoStr;
    }
    diffTime -= y * (60 * 60 * 24 * 30 * 12);
    mo = Math.floor(diffTime / (60 * 60 * 24 * 30));
    if (mo > 0) {
      return '' + mo + monStr + agoStr;
    }
    diffTime -= mo * (60 * 60 * 24 * 30);
    d = Math.floor(diffTime / (60 * 60 * 24));
    if (d > 0) {
      return '' + d + dayStr + agoStr;
    }
    diffTime -= d * (60 * 60 * 24);
    h = Math.floor(diffTime / (60 * 60));
    if (h > 0) {
      return '' + h + hourStr + agoStr;
    }
    diffTime -= h * (60 * 60);
    m = Math.floor(diffTime / 60);
    if (m > 0) {
      return '' + m + minStr + agoStr;
    }
    diffTime -= m * 60;
    if (diffTime > 0) {
      return '' + diffTime + secStr + agoStr;
    }
    return nowStr;
  };

  Utl.zerofill = function(num, digit) {
    return ('' + this.repeat('0', digit) + num).slice(-digit);
  };

  Utl.repeat = function(str, times) {
    return Array(1 + times).join(str);
  };

  Utl.shuffle = function(ary) {
    var i, n, ref;
    n = ary.length;
    while (n) {
      n--;
      i = this.rand(0, n);
      ref = [ary[n], ary[i]], ary[i] = ref[0], ary[n] = ref[1];
    }
    return ary;
  };

  Utl.inArray = function(needle, ary) {
    var j, len, v;
    for (j = 0, len = ary.length; j < len; j++) {
      v = ary[j];
      if (v === needle) {
        return true;
      }
    }
    return false;
  };

  Utl.clone = function(obj) {
    var res;
    res = obj;
    if ($.isArray(obj)) {
      res = $.extend(true, [], obj);
    } else if (obj instanceof Object) {
      res = $.extend(true, {}, obj);
    }
    return res;
  };

  Utl.arrayFill = function(length, val) {
    var i, j, ref, res;
    if (val == null) {
      val = null;
    }
    res = [];
    for (i = j = 0, ref = length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      res[i] = this.clone(val);
    }
    return res;
  };

  Utl.array2dFill = function(x, y, val) {
    var j, l, ref, ref1, res, xx, yAry, yy;
    if (y == null) {
      y = null;
    }
    if (val == null) {
      val = null;
    }
    if (y === null) {
      y = x;
    }
    res = [];
    yAry = [];
    for (yy = j = 0, ref = y; 0 <= ref ? j < ref : j > ref; yy = 0 <= ref ? ++j : --j) {
      yAry[yy] = this.clone(val);
    }
    for (xx = l = 0, ref1 = x; 0 <= ref1 ? l < ref1 : l > ref1; xx = 0 <= ref1 ? ++l : --l) {
      res[xx] = this.clone(yAry);
    }
    return res;
  };

  Utl.arraySum = function(ary) {
    var j, len, sum, v;
    sum = 0;
    for (j = 0, len = ary.length; j < len; j++) {
      v = ary[j];
      sum += v;
    }
    return sum;
  };

  Utl.arrayMin = function(ary) {
    var j, len, min, v;
    min = null;
    for (j = 0, len = ary.length; j < len; j++) {
      v = ary[j];
      if (min === null || min > v) {
        min = v;
      }
    }
    return min;
  };

  Utl.arrayMax = function(ary) {
    var j, len, max, v;
    max = null;
    for (j = 0, len = ary.length; j < len; j++) {
      v = ary[j];
      if (max === null || max < v) {
        max = v;
      }
    }
    return max;
  };

  Utl.count = function(object) {
    return Object.keys(object).length;
  };

  Utl.uuid4 = function() {
    var i, j, random, uuid;
    uuid = '';
    for (i = j = 0; j < 32; i = ++j) {
      random = Math.random() * 16 | 0;
      if (i === 8 || i === 12 || i === 16 || i === 20) {
        uuid += '-';
      }
      uuid += (i === 12 ? 4 : (i === 16 ? random & 3 | 8 : random)).toString(16);
    }
    return uuid;
  };

  Utl.delLs = function(key) {
    return localStorage.removeItem(key);
  };

  Utl.setLs = function(key, value) {
    var json;
    if (value == null) {
      value = null;
    }
    if (value === null) {
      return this.delLs(key);
    }
    json = JSON.stringify(value);
    return localStorage.setItem(key, json);
  };

  Utl.getLs = function(key) {
    var error, res;
    res = localStorage.getItem(key);
    try {
      res = JSON.parse(res);
    } catch (error) {
      res = null;
    }
    return res;
  };

  return Utl;

})();
