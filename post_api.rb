require 'uri'
require 'net/http'
require 'json'
require 'pry'


zip_code_pattern = /\d{1,7}/

puts "郵便番号を入力（ハイフンなし）"
post_num = gets.chomp
@post_num = post_num

def post_get
  uri = URI("https://zipcloud.ibsnet.co.jp/api/search?zipcode=#{@post_num}")
  res = Net::HTTP.get_response(uri)
  @res_body = res.body if res.is_a?(Net::HTTPSuccess)
end

if zip_code_pattern === @post_num
  post_get

else
  puts "7桁の数字で入力してください  郵便番号を入力（ハイフンなし）"
  @post_num = gets.chomp
  post_get
end

#配列で一つづつキーハッシュで受け取る
data = JSON.parse(@res_body)
puts "都道府県：#{data["results"][0]['address1']} (#{data["results"][0]['kana1']})"
puts "都道府県：#{data["results"][0]['address2']} (#{data["results"][0]['kana2']})"
puts "都道府県：#{data["results"][0]['address3']} (#{data["results"][0]['kana3']})"
