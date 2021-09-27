--- Unified high-level I/O utility API for Files, Sockets and TLS-Sockets.
-- These functions are added to the object function tables by doing <strong>
-- require "nixio.util"</strong>, can be used on all nixio IO  Descriptors and
-- are based on the shared low-level read() and write() functions.
-- @cstyle	instance
module "nixio.UnifiedIO"

--- Test whether the I/O-Descriptor is a socket. 
-- @class function
-- @name UnifiedIO.is_socket
-- @return	boolean

--- Test whether the I/O-Descriptor is a TLS socket. 
-- @class function
-- @name UnifiedIO.is_tls_socket
-- @return	boolean

--- Test whether the I/O-Descriptor is a file. 
-- @class function
-- @name UnifiedIO.is_file
-- @return	boolean

--- Read a block of data and wait until all data is available.
-- @class function
-- @name UnifiedIO.readall
-- @usage This function uses the low-level read function of the descriptor.
-- @usage If the length parameter is omitted, this function returns all data
-- that can be read before an end-of-file, end-of-stream, connection shutdown
-- or similar happens.
-- @usage If the descriptor is non-blocking this function may fail with EAGAIN.
-- @param	length	Bytes to read (optional)
-- @return	data that was successfully read if no error occurred
-- @return	- reserved for error code -
-- @return	- reserved for error message -
-- @return  data that was successfully read even if an error occurred

--- Write a block of data and wait until all data is written.
-- @class function
-- @name UnifiedIO.writeall
-- @usage This function uses the low-level write function of the descriptor.
-- @usage If the descriptor is non-blocking this function may fail with EAGAIN.
-- @param	block	Bytes to write
-- @return	bytes that were successfully written if no error occurred
-- @return	- reserved for error code -
-- @return	- reserved for error message -
-- @return  bytes that were successfully written even if an error occurred

--- Create a line-based iterator.
-- Lines may end with either \n or \r\n, these control chars are not included
-- in the return value.
-- @class function
-- @name UnifiedIO.linesource
-- @usage This function uses the low-level read function of the descriptor.
-- @usage <strong>Note:</strong> This function uses an internal buffer to read
-- ahead. Do NOT mix calls to read(all) and the returned iterator. If you want
-- to stop reading line-based and want to use the read(all) functions instead
-- you can pass "true" to the iterator which will flush the buffer 
-- and return the buffered data.
-- @usage If the limit parameter is omitted, this function uses the nixio
-- buffersize (8192B by default).
-- @usage If the descriptor is non-blocking the iterator may fail with EAGAIN.
-- @usage The iterator can be used as an LTN12 source.
-- @param	limit	Line limit
-- @return	Line-based Iterator

--- Create a block-based iterator.
-- @class function
-- @name UnifiedIO.blocksource
-- @usage This function uses the low-level read function of the descriptor.
-- @usage The blocksize given is only advisory and to be seen as an upper limit,
-- if an underlying read returns less bytes the chunk is nevertheless returned.
-- @usage If the limit parameter is omitted, the iterator returns data
-- until an end-of-file, end-of-stream, connection shutdown or similar happens.
-- @usage The iterator will not buffer so it is safe to mix with calls to read.
-- @usage If the descriptor is non-blocking the iterator may fail with EAGAIN.
-- @usage The iterator can be used as an LTN12 source.
-- @param	blocksize	Advisory blocksize (optional)
-- @param	limit		Amount of data to consume (optional)
-- @return	Block-based Iterator

--- Create a sink.
-- This sink will simply write all data that it receives and optionally
-- close the descriptor afterwards.
-- @class function
-- @name UnifiedIO.sink
-- @usage This function uses the writeall function of the descriptor.
-- @usage If the descriptor is non-blocking the sink may fail with EAGAIN.
-- @usage The iterator can be used as an LTN12 sink.
-- @param	close_when_done	(optional, boolean)
-- @return	Sink

--- Copy data from the current descriptor to another one.
-- @class function
-- @name UnifiedIO.copy
-- @usage This function uses the blocksource function of the source descriptor
-- and the sink function of the target descriptor.
-- @usage If the limit parameter is omitted, data is copied
-- until an end-of-file, end-of-stream, connection shutdown or similar happens.
-- @usage If the descriptor is non-blocking the function may fail with EAGAIN.
-- @param	fdout Target Descriptor
-- @param	size  Bytes to copy (optional)
-- @return	bytes that were successfully written if no error occurred
-- @return	- reserved for error code -
-- @return	- reserved for error message -
-- @return  bytes that were successfully written even if an error occurred

--- Copy data from the current descriptor to another one using kernel-space
-- copying if possible.
-- @class function
-- @name UnifiedIO.copyz
-- @usage This function uses the sendfile() syscall to copy the data or the
-- blocksource function of the source descriptor and the sink function
-- of the target descriptor as a fallback mechanism.
-- @usage If the limit parameter is omitted, data is copied
-- until an end-of-file, end-of-stream, connection shutdown or similar happens.
-- @usage If the descriptor is non-blocking the function may fail with EAGAIN.
-- @param	fdout Target Descriptor
-- @param	size  Bytes to copy (optional)
-- @return	bytes that were successfully written if no error occurred
-- @return	- reserved for error code -
-- @return	- reserved for error message -
-- @return  bytes that were successfully written even if an error occurred

--- Close the descriptor.
-- @class function
-- @name UnifiedIO.close
-- @usage	If the descriptor is a TLS-socket the underlying descriptor is
-- closed without touching the TLS connection.
-- @return	true
