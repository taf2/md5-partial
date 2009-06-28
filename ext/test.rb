require 'md5partial'

# read 10 bytes of this file at a time and compute a md5 partial of each chunk 

BUF_SIZE=1024

hasher = Digest::MD5Partial.new
offset = 0
total = File.size(__FILE__)

until offset >= total do
  buf = nil
  File.open(__FILE__, 'rb') do|io|
    io.seek(offset, IO::SEEK_SET)
    buf = io.readpartial(BUF_SIZE)
    hasher.update(buf)
  end

  # save the partial
  File.open("partial", "wb") do|io|
    str = hasher.save
    io << str
  end

  # restore the partial
  hasher.restore(File.read("partial"))

  # advance the offset
  offset += buf.size
end

puts hasher.hexdigest
system("md5sum #{__FILE__}")
