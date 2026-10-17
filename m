Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB93A0E85
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255072; cv=none; b=JxX9mBbovLUaVRLjLGS1Jv0wM9oGItVHb1R42m/UCqj2Qqixb9Uy4VaXmT92Cm3cHqHZ01/ytXzdOqPTGPHGAa2RFnyM4G8yy8Sc2bcWwG2/eEu44pEjvZ2sSl37GJnF8lZz7+uodWzihF678XBvUnH0ORP+GZI7Aq3i3oafsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255072; c=relaxed/simple;
	bh=lb0E7N6byN6udJ/zryYu7Oe6yCES4ZqzJ/IgFZ97/RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzT5LIBREZp16OBJ2u/ucd/JoqERQPHPwr+wopota29HnF9VRx3XRILlVui+bmaabnTdjrH8OgSZp5yYxpVrf1h7s71s3fcyWParOu0KlYVaeiiyC+n/XUfSh5tuW/idPsSyIzRiVDCwQQByURWMxc2HioFy63EwcS/cg5O+KV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMcCYT/4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMcCYT/4"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so773511a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255069; x=1792859869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+POgER5o0/ZMTiHtgBJBIwU2HFeJNxjbMtGpX9jbXEY=;
        b=qMcCYT/4Bw+b7wILfhWAEjQJsEtIzfYYWeAmE6C2UrPpnmyRT3AYdyuvdZONIrPJ3R
         TWYe/LXB5U0KrggFazAKzGd0w7g9Q1f62qHELYimlLDED41rXJF3/qmOI081nkj80a3L
         KLF08ryFqlegOOfMabn4E6IFjpZWGmswTOtwEvnwcIrU2DeO+1YWVrgHd8HNgNNqMClT
         H5jdH1C6/1/xbAAsuwjH7j5U89O6JboOs+K/xZPzUVWgg30jNsrJD3k37D3cc13vUie4
         3xFEDum1QFMfwoxCFICdeaqJpI0cISHsiCIWDqaq+yUuejoYpA7ig52WQNlEICMCA94X
         arvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255069; x=1792859869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+POgER5o0/ZMTiHtgBJBIwU2HFeJNxjbMtGpX9jbXEY=;
        b=2ueVcep+bRK109v4t43qaDuz32y9W2/jRqMPXnNozf85rwTzuj2PJurEHsielttk5a
         bUxQPeziKAA17ecT0IeY7volAuLcDRiq2nQbdx7MqIta1047aBWh/rnJMh60BtBsbNdc
         BmWqsTlFP2m4sb+KfGeSPJvY9F+2X4PBwhk5UcomlRnfiDvw+QRI1J4mwpE27zzIwW3C
         f8Y7sVjGZgrkE1avDbkqh/AleQzAjZ+v0dmtmEB5m9v/O3kU+jfQt16XzSdFTaKD5M9F
         klZBSluh2ODFTugCHiw364h88H04KoZLVsVO/7p1fUjaU+4rI4z71xt5a2gbUeT7kE3o
         jMkg==
X-Gm-Message-State: AFq9FYLka2EKBTbVZl/c+pZH6RjI45VwK9nzZxl7ycwCh73pB5JFnDng
	1BKLWsY7g2VJOcbz6CcSO9uqIKkO/E+unvNEKj+VtsWChinAm4sLQMO+pFqF7A==
X-Gm-Gg: AYBFou1MKYxIPY7miDqv80aknQXGBCt18MQWn+V2evt4DdiJD5mul06a/cJgf1G0bQ6
	G/IkF2UbWZOA08SpmBBKeyQp86DuJHW8N1zgY0+3wWG4nlWs6N0nnM6klilYK79K3R59bFgmq9W
	Q4s8Pkg3MB+JG898v1Tsa49f3fNuCmu3ORtmVPA7oJfhJpEQuOmDXLOqmoReSpxIwFlNGv/rytD
	7sohttxzWjjfRL3BYtWk8jYpRaVlFb/Z+nG0Fc5f9mvHblARekj6mjxKXEYxQ313QnJqdAHd40r
	zjzys55mkVXG7ktZ7i5BQK8N1w2PbU2cwmZ4aAFkin4KfSwILI9E2Gif4XFc7RZzfC5KreY/oG3
	8Rk4ggS2lcZgA/KWNefrDadX68S5zcZ+OBlNJRYKjxwY0eHpBwUByvNCjXpqVlsoD3/7w8zku71
	DJqNlxKPyAWJxDM3PitKtd2kJGjaYng3q91TXzE291LfhXKC4GdVjN8au+zbktXtd5Lpda4usgJ
	+V7qZCKlyWLhM1imA0BFGg2gWdpz0Wah2klwqGfOgW+3cja3ba1LTJrLGRP2APFdQ6R4wPwWVKH
	MHvVNlA7ANZqqB5WqouI9l4la+1E6xjbqeMavgJChKY=
X-Received: by 2002:a17:90b:2e90:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3aceec73203mr2930547a91.17.1792255069262;
        Sat, 17 Oct 2026 09:37:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1e1esm8727883a91.1.2026.10.17.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:37:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 00/43] bpf: Memory safety, lifetime and locking fixes
