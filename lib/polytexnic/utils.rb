module Polytexnic::Utils
  def in_book_directory?
    files = Dir['**/*']

    is_book_directory = true

    Polytexnic::FORMATS.each do |format|
      unless files.any?{|file| File.extname(file) == ".#{format}"}
        puts "No #{format} found."
        is_book_directory = false
      end
    end
    return is_book_directory
  end

  def logged_in?
    Polytexnic::Config['api_key'].present?
  end

  UNITS = %W(B KB MB GB TB).freeze

  def as_size(number)
    if number.to_i < 1024
      exponent = 0

    else
      max_exp  = UNITS.size - 1

      exponent = ( Math.log( number ) / Math.log( 1024 ) ).to_i 
      exponent = max_exp if exponent > max_exp

      number  /= 1024 ** exponent
    end

    "#{number.round} #{UNITS[ exponent ]}"
  end
end