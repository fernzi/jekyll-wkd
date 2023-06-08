# frozen_string_literal: true

module JekyllWKD
  module ZBase32
    CHAR = "ybndrfg8ejkmcpqxot1uwisza345h769"
    SIZE = 5
    MASK = (1 << SIZE) - 1

    def self.encode str
      blocks(str, SIZE).map(&:encode).join
    end

    def self.blocks str, size
      str.bytes.reverse.each_slice(size).map { |b| Block.new b }.reverse
    end

    class Block
      def initialize bytes
        @bytes = bytes
      end

      def encode
        n = -(@bytes.length * -8 / SIZE)
        c = @bytes.reverse.reduce(0) { |a, b| (a << 8) + b }
        (n - 1).downto(0).map { |i| CHAR[(c >> i * SIZE) & MASK] }
      end
    end
  end
end
