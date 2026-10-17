Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0697260D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200063; cv=none; b=baKku5f4gwgA/eOVFpqZo6/tXzk0GV3z4l1ZQFwJUrc/M+p/GnbxNyMrdnR3XkyI2T+UemEceSE3niIqnfUwRJom95O3qluLodZkmCxO00qfvB9UEta/ckWBqHZThTvgNht07WOBwu3oyeFNCKPPOPMq2CVXP5PWJ4riVLiO8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200063; c=relaxed/simple;
	bh=E6X7T8DiUZzpXiLmdwpOm09FZsi5UuxSuH+D2AqIvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osKup6c5DhBtu6PqHVGg17KCyIZjUEI01tYNax7Qsc+cbdqQM53HpZTRAKoE9u4naOdIl5JxK3g8Uk8WjyR+TuCmZEmYYjAFA0OQGzAi/bZHCAzPJl8hHtWm2tJpAeBz7wRr4eTXciJX1gzfxf2Nf9dBOIv1/fFQwFq0XYMYDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwJhW5nH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwJhW5nH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd76b1361dso1976705ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200062; x=1792804862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+DNgBhwP4t+Jdnm8hXem+oWvC+sDLV2ygJ7M9AovjE=;
        b=CwJhW5nH23ol78OXE+M4NOpR+FDDn28OagNtFi3AKG+uqpAs7d7pJDrCxzncRWc4Hg
         wn8oGfk8TSEUQlvod6fvrdf9OceLC2qfVuyzrkSpLXPp1I0gpxGsZmHke4a4bQh3UGKm
         RSeE+O36uQ9up1kqY923VU/lFhnZY3q28CQMsGfpuotI9+RlICWUJOgqCB92chndJTzJ
         pVL/WXXoVFtCkzvIllzhZFapdGFT+mwU+Ty12QuasrB7MnrstSRzulOn78H9pCnC3Pfh
         C3ZnqqcDnH9/viOpWbrPg8Qn6hSNp2XwHDJBu5749RDac3xVXC1aiA9MCZz3jXJetGOz
         RPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200062; x=1792804862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+DNgBhwP4t+Jdnm8hXem+oWvC+sDLV2ygJ7M9AovjE=;
        b=yuoVkkUg7I3LNoHHdtcB82SI8HS/DeGmYgJYVhdrBINXercjpL259yOIZ9MEwFot77
         6hm8GYRVeQleFFLC/BbBoD57ZRNyon2V5WNbWrkZqqPB0gLPDakzCHvVZqdrFs4/2zJ8
         9Iml2+DDLJguyNzkkEHf02tDcjn77rslqKhYCpqJk9rh3XjJqmtPfw7AyQFxuN5xXL0b
         N5ZBNIPYDbCFOgYSSLxJB15KmIfDO/VwnD8AFiY+OIdkmWeixj38BMKUyE1XHXR3ATg7
         AGYaVcWWNo1mfSesIlVGYbUvNmrKWGZK36yrHEo7aLkjtVEqcodEQ16AzTkZxj2IPFyK
         zbEg==
X-Gm-Message-State: AFq9FYKpANvtLLTsasRavh68ZdC2K/3aRwfk/9XxrQ6sTnc0YP/dxrWD
	vOaJoieKbICh7zZpDG9qOfE0MWxlV6KWr5/5ZEGVbGkGwCj/jMeFrO7ZCaKyPvkt
X-Gm-Gg: AYBFou1zt3SbNM0W7IXmZoBX9Xb27OgKByjnhwMoHrKFO4zTIgYKQpHfJa7YJI7/1W3
	8YVGKUe9EqRHDGMBB+Bbhem4EUm8D+TtIrQF6vF61Y3txBom8WlebPh7NFi1LCebfQ8YTR3152C
	zne5q7qJB1/YOvQD9MAINDE/RwLIt9wtwEqulE3V7GZs1xb75BThFx3j1x+3n43azA37TAk4S+j
	oYZfSlpruFeQ7Zy7VPNLrc/cRT2XgYDaMlUmvkcZu+Yz+WwX9ch53DpSbrofazoGFkLmceL1W6v
	GUY3kLctP6bZqL2JQGPwCeQqofngr8hsIH+mF08USKKPCztzdlNqC5PvJZLO4ADkmcz7TCXirUQ
	pbD+Y7u+xR5fjOw/0PT9SM3iCfeUiI04YXgz1VvvEfquLHqtsDMrUr2PZ5WCMlNNozPrCrho00w
	DFujOEi6te64UtmvL8+aPGJZghYRumd4x66qF4+x+EUjrDn9mu7/GIr7LA90wu/0uhZbtNkuYn+
	Eag5QdXeKfOsZQwulnhKBjla1h7D0i78GY3yKNxL3F9FK/zN8D6NxHxSGMsjJt/RGNVuuGG8cT1
	kA/+v3WcyejHs3mJr2Lzt4soXMfvvt9zPdCpTU2k6L0C3L9L99Ol/w==
X-Received: by 2002:a17:902:f546:b0:2e9:84f2:3738 with SMTP id d9443c01a7336-2e9a6834a2emr14938225ad.6.1792200061224;
        Fri, 16 Oct 2026 18:21:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804eb4sm17192065ad.20.2026.10.16.18.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 00/38] bpf: Memory safety, lifetime and locking fixes
Date: Sat, 17 Oct 2026 01:20:20 +0000
Message-ID: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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
BPF side of the networking stack. All but patch 14 are from Josef.

