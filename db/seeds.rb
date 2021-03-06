# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "started!"

# Prefecture
prefs = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県)
prefs.each_with_index do |pref, index|
  Pref.find_or_create_by(pref_code: sprintf("%02d",index+1), name: pref)
  print "."
end

require 'open-uri'
require 'json'

# Senkyoku
url = 'https://raw.githubusercontent.com/codeforjapan/codeforelection/master/data/json/postal2senkyoku.light.json'
file = open(url)
json = JSON.parse(file.read)
json.each do |address|
  begin
    senkyoku = Senkyoku.find_or_create_by(pref_code: address[1]["p"], senkyoku_no: address[1]["s"])
    zipcode = ZipCode.find_or_create_by(zip_code: address[0])
    SenkyokuZipCode.find_or_create_by(zip_code_id: zipcode.id, senkyoku_id: senkyoku.id)
    print "."
  rescue Exception => e
    p e
  end
end

# Party
Party.find_or_create_by(short_name: "こころ", full_name: "日本のこころ")
Party.find_or_create_by(short_name: "公明", full_name: "公明党")
Party.find_or_create_by(short_name: "共産", full_name: "日本共産党")
Party.find_or_create_by(short_name: "労働", full_name: "労働者党")
Party.find_or_create_by(short_name: "希望", full_name: "希望の党")
Party.find_or_create_by(short_name: "幸福", full_name: "幸福実現党")
Party.find_or_create_by(short_name: "新社", full_name: "新社会党")
Party.find_or_create_by(short_name: "民進", full_name: "民進党")
Party.find_or_create_by(short_name: "社民", full_name: "社会民主党")
Party.find_or_create_by(short_name: "立民", full_name: "立憲民主党")
Party.find_or_create_by(short_name: "維新", full_name: "日本維新の会")
Party.find_or_create_by(short_name: "自民", full_name: "自由民主党")
Party.find_or_create_by(short_name: "自由", full_name: "自由党")

puts "finished!"
