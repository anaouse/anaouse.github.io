---
title: shixian6
date: 2025-08-22
author: anaouse
layout: doc
---

## grocery 2

- vector push_back:
    Check capacity:
    If size() == capacity()
        Vector typically doubles its capacity (1 → 2 → 4 → 8...)
    Copy/move elements: All existing elements are moved to the new memory
    Deallocate old memory: The previous memory block is freed
    Insert new element: The new element is added
    Vector going out of scope
    Deallocate current memory

- std::align

`void* std::align(std::size_t alignment,
                 std::size_t size,
                 void*& ptr,
                 std::size_t& space);`

m_currentPtr = 0x1002, alignment = 8, size = 4, space = 14

0x1002 is not multiple of 8.Nearest aligned address ≥ 0x1002 is 0x1008.

Skip 6 bytes.ptr becomes 0x1008.space = 14 - 6 = 8.

why use it:

Misalignment = UB in C++.

On x86 → sometimes just slow, sometimes a crash.

On ARM/SPARC → crash immediately.

For general allocators → must use std::align.

and it will be slow to read the unaligned data for cpu

but in internet protocol, we write the original bytes data, so do not align, because it will add redundant bytes

- waveout workflow

Find a buffer that the audio driver is not currently using.
If one is found, fill it with new MP3 data.
Submit it with waveOutWrite. The system will now set WHDR_INQUEUE on it.
The loop continues, looking for the next free buffer.
When the audio driver finishes playing a buffer, your wave_out_proc callback is triggered. The system clears the WHDR_INQUEUE flag, and your on_buffer_done method is called. That buffer is now available to be found by the for loop again.

- waveOutReset(m_hwave_out);
Stops all playing audio: Any audio blocks currently in the playback queue are immediately marked as done and are returned to the application.

Empties the playback queue: All pending audio blocks that were waiting to be played are also removed from the queue and returned to the application.

Invalidates the device handle: The handle m_hwave_out becomes invalid, and you should not use it for any further operations until you open the device again.

- dr_mp3
Init (drmp3_init_file_w) Opens the file (with fopen internally).Keeps a FILE* + decoder state inside your drmp3 struct (m_pmp3).Doesn’t slurp the whole file — just prepares to stream.

Read (drmp3_read_pcm_frames_s16):Figures out how many PCM frames you asked for.Reads enough raw MP3 bytes from the file (a few KB at a time).It calls fread().Decodes them internally (Huffman decode + synthesis filterbank).

Writes the decoded PCM into your buffer.

Advances its file read pointer automatically.

Next call:Continues where it left off.Keeps track of bit reservoir and filterbank history in m_pmp3.

Repeats until EOF.

Close (drmp3_uninit):Cleans up the internal buffer + closes the file.

- Condition variables

Condition variables are typically used in producer-consumer scenarios, where one thread produces data (e.g., pushes a command to a queue) and another thread consumes it (e.g., processes the command).

It helps avoid busy-waiting

The notify_one() function is a method that wakes up one thread (if any) that is currently waiting on the condition variable.

`m_command_cv.wait(lock, predicate)`

Atomically unlocks the mutex (lock.unlock()) and puts the thread to sleep, waiting on the condition variable.

When m_command_cv.notify_one() or notify_all() is called, the thread wakes up and re-locks the mutex (lock.lock()) before returning.It then checks the predicate (pred). If it’s false, it goes back to sleep. If true, it continues execution.

- `std::lock_guard<std::mutex> lock(m_command_mutex);`

wait until getting lock

and release after leave the scope

- vec.reserve(nums.size())

pre-allocate to speed up