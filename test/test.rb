require File.join(File.dirname(__FILE__), '..', 'ext', 'md5partial')
require 'test/unit'


class TestPartial < Test::Unit::TestCase
  def test_chunked_partials
    # calculate a using a range of chunk sizes
    100.times do|i|
      buf_size = 10*(i+1)
      hasher = Digest::MD5Partial.new
      offset = 0
      total = File.size(__FILE__)

      until offset >= total do
        buf = nil
        File.open(__FILE__, 'rb') do|io|
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
      directly = Digest::MD5.hexdigest(File.read(__FILE__))
      assert_equal directly, from_partial
    end
  end
end