Date: Sat, 17 Oct 2026 16:37:02 +0000
Message-ID: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

This series collects fixes for bugs in the BPF core, the verifier and the
BPF side of the networking stack. Most of them are from Josef.

Every bug was reproduced in a VM on top of bpf-next, on the kernel right
before and right after the patch that fixes it. The splats are in the
commit logs. That goes for what the reviews of v1 have found as well.

Sleeping, or doing without RCU, where that is not allowed:
  02 hash map for_each callbacks of sleepable programs
  05 sleepable programs on the task_vma iterator
  06 bpf_find_vma() callbacks of sleepable programs
  24 maps that rely on RCU in bpf_wq and bpf_task_work callbacks
  32 extensions of functions that run sleepable

Buffers that iterators and writable tracepoints hand to programs:
  19 BPF_LINK_UPDATE skips the size check of the attach
  25 tail calls from an iterator program
  26 extensions of an iterator program
  27 tail calls from a writable raw tracepoint program
  28 extensions of a writable raw tracepoint program
  29 writes over bpf_timer, bpf_spin_lock, kptr in a live map value

The sk_storage map iterator:
  14 a socket that sk_clone() is still building can be found and used
  15 NULL dereference if the socket goes away
  16 an element of a storage that was never published can be found
  17 the socket is not held while the program runs

Lifetime of local storage, programs and maps:
  10 owner_refcnt saturates on the last unpin
  30 map_free() frees elements under sleepable readers
  31 values of a dead owner are freed under sleepable programs
  22 a program is freed under its bpf_wq callback
  23 an inner map is freed under a sleepable callback
  33 the exception table of a program that still runs is not found

XDP and devices:
  01 devmap egress programs free page_pool fragments as plain pages
  20 stale offload->prog after bpf_prog_realloc()
  21 a program is bound to a netdev that is being unregistered
  35 cpumap uses the device of a queued frame after it is gone

seg6local End.BPF and bpf_skb_adjust_room():
  11 the SRH of the inner packet is not validated after End.DT6
  12 the inner header is not pulled for End.DT6
  13 stale SRH pointer if End.B6 fails late
  08 gso_size can drop to 0 or wrap around

skb dynptrs, where a write can reallocate the head of the skb:
  36 kfuncs that write through a dynptr
  37 bpf_dynptr_write() in a global function
  38 a dynptr passed to a global function
  39 extensions get the unclone prologue without an skb in R1
  40 kfuncs that write through a dynptr do not unclone the skb
  41 the source of the write is a slice of the same skb
  42 overlapping source and destination
  43 slices as arguments of helpers that change the packet

The rest:
  03 inode leak if BPF_TOKEN_CREATE fails
  04 preallocated hash map hands out an element that is still linked
  07 BPF_JSET with a 64 bit mask, 32-bit kernels only
  09 probe names of a perf event are read without event_mutex
  18 unbounded recursion in the BTF show code
  34 BPF_PROG_TEST_RUN of sk_lookup uses the socket outside of RCU

Some of the fixes make the kernel refuse what it has accepted so far:

 - 02, 06: helpers, kfuncs and global functions that may sleep are rejected
   in these callbacks.
 - 05: sleepable programs cannot be attached to the task_vma iterator.
 - 24: in sleepable callbacks, and for inner maps in sleepable programs,
   maps that rely on RCU need bpf_rcu_read_lock().
 - 25, 27: a program with a tail call cannot be attached to a map element
   iterator or to a writable tracepoint.
 - 29: an iterator program that writes over a special field cannot be
   attached to that map.
 - 36-38, 43: packet pointers and slices are invalidated in more places.
   That hits some programs which are harmless at run time. A program that
   keeps a packet pointer across a global function which only writes to a
   ringbuf dynptr is one example.
 - 04: a nested update of a preallocated hash map on the same CPU can fail
   with -EBUSY.
 - 08: bpf_skb_adjust_room() returns -ENOTSUPP if gso_size would drop below
   TCP_MIN_GSO_SIZE.
 - 28: writable raw tracepoint programs cannot be extended.
 - 32: the main function of a sleepable program, and a global function that
   is called without the RCU read lock, cannot be extended. The
   summarization selftest is adjusted.
 - 39: an extension that writes to packet data has to get the context as
   its first argument, and scalars beside it.

test_progs in its three flavors, test_maps and test_verifier show no new
failures. cpumask/test_insert_leave is flaky when the tests run in
parallel, with and without the series: its program does not check
is_test_task(), so any other fork in the system makes it fail.

veristat sees no difference for the 5689 programs of the selftests, nor for
the 466 programs of the sched_ext schedulers that BPF CI builds: same
verdicts, insns, states and stack depth.

