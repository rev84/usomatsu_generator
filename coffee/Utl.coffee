class Utl
  ############################################
  #
  # 数値にカンマを入れる
  #
  # @param Number num
  # @return String
  #
  ############################################
  @numFormat:(num)->
    String(num).replace /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,'

  ############################################
  #
  # min <= n <= max の整数乱数を生成
  #
  # @param Number min
  # @param Number max
  # @return String
  #
  ############################################
  @rand:(min, max)->
    Math.floor(Math.random() * (max - min + 1)) + min

  ############################################
  #
  # length 文字のランダムな文字列を生成
  #
  # @param Number length
  # @return String
  #
  ############################################
  @genPassword:(length = 4)->
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    res = ''
    res += chars.substr(@rand(0, chars.length-1), 1) for i in [0...length]
    res

  ############################################
  #
  # アドレスバーを変更
  #
  # @param String url
  # @return String
  #
  ############################################
  @adrBar:(url)->
    window.history.replaceState '','',''+url


  ############################################
  #
  # getクエリを取得
  #
  # @return Object
  #
  ############################################
  @getQuery:(key = null, defaultValue = null)->
    query = document.location.search.substring(1)
    params = query.split('&')
    res = {}
    for p in params
      [k, v] = p.split('=')
      res[k] = v
    return res if key is null
    return res[key] if res[key]?
    defaultValue

  ############################################
  #
  # 数値を min <= num < max の範囲で正規化する
  #
  # @param Number num
  # @param Number min
  # @param Number max
  # @return String
  #
  ############################################
  @normalize:(num, min = 0, max = 1)->
    range = Math.abs(max - min)
    if num < min
      num += range * Math.ceil(Math.abs(num - min) / range)
    else if max <= num
      num -= range * (Math.floor(Math.abs(num - max) / range)+1)
    num


  ############################################
  #
  # 現在秒を取得
  #
  # @return int
  #
  ############################################
  @time:(date = null)->
    date = new Date() if date is null
    Math.floor(+date/1000)

  ############################################
  #
  # 現在ミリ秒を取得
  #
  # @return int/float
  #
  ############################################
  @militime:(date = null, getAsFloat = false)->
    date = new Date() if date is null
    +date / (if getAsFloat then 1000 else 1)


  ############################################
  #
  # 現在日を YYYY-MM-DD で取得
  #
  # @param Date date
  # @param String dateSep 日付のセパレータ
  # @return String
  #
  ############################################
  @dateStr:(date = null, dateSep = '-')->
    date = new Date() if date is null
    ''+@zerofill(date.getFullYear(), 4)+dateSep+@zerofill(date.getMonth()+1, 2)+dateSep+@zerofill(date.getDate(), 2)


  ############################################
  #
  # 現在日時を YYYY-MM-DD HH:ii:ssで取得
  #
  # @param Date date
  # @param String dateSep 日付のセパレータ
  # @param String timeSep 時間のセパレータ
  # @param boolean betweenSep 日付と時間の間の文字
  # @return String
  #
  ############################################
  @datetimeStr:(date = null, dateSep = '-', timeSep = ':', betweenSep = ' ')->
    date = new Date() if date is null
    @dateStr(date, dateSep)+betweenSep+
    @zerofill(date.getHours(), 2)+timeSep+@zerofill(date.getMinutes(), 2)+timeSep+@zerofill(date.getSeconds(), 2)


  ############################################
  #
  # baseDate と targetDate の時刻の差を「何分前」のような表記で取得
  #
  # @param Date targetDate 対象となる日時
  # @param Date baseDate 基準となる日時
  # @param unsigned_int nowSec ついさっき表記する上限の秒数
  # @param String agoStr ついさっき表記の文字列
  # @param String secStr 秒の表記
  # @param String minStr 分の表記
  # @param String hourStr 時間の表記
  # @param String dayStr 日の表記
  # @param String monStr 月の表記
  # @param String yearStr 年の表記
  # @return String
  #
  ############################################
  @difftime:(targetDate, baseDate = null, nowSec = 0, nowStr = 'ついさっき', agoStr = '前', secStr = '秒', minStr = '分', hourStr = '時間', dayStr = '日', monStr = '月', yearStr = '年')->
    baseTime = @time() if baseDate is null
    targetTime = @time(targetDate)
    diffTime = baseTime - targetTime

    # 未来
    return null if diffTime < 0

    # ついさっきと表示する基準の秒数
    return nowStr if nowSec >= diffTime

    # 一年以上
    y = Math.floor(diffTime / (60*60*24*30*12))
    return ''+y+yearStr+agoStr if y > 0
    diffTime -= y * (60*60*24*30*12)

    # 一ヶ月以上
    mo = Math.floor(diffTime / (60*60*24*30))
    return ''+mo+monStr+agoStr if mo > 0
    diffTime -= mo * (60*60*24*30)

    # 一日以上
    d = Math.floor(diffTime / (60*60*24))
    return ''+d+dayStr+agoStr if d > 0
    diffTime -= d * (60*60*24)

    # 一時間以上
    h = Math.floor(diffTime / (60*60))
    return ''+h+hourStr+agoStr if h > 0
    diffTime -= h * (60*60)

    # 一分以上
    m = Math.floor(diffTime / 60)
    return ''+m+minStr+agoStr if m > 0
    diffTime -= m * 60

    # 一秒以上
    return ''+diffTime+secStr+agoStr if diffTime > 0

    # ついさっき
    nowStr


  ############################################
  #
  # 数値をゼロ埋めする
  #
  # @param int num
  # @param int digit 桁数
  # @return int
  #
  ############################################
  @zerofill:(num, digit)->
    (''+@repeat('0', digit)+num).slice -digit


  ############################################
  #
  # str を times 回繰り返した文字列を返す
  #
  # @param String str
  # @param int times
  # @return String
  #
  ############################################
  @repeat:(str, times)->
    Array(1+times).join str


  ############################################
  #
  # 配列をシャッフル
  #
  # @param Array ary シャッフルする配列
  # @return Array
  #
  ############################################
  @shuffle:(ary)->
    n = ary.length
    while n
      n--
      i = @rand 0, n
      [ary[i], ary[n]] = [ary[n], ary[i]]
    ary


  ############################################
  #
  # 配列 ary に needle が存在するかを調べる
  #
  # @param mixed needle 値
  # @param Array ary
  # @return boolean 存在する場合はtrue, そうでないなら false
  #
  ############################################
  @inArray:(needle, ary)->
    for v in ary
      return true if v is needle
    false


  ############################################
  #
  # 配列のコピーを返す
  #
  # @param Array ary
  # @return Array
  #
  ############################################
  @clone:(obj)->
    res = obj
    if $.isArray obj
      res = $.extend true, [], obj
    else if obj instanceof Object
      res = $.extend true, {}, obj
    res


  ############################################
  #
  # 長さ length の配列を val で満たして返す
  #
  # @param int length
  # @param mixed val
  # @return Array
  #
  ############################################
  @arrayFill:(length, val = null)->
    res = []
    for i in [0...length]
      res[i] = @clone val
    res


  ############################################
  #
  # x * y の配列を val で満たして返す
  #
  # @param int x
  # @param int y 省略時は x と同じ長さ
  # @param mixed val
  # @return Array
  #
  ############################################
  @array2dFill:(x, y = null, val = null)->
    y = x if y is null
    res = []
    yAry = []
    for yy in [0...y]
      yAry[yy] = @clone val
    for xx in [0...x]
      res[xx] = @clone yAry
    res

  ############################################
  #
  # 配列の合計を返す
  #
  # @param Array ary
  # @return Array
  #
  ############################################
  @arraySum:(ary)->
    sum = 0
    sum += v for v in ary
    sum

  ############################################
  #
  # 配列の最小値を返す
  #
  # @param Array ary
  # @return Array
  #
  ############################################
  @arrayMin:(ary)->
    min = null
    for v in ary
      min = v if min is null or min > v
    min

  ############################################
  #
  # 配列の最大値を返す
  #
  # @param Array ary
  # @return Array
  #
  ############################################
  @arrayMax:(ary)->
    max = null
    for v in ary
      max = v if max is null or max < v
    max


  ############################################
  #
  # 連想配列のキーの数を返す
  #
  # @param Object object
  # @return int
  #
  ############################################
  @count:(object)->
    Object.keys(object).length


  ############################################
  #
  # uuid を生成（バージョン4）
  #
  # @return String
  #
  ############################################
  @uuid4:()->
    uuid = ''
    for i in [0...32]
      random = Math.random() * 16 | 0;
      uuid += '-' if i in [8, 12, 16, 20]
      uuid += (if i is 12 then 4 else (if i is 16 then random & 3 | 8 else random)).toString(16);
    uuid

  ############################################
  #
  # ローカルストレージの値を削除
  #
  # @param String key
  # @param mixed value
  # @return undefined
  #
  ############################################
  @delLs:(key)->
    localStorage.removeItem key

  ############################################
  #
  # ローカルストレージに値を設定
  #
  # @param String key
  # @param mixed value
  # @return undefined
  #
  ############################################
  @setLs:(key, value = null)->
    # null は削除
    return @delLs key if value is null

    json = JSON.stringify value
    localStorage.setItem key, json

  ############################################
  #
  # ローカルストレージから値を取得
  #
  # @param String key
  # @return undefined
  #
  ############################################
  @getLs:(key)->
    res = localStorage.getItem key
    try
      res = JSON.parse res
    catch
      res = null
    res
