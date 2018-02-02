# Cache Calculator

This is a little ruby script I've written to better understand
Fully Associative, Direct Mapped and K-Way Set-Associative-Caches

For education purpose

```ruby
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
```
Will output:
```
#############################
Fully Associative Cache
The cache is 4096 bytes (2^12)
We have a 22 bit address space
And one block is 64 bytes (2^6)

## Total blocks in cache ##
Cache size / block size = number of blocks
4096 / 64 = 64 blocks
= 2^6 blocks

## Tag and Offset ##
### Offset ###
log2(block size) = offset
log2(64) = 6 bit
### Tag ###
Address bits - offset = tag
22 - 6 = 22 bit tag

### Tag Overhead ###
Bits per tag * total number of blocks = overhead
22 * 64 = 1408 bit = 176 byte

#############################
4-Way Set-Associative
The cache is 65536 bytes (2^16)
We have a 32 bit address space
And one block is 32 bytes (2^5)

## Total blocks in cache ##
Cache size / block size = number of blocks
65536 / 32 = 2048 blocks
= 2^11 blocks

## Blocks per Way (= number of sets) ##
Total number of blocks / number of ways =
2048/4 = 512

### Size per Way ###
Blocks per way * Block size = bytes per way
512 * 32 = 16384 Byte
or
cache size / number of ways = bytes per way
65536 / 4 = 16384 Byte = 2^9 Byte

## Offset, Set and Tag ##
### Offset ###
log2(block size) = offset
log2(32) = 5 bit
### Set ###
log2(blocks per way) = set
log2(512) = 9 bit
### Tag ###
Address space - set - offset = tag
32 - 9 - 5 = 18 bit tag

### Tag Overhead ###
Bits per tag * total number of blocks = overhead
18 * 2048 = 65536 bit = 8192 byte

#############################
Direct Mapped Cache
The cache is 65536 bytes (2^16)
We have a 32 bit address space
And one block is 32 bytes (2^5)

## Total blocks in cache ##
Cache size / block size = number of blocks
65536 / 32 = 2048 blocks
= 2^11 blocks

Remember: A Direct Mapped Cache is a k-Way Set-Associative-Cache with only one way

## Offset, Set and Tag ##
### Offset ###
log2(block size) = offset
log2(32) = 5 bit
### Set ###
log2(blocks per way) = set
log2(2048) = 11 bit
### Tag ###
Address space - set - offset = tag
32 - 11 - 5 = 16 bit tag

### Tag Overhead ###
Bits per tag * total number of blocks = overhead
16 * 2048 = 65536 bit = 8192 byte
```