v1 -> v2, all of it after the reviews by sashiko and the BPF CI bot:
 - rebased
 - 04: cancel the special fields before the element goes into the slot
 - 08: leave at least TCP_MIN_GSO_SIZE
 - 16: new. The check in 17 did not hold for a storage that lost the race
   in bpf_local_storage_alloc().
 - 20: update offload->prog under bpf_devs_lock, in
   bpf_jit_prog_release_other() as well
 - 24: a global function that is called with preemption or interrupts
   disabled got around the check
 - 28, 32: new. Extensions got around 27 and 31.
 - 31: leave the special fields to the RCU Tasks Trace callback too
 - 39, 40: new. The kfuncs of 36 wrote to cloned skbs. 39 is needed for
   40 not to give the prologue to extensions that cannot take it.
 - 41: make the skb writable once
 - 18: no change. bpf_snprintf_btf() and bpf_seq_printf_btf() only take
   vmlinux BTF, and the map read in bpffs is BTF_SHOW_UNSAFE.

v1: https://lore.kernel.org/bpf/20261017012058.355787-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (6):
  bpf: Clear sk_refcnt of a clone before its storage is linked
  bpf: Link the first element after its storage is published
  bpf: Don't take an extension for a writable raw tracepoint program
  bpf: Don't take an extension for a function that runs sleepable
  bpf: Refuse the prologue for an extension that cannot take it
  bpf: Unclone the skb for kfuncs that write through a dynptr

Josef Bacik (37):
  bpf: use the frame mem type in devmap egress XDP
  bpf: forbid sleeping in hash map for_each callbacks
  bpf: don't leak the inode when token creation fails
  bpf: don't hand out a linked element as extra element
  bpf: reject sleepable programs for task_vma iterator
  bpf: forbid sleeping in bpf_find_vma() callbacks
  bpf: look at all 64 bits of a BPF_JSET mask on 32-bit
  bpf: don't let bpf_skb_adjust_room() use up the MSS
  bpf: Read the probe of a perf event under event_mutex
  bpf: Don't saturate owner_refcnt on the last unpin
  bpf: Validate the SRH which End.DT6 uncovers in End.BPF
  bpf: Pull the inner header for End.DT6 in End.BPF
  bpf: Update the SRH state if End.B6 fails late
  bpf: Fix NULL deref in the sk_storage map iterator
  bpf: Hold the socket in the sk_storage map iterator
  bpf: Bound the nesting that the BTF show code follows
  bpf: Check the new program of an iterator link update
  bpf: Fix stale offload->prog pointer after realloc
  bpf: Don't bind a program to a netdev that goes away
  bpf: Keep a program until its bpf_wq callback has ended
  bpf: Count sleepable callbacks as sleepable map users
  bpf: Check the maps that sleepable callbacks use
  bpf: Assume no bounds for buffers behind a tail call
  bpf: Don't take an extension for an iterator program
  bpf: Assume no bounds for a writable tp with tail calls
  bpf: Keep iterator programs off special map fields
  bpf: Free what map_free() unlinks for sleepable readers
  bpf: Keep values of a dead owner for sleepable programs
  bpf: Keep the symbols of a program until it has ended
  bpf: Use the socket of a sk_lookup test run under RCU
  bpf, cpumap: Hold the device of frames in the queue
  bpf: Drop packet pointers behind kfuncs writing an skb
  bpf: Let bpf_dynptr_write() mark a global function
  bpf: Don't take a dynptr argument for a local dynptr
  bpf: Follow the head if an skb is written from a slice
  bpf: Use memmove() to store bytes in an skb
  bpf: Refuse packet slices for packet-changing helpers

 include/linux/bpf.h                           |  43 ++-
 include/linux/bpf_local_storage.h             |  13 +
 include/linux/bpf_verifier.h                  |   9 +
 kernel/bpf/bpf_iter.c                         |  31 +-
 kernel/bpf/bpf_local_storage.c                |  50 +++-
 kernel/bpf/btf.c                              |  14 +-
 kernel/bpf/cfg.c                              |   4 +-
 kernel/bpf/core.c                             |  56 ++--
 kernel/bpf/cpumap.c                           |  35 ++-
 kernel/bpf/devmap.c                           |   1 +
 kernel/bpf/fixups.c                           |  30 ++
 kernel/bpf/hashtab.c                          |  22 +-
 kernel/bpf/helpers.c                          |   9 +-
 kernel/bpf/map_in_map.c                       |   7 +-
 kernel/bpf/map_iter.c                         |  79 +++--
 kernel/bpf/offload.c                          |  25 +-
 kernel/bpf/states.c                           |   3 +
 kernel/bpf/syscall.c                          |  28 +-
 kernel/bpf/task_iter.c                        |  12 +-
 kernel/bpf/token.c                            |   5 +-
 kernel/bpf/verifier.c                         | 269 +++++++++++++++---
 kernel/trace/bpf_trace.c                      |  13 +
 net/bpf/test_run.c                            |  19 +-
 net/core/bpf_sk_storage.c                     |  96 ++++++-
 net/core/filter.c                             |  58 +++-
 net/core/sock_map.c                           |  17 +-
 .../selftests/bpf/prog_tests/summarization.c  |  21 +-
 27 files changed, 781 insertions(+), 188 deletions(-)


base-commit: 458575e1f2ddea944d679fe778c92e370a9b61a4
-- 
2.55.0

