$().ready ->
  $('#generate').on 'click', ->
    $('#text').html generate()


generate = ->
  text = ''

  text += getWord('いつ')
  text += getWord('どこ')+'で'
  text += getWord('誰')+'が'
  text += getWord('どうし')+'て、'
  text += getWord('誰')+'が'
  text += getWord('どうし')+'てるのに'
  text += getWord('誰')+'が'
  text += getWord('どうし')+'たので'
  if Utl.rand(1, 100) <= 50
    rand1 = Utl.rand(1, 100)
    if rand1 <= 30
      text += 'とりあえず'
    else if rand1 <= 60
      text += '思わず'
    text += getWord('どうし')+'た'
  else
    text += getWord('どう感じた')

  text


getWord = (pattern)->
  window.words[pattern][Utl.rand(0, window.words[pattern].length-1)]