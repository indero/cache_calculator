#!/bin/env ruby
#
#The word Block translates to Zeile in German
class FullyAssociativeCache
  def initialize(size, address, block_size)
    @cache_size = size
    @address_bits = address
    @block_size = block_size
  end

  def number_of_blocks
    return @cache_size / @block_size
  end

  def print_info
    puts "The cache is #{@cache_size} bytes (2^#{Math.log(@cache_size,2).to_i})"
    puts "We have a #{@address_bits} bit address space"
    puts "And one block is #{@block_size} bytes (2^#{Math.log(@block_size,2).to_i})"
    puts
  end

  def print
    puts "#############################"
    puts "Fully Associative Cache"
    print_info
    print_number_of_blocks
    puts "## Tag and Offset ##"
    print_offset
    print_tag
    print_tag_overhead
  end

  def print_number_of_blocks
    puts "## Total blocks in cache ##"
    puts "Cache size / block size = number of blocks"
    puts "#{@cache_size} / #{@block_size} = #{number_of_blocks} blocks"
    puts "= 2^#{Math.log(number_of_blocks,2).to_i} blocks"
    puts
  end

  def print_tag
    puts "### Tag ###"
    puts "Address bits - offset = tag"
    puts "#{@address_bits} - #{offset} = #{tag} bit tag"
    puts
  end

  def tag_overhead
    return tag * number_of_blocks
  end

  def print_tag_overhead
    puts "### Tag Overhead ###"
    puts "Bits per tag * total number of blocks = overhead"
    puts "#{tag} * #{number_of_blocks} = #{tag_overhead} bit = #{tag_overhead/8} byte"
  end

  def offset
    return Math.log(@block_size,2).to_i
  end

  def tag
    return @address_bits - offset
  end

  def print_offset
    puts "### Offset ###"
    puts "log2(block size) = offset"
    puts "log2(#{@block_size}) = #{@offset} bit"
  end

end

class KWay < FullyAssociativeCache
  def initialize(ways, size, address, block_size)
    super(size, address, block_size)
    @number_of_ways = ways
  end

  def blocks_per_way
    return number_of_blocks / @number_of_ways
  end

  def size_per_way_variant_one
    return blocks_per_way * @block_size
  end

  def size_per_way_variant_two
    return @cache_size / @number_of_ways
  end

  def print_wayinfo
    puts "## Blocks per Way (= number of sets) ##"
    puts "Total number of blocks / number of ways ="
    puts "#{number_of_blocks}/#{@number_of_ways} = #{blocks_per_way}"
    puts
    puts "### Size per Way ###"
    puts "Blocks per way * Block size = bytes per way"
    puts "#{blocks_per_way} * #{@block_size} = #{size_per_way_variant_one} Byte"
    puts "or"
    puts "cache size / number of ways = bytes per way"
    puts "#{@cache_size} / #{@number_of_ways} = #{size_per_way_variant_two} Byte = 2^#{Math.log(size_per_way_variant_two).to_i} Byte"
    puts
  end

  def print
    puts "#############################"
    puts "#{@number_of_ways}-Way Set-Associative"
    print_info
    print_number_of_blocks
    print_wayinfo
    puts "## Offset, Set and Tag ##"
    print_offset
    print_set
    print_tag
    print_tag_overhead
  end

  def offset
    return Math.log(@block_size,2).to_i
  end

  def print_offset
    puts "### Offset ###"
    puts "log2(block size) = offset"
    puts "log2(#{@block_size}) = #{offset} bit"
  end

  def set
    return Math.log(blocks_per_way,2).to_i
  end

  def print_set
    puts "### Set ###"
    puts "log2(blocks per way) = set"
    puts "log2(#{blocks_per_way}) = #{set} bit"
  end

  def tag
    return @address_bits - set - offset
  end

  def print_tag
    puts "### Tag ###"
    puts "Address space - set - offset = tag"
    puts "#{@address_bits} - #{set} - #{offset} = #{tag} bit tag"
    puts
  end

end
class DirectMapped < KWay
  def initialize(size, address, block_size)
    super(1, size, address, block_size)
  end
  def print
    puts "#############################"
    puts "Direct Mapped Cache"
    print_info
    print_number_of_blocks
    puts "Remember: A Direct Mapped Cache is a k-Way Set-Associative-Cache with only one way"
    puts
    puts "## Offset, Set and Tag ##"
    print_offset
    print_set
    print_tag
    print_tag_overhead
  end

end

#Fully Associative Cache:
# 4KB Cache, 22 bit address space and 64 Byte per memory block
fac = FullyAssociativeCache.new(2**12, 22, 2**6)
puts fac.print
# 4-Way Set-Associative-Cache:
# 4 Way, 64KB Cache, 32 bit address space and 32 byte per memory Block
kway = KWay.new(4, 2**16, 32, 2**5)
puts kway.print
# DirectMapped Cache:
# 64KB Cache, 32 bit address space and 32 byte per memory Block
directmapped = DirectMapped.new(2**16, 32, 2**5)
puts directmapped.print
