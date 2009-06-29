require File.join(File.dirname(__FILE__), '..', 'ext', 'md5partial')
require 'test/unit'


class TestPartial < Test::Unit::TestCase
  def test_chunked_partials
    files = Dir['../ext/*.*'].each do|file|
      print "test #{file} "
      from_partial = ""
      # calculate a using a range of chunk sizes
      100.times do|i|
        buf_size = 10*(i+1)
        hasher = Digest::MD5Partial.new
        offset = 0
        total = File.size(file)

        until offset >= total do
          buf = nil
          File.open(file, 'rb') do|io|
            io.seek(offset, IO::SEEK_SET)
            buf = io.readpartial(buf_size)
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

        from_partial = hasher.hexdigest
        directly = Digest::MD5.hexdigest(File.read(file))
        assert_equal directly, from_partial
      end
      puts from_partial
    end
  ensure
    File.unlink("partial") if File.exist?("partial")
  end
end
