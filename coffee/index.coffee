$().ready ->
  $('#generate').on 'click', ->
    $('#twitter_body').html generate()
    replayCount = Utl.rand(10, 100)
    retweetCount = Utl.rand(1000, 20000)
    heartCount = retweetCount + Utl.rand(1000, 20000)
    $('.fontawesome-reply').html(convertNum(replayCount))
    $('.fontawesome-retweet').html(convertNum(retweetCount))
    $('.fontawesome-heart').html(convertNum(heartCount))
    $('.postdate').html(getNow())

  $('.fontawesome-retweet').on 'click', tweet
    

tweet = ->
  text = decodeURIComponent $('#twitter_body').html()+' #嘘松ジェネレータ'
  url = 'http://twitter.com/share?url='+location.href+'&text='+text+',scrollbars=yes,Width=575,Height=400'
  w = window.open(url)
  w.focus()


generate = ->
  text = ''

  text += getWord('いつ')
  text += getWord('どこ')+'で'
  text += getWord('誰')+'が'
  text += getWord('どうし')+'てるのに'
  text += getWord('誰')+'が'
  text += getWord('どうし')+'たので'
  ###
  if Utl.rand(1, 100) <= 50
    rand1 = Utl.rand(1, 100)
    if rand1 <= 30
      text += 'とりあえず'
    else if rand1 <= 60
      text += '思わず'
    text += getWord('どうし')+'た'
  else
    text += getWord('どう感じた')
  ###
  rand1 = Utl.rand(1, 100)
  if rand1 <= 30
    text += 'とりあえず'
  else if rand1 <= 60
    text += '思わず'
  text += getWord('どう感じた')

  text


getWord = (pattern)->
  window.words[pattern][Utl.rand(0, window.words[pattern].length-1)]

convertNum = (num)->
  if 1000 <= num <= 9999
    return num.toLocaleString()
  else if 10000 <= num
    return ''+(Math.floor(num / 1000) / 10)+'万'
  num

getNow = ->
  Nowymdhms = new Date
  NowYear = Nowymdhms.getYear() + 1900
  NowMon = Nowymdhms.getMonth() + 1
  NowDay = Nowymdhms.getDate()
  NowWeek = Nowymdhms.getDay()
  NowHour = ('0'+Nowymdhms.getHours()).slice(-2)
  NowMin = ('0'+Nowymdhms.getMinutes()).slice(-2)
  NowSec = ('0'+Nowymdhms.getSeconds()).slice(-2)

  ''+NowHour+':'+NowMin+' - '+NowYear+'年'+NowMon+'月'+NowDay+'日'