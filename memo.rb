require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。
if memo_type == 1

  puts "拡張子を除いたファイル名を入力してください"
  filename = gets.chomp + ".csv"
  puts "メモしたい内容を入力してください"
  puts "完了したら、Ctrl+Dを押します"
  content = $stdin.read.chomp
  CSV.open(filename, 'w') do |csv|
    csv << [content]
  end
  puts "csvの作成が完了しました"

elsif memo_type == 2

  puts "既存のメモを編集します。拡張子を除いた既存ファイル名を入力してください"
  filename = gets.chomp + ".csv"

  begin
    csv_data = CSV.read(filename)
  rescue Errno::ENOENT
    puts "指定されたファイル名は見つかりませんでした"
    return
  end # ファイル名が存在したら次の処理へ行く

  puts "ファイルを読み込みました。内容を表示します"
  csv_data.each_with_index do |row, index|
    # 各行を改行文字で分割し、それぞれの行ごとに処理する
    row_contents = row.first.split("\n")
    row_contents.each_with_index do |content|
      puts "#{content}"
    end
  end

  puts "内容の編集を行ってください"
  puts "完了したら、Ctrl+Dを押します"
  new_content = $stdin.read.chomp

  CSV.open(filename,'w') do |csv|
    csv << [new_content]
  end

  puts "変更を保存しました。"

else
  puts "1か2の数字を入力してください"
end