Every bug was reproduced in a VM on top of bpf-next, on the kernel right
before and right after the patch that fixes it. The splats are in the
commit logs.

Sleeping, or doing without RCU, where that is not allowed:
  02 hash map for_each callbacks of sleepable programs
  05 sleepable programs on the task_vma iterator
  06 bpf_find_vma() callbacks of sleepable programs
  23 maps that rely on RCU in bpf_wq and bpf_task_work callbacks

Buffers that iterators and writable tracepoints hand to programs:
  18 BPF_LINK_UPDATE skips the size check of the attach
  24 tail calls from an iterator program
  25 extensions of an iterator program
  26 tail calls from a writable raw tracepoint program
  27 writes over bpf_timer, bpf_spin_lock, kptr in a live map value

The sk_storage map iterator:
  14 a socket that sk_clone() is still building can be found and used
  15 NULL dereference if the socket goes away
  16 the socket is not held while the program runs

Lifetime of local storage, programs and maps:
  10 owner_refcnt saturates on the last unpin
  28 map_free() frees elements under sleepable readers
  29 values of a dead owner are freed under sleepable programs
  21 a program is freed under its bpf_wq callback
  22 an inner map is freed under a sleepable callback
  30 the exception table of a program that still runs is not found

XDP and devices:
  01 devmap egress programs free page_pool fragments as plain pages
  19 stale offload->prog after bpf_prog_realloc()
  20 a program is bound to a netdev that is being unregistered
  32 cpumap uses the device of a queued frame after it is gone

seg6local End.BPF and bpf_skb_adjust_room():
  11 the SRH of the inner packet is not validated after End.DT6
  12 the inner header is not pulled for End.DT6
  13 stale SRH pointer if End.B6 fails late
  08 gso_size can drop to 0 or wrap around

skb dynptrs, where a write can reallocate the head of the skb:
  33 kfuncs that write through a dynptr
  34 bpf_dynptr_write() in a global function
  35 a dynptr passed to a global function
  36 the source of the write is a slice of the same skb
  37 overlapping source and destination
  38 slices as arguments of helpers that change the packet

The rest:
  03 inode leak if BPF_TOKEN_CREATE fails
  04 preallocated hash map hands out an element that is still linked
  07 BPF_JSET with a 64 bit mask, 32-bit kernels only
  09 probe names of a perf event are read without event_mutex
  17 unbounded recursion in the BTF show code
  31 BPF_PROG_TEST_RUN of sk_lookup uses the socket outside of RCU

Some of the fixes make the kernel refuse what it has accepted so far:

 - 02, 06: helpers, kfuncs and global functions that may sleep are rejected
   in these callbacks.
 - 05: sleepable programs cannot be attached to the task_vma iterator.
 - 23: in sleepable callbacks, and for inner maps in sleepable programs,
   maps that rely on RCU need bpf_rcu_read_lock().
 - 24, 26: a program with a tail call cannot be attached to a map element
   iterator or to a writable tracepoint.
 - 27: an iterator program that writes over a special field cannot be
   attached to that map.
 - 33-35, 38: packet pointers and slices are invalidated in more places.
   That hits some programs which are harmless at run time. A program that
   keeps a packet pointer across a global function which only writes to a
   ringbuf dynptr is one example.
 - 04: a nested update of a preallocated hash map on the same CPU can fail
   with -EBUSY.
 - 08: bpf_skb_adjust_room() returns -ENOTSUPP if gso_size would not stay
   positive.

test_progs in its three flavors, test_maps and test_verifier show no new
failures. cpumask/test_insert_leave is flaky when the tests run in
parallel, with and without the series: its program does not check
is_test_task(), so any other fork in the system makes it fail.

veristat sees no difference for the 5689 programs of the selftests: same
verdicts, insns, states and stack depth.

Alexei Starovoitov (1):
  bpf: Clear sk_refcnt of a clone before its storage is linked

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

 include/linux/bpf.h               |  24 +++-
 include/linux/bpf_local_storage.h |  13 ++
 include/linux/bpf_verifier.h      |   7 ++
 kernel/bpf/bpf_iter.c             |  31 ++++-
 kernel/bpf/bpf_local_storage.c    |  21 +++-
 kernel/bpf/btf.c                  |  14 ++-
 kernel/bpf/cfg.c                  |   4 +-
 kernel/bpf/core.c                 |  54 +++++---
 kernel/bpf/cpumap.c               |  35 ++++--
 kernel/bpf/devmap.c               |   1 +
 kernel/bpf/fixups.c               |   4 +
 kernel/bpf/hashtab.c              |  21 +++-
 kernel/bpf/helpers.c              |   9 +-
 kernel/bpf/map_in_map.c           |   7 +-
 kernel/bpf/map_iter.c             |  79 ++++++++----
 kernel/bpf/offload.c              |   9 +-
 kernel/bpf/states.c               |   3 +
 kernel/bpf/syscall.c              |  28 +++--
 kernel/bpf/task_iter.c            |  12 +-
 kernel/bpf/token.c                |   5 +-
 kernel/bpf/verifier.c             | 203 ++++++++++++++++++++++++------
 kernel/trace/bpf_trace.c          |  13 ++
 net/bpf/test_run.c                |  19 ++-
 net/core/bpf_sk_storage.c         |  96 ++++++++++++--
 net/core/filter.c                 |  58 +++++++--
 net/core/sock_map.c               |  17 ++-
 26 files changed, 631 insertions(+), 156 deletions(-)


base-commit: 645f5fcf7a5582f5d6ed2322f41cb34076c63b2c
-- 
2.55.0

