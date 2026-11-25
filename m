Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577383;
	b=GhLyPuPCNfD3sDhUTBiczkl9vcYbV7NiRe60uRjYP2jv+Vy0Re+hjPls6P62J9xZcR0A
	 IC9jHmsZ+llMrqxsIII67AT0uwCVEaZsG95mmvtaVW4PHyRtk9SenYK7/zwXKZFSzVqEN
	 DgUvFb+sfxchxnJxKmPG9j2bJTq+hUGfysTHm/+NspkjglASHWx/LyCx/5aK1sxVyYI3v
	 YaWNwsgI7hoQSxfvVJ602VSIWIxsXeYVuOF+P7kikpB05SCPDbRf93XqwTelS1YLTrs63
	 4IbsTbsVdPvhrUKX8ErwfpT2+cto3/NeAtFyWyi+bTNJDrYFXSbBFhSF0yKS4J4RpzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ecFsrDENCmfKFAmQ9a+4sIzBaM99QWewHcOCNgxQc/M=;
	b=WHFmTVlVdbo+k4F+qfIee+dPuycKLD3JA333gD2QL/RdCpoZrdXUG9868QKOmU51+PQ9
	 YOvb+nqAEez0/PiDmfaZM/igHPclUs1oUQm+HORJax9NjPBceqEWHtpCpPEKsvR8sn8D5
	 rXBqdoa7ugytI+M5iONsE5E3tQ/q3qwfuc1bRWqXti2nv8+8s2CxdjjEzjFBWzomYxHCF
	 DHEK0+m01SJnGAxBRaAof10IvLoIxsDEjDmBqwmm8Ubarww6qLVdweDXI8IM/dGAbM003
	 OU9CyXSajcfDq+jPTZfv4FPXAyZtieer4ORhdUg9V0It7WaD29wmd4fQukP4QKSxDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZihsHcH;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697A606A337
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0697A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZihsHcH
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso3410626b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577382; x=1796182182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ecFsrDENCmfKFAmQ9a+4sIzBaM99QWewHcOCNgxQc/M=;
        b=QZihsHcHPUpib28h8UVvOBcyvCrhiOtw8QeMoenr2ZLC743V2HMm2D97hCNn7xnz+P
         sQvMHFF321pDSOmVepIgxZAYy32gXNRMqkZdDT2qZHz64z1sPdYFOspjBI+cAOm4mXbD
         88UB30eyNK4qhXPf+X/mz+JmdCsPrecBQIS/IgpWHB5MBt0Eg0/PmMfjpCx9NTliwYSy
         uWXYxA89BqK73JYukrPKGouffG+G6rUZGkCblyuL/xPYGCw4R7e9zpEjUE+QX1O7j4xd
         wN9aCUn171qM+UKGFLJPspIvD51yD3Kdy/Tl53fGjWvcr/v2pk5MnDLujB81vDidPBYb
         +ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577382; x=1796182182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecFsrDENCmfKFAmQ9a+4sIzBaM99QWewHcOCNgxQc/M=;
        b=RT1AIdds5S4+PG+lTm6KJlwqaarQtY88sSngUFbhN1DzT6IchSgR/8er23cScDONqb
         22jT4O7VsQN3zUkTbQ3HM+/MSbyFV3RURSqC0yfYp8UaA+niIshqW0M/ScH6mi7/B7dn
         uZn9A2sAjBxSoFKU3Z1s6raaBWKwoA7c8GnSJB+hXsuIe5xx+jFBoXkclQrSPpaxGMup
         vp8w6+mrM6g0etzMhpQM0lbGMRBrX+4dZ2CdFs9fzSBx9Zyn9Kj5a8CQIlXznOgWE1y6
         37728e7XgwnLGCECw0325aK/WgQ2hLiLZS6aXtGPewHV0I65xOzjB30tm4A1s/ycbWhj
         O43A==
X-Gm-Message-State: APuU4Z+FPHlsQp/8dNIx1UrYGjEYtpObo2wKAmJ8nwAGN/HGI1eYJA3A
	WeLzC81xdJrPT9EBAlu8VSy8JXTOVu895zELvjDsmefXtPSRlXrceCuHhwk/0tOB
X-Gm-Gg: AZFdTZcVIgNV9/Wu4g+zDPu4KzdI5O5hfh2zc+Id8Q5mOSC/+Sl3TWX+8OC35NqXJxs
	LFBSRnH2+OhBXFV/fP8/KmzBDdJOhvGy0oJ2XhufK2rl6GsumssF0GMUbcW+dsr3/25kB49qW15
	j/zAOB2PcCXZ+x43TZr2v9WSOQPkBmXVnNpVD321ePFY1wCUlJeD3kS362KtTBcDVManS3UKExM
	WLKR8ksdoy40sdTfMT9U5gJ3NpTN5fy91o8ow27HUf+cvQEOHQoxGPa0X2doc+C8aL8m5bRAqHQ
	kLDT5PzW/fwVPOzJtx5x7oP6oGi5QJBOdQj5Pz7Hsc3ZHtH2suMb+7emAuKuT4FvCVy3varvzQh
	37xJg6Ef3w/RG79QQokSPE8Z4vhXcUG+fdYuiivxvNRl1uM1WK/oMeA/6dWh8GVnBsecH0wI+RY
	axMr1q5yEy8kRgu9ZloRPuvTvWlWsuVlu9SW9VcHHCS7lmEZtMIvyfurHlJNkFQyRx9qyt16Ibg
	AArkLY9dF/Qq3opGgCqc4faNSaBrXgeP9/Ttf35aUGa1MM8s5QLTTFXpVADvhEgWCVAhW5wFuo0
	m/9+JKOp19yFhJqJ1sPF5KkWyjwwZJMDscQx8no292d1MeO39Qv1MAItw6IEzXnLCxMCfFgNM67
	QXhuARmaiXXJR1DIMQg+ALZPsPNkOMq8CjcmOUt56yiDCSFIUnFd31sQ+viO0IEiC66uWxapq/Q
	==
X-Received: by 2002:a05:6372:a713:b0:3e1:7199:1edf with SMTP id adf61e73a8af0-4014d456c97mr10944533637.17.1795577382119;
        Tue, 24 Nov 2026 19:29:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cdfd2d2fc4sm2537836b3a.49.2026.11.24.19.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:29:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 00/47] bpf: Fixes for hooks, tail calls, CAP_BPF, JITs and sockmap
Date: Wed, 25 Nov 2026 03:28:51 +0000
Message-ID: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in BPF:

  patches  area
  -------  ----------------------------------------------------------------
  01-04    what the verifier trusts: pointers, attach types, ranges, ids
  05-08    extensions and tail calls: they run in the hook of another prog
  09       struct_ops: the struct of a prog
  10       bpffs: delegate options
  11-12    NULL in tracepoints and helpers
  13-15    bpf_throw(): tracers, KASAN, symbols, line info
  16       XDP redirect in async callbacks
  17-18    checks at attach and load: cgroup links, signed programs
  19-20    bpf_lock, dumps of the stack
  21-22    arena: the length of mmap(), TLB
  23-24    prints of BTF enums, the result of bpf_res_spin_lock()
  25-33    kernel addresses and tasks: CAP_BPF is not enough
  34-37    x86 and arm64 JIT
  38-43    skb, XDP, sk_msg and sockaddr helpers
  44-45    sockmap
  46       libbpf
  47       struct_ops: the type of r0 at exit

Some fixes refuse what was allowed:

  patch  refused now
  -----  ------------------------------------------------------------------
  01     pointers from a flexible array as arguments of helpers and kfuncs
  05     freplace of tp_btf, fmod_ret, LSM and struct_ops progs
  07     one prog array for two LSM hooks, two types of struct_ops, or
         tracepoints with other NULL args
  11     tp_btf/neigh_create: the neighbour as a trusted argument
  13     tracers of bpf_throw()
  17     BPF_LINK_UPDATE of a cgroup link to another attach type
  18     metadata maps of signed progs that can be mapped writable
  21     mmap() of a part of an arena
  35     misaligned atomics in arenas on x86: skipped at run time

  patch  needs CAP_PERFMON now
  -----  ------------------------------------------------------------------
  25     all but the base helpers in syscall progs
  26     kfuncs of arena and task work, bpf_send_signal_task(),
         bpf_wakeup_sources_get_head()
  27     streams
  28     variables of the kernel
  29     dumps of xlated insns
  31     open() of the bpffs file of a map with special fields but locks
  32     values of insn_array as memory
  33     inet_diag dump of all sk_storage maps

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (47):
  bpf: Do not trust pointers in flexible arrays
  bpf: Look at the type of a program next to expected_attach_type
  bpf: Do not take bpf_get_retval() of struct bpf_tcp_ops for an errno
  bpf: Do not allow bpf_d_path() by an id of another BTF
  bpf: Check that an extension fits the hook of its target
  bpf: Take the attach type of the target for tail calls of an extension
  bpf: Compare what a hook tells next to its prototype at tail calls
  bpf: Reserve cookie and ip in the trampoline for tail calls
  bpf: Check that a program and a struct_ops map are for the same struct
  bpf: Keep the names in front of a number in delegate options
  bpf: Do not trust the neighbour of tp_btf/neigh_create
  bpf: Check for NULL in helpers that take a kernel pointer
  bpf: Leave nothing behind in the frame of bpf_throw()
  bpf: Add the symbol of a prog before its id
  bpf: Do not fill jited line info for a hidden subprog
  bpf: Fix NULL dereference in XDP redirect from async callbacks
  bpf: Check the attach type when a cgroup link gets another program
  bpf: Refuse metadata maps of signed programs that can be mapped
    writable
  bpf: Take bpf_lock with interrupts disabled
  bpf: Bound the time that dumps of the stack take
  bpf: Refuse mmap() of a part of an arena
  bpf: Flush TLB when a page of arena replaces the scratch page
  bpf: Fix reads past an enum in prints of BTF data
  bpf: Give the error of bpf_res_spin_lock() a 32-bit range
  bpf: Give syscall programs without CAP_PERFMON the base helpers only
  bpf: Require CAP_PERFMON for kfuncs that leak pointers or touch tasks
  bpf: Require CAP_PERFMON to read streams
  bpf: Limit reads of variables of the kernel
  bpf: Require CAP_PERFMON for dumps of xlated insns
  bpf: Zero bpf_list_head in copies of map values
  bpf: Require CAP_PERFMON to read pinned maps with special fields
  bpf: Require CAP_PERFMON to pass values of insn_array as memory
  bpf: Require CAP_PERFMON for the dump of all storages of sockets
  bpf, x86: Do not use the paranoid ITS thunk
  bpf, x86: Enforce alignment of atomics in arenas
  bpf, x86: Fix the range of BPF code that has a frame pointer
  bpf, arm64: Restore the shadow call stack pointer after an exception
  bpf: Clear the data that bpf_msg_push_data() adds
  bpf: Fail loads from a network header that was not set
  bpf: Fix slices behind the end of an XDP packet
  bpf: Clear family and port of a short address for cgroup sockaddr
    hooks
  bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
  bpf: Keep the MAC header in bpf_skb_change_tail()
  bpf, sockmap: Keep the parser and sk_data_ready in sync
  bpf, sockmap: Hold the psock of the work in sk_psock_backlog()
  libbpf: Fix struct_ops members 59-61 and optional struct_ops maps
  bpf: Check the type of R0 at the exit of a struct_ops program

 Documentation/bpf/kfuncs.rst                  |  3 +-
 Documentation/bpf/signing.rst                 |  3 +-
 arch/arm64/net/bpf_jit_comp.c                 |  7 ++
 arch/x86/net/bpf_jit_comp.c                   | 53 ++++++++---
 include/linux/bpf.h                           | 31 +++++--
 include/linux/btf.h                           |  1 +
 include/linux/filter.h                        | 15 +++-
 include/uapi/linux/bpf.h                      |  3 +-
 kernel/bpf/arena.c                            | 40 +++++----
 kernel/bpf/bpf_struct_ops.c                   | 20 +++--
 kernel/bpf/btf.c                              | 49 +++++++++--
 kernel/bpf/cgroup.c                           | 29 +++++-
 kernel/bpf/core.c                             | 50 ++++++++---
 kernel/bpf/fixups.c                           |  7 ++
 kernel/bpf/helpers.c                          | 34 ++++---
 kernel/bpf/inode.c                            | 10 ++-
 kernel/bpf/stackmap.c                         |  2 +-
 kernel/bpf/stream.c                           | 25 +++++-
 kernel/bpf/syscall.c                          | 35 ++++++--
 kernel/bpf/verifier.c                         | 88 +++++++++++++++----
 kernel/sched/ext/internal.h                   |  5 +-
 kernel/trace/bpf_trace.c                      |  8 +-
 net/bpf/bpf_dummy_struct_ops.c                |  2 +-
 net/core/bpf_sk_storage.c                     |  4 +
 net/core/filter.c                             | 40 ++++++---
 net/core/skmsg.c                              | 14 ++-
 net/core/sock_map.c                           |  3 +-
 tools/include/uapi/linux/bpf.h                |  3 +-
 tools/lib/bpf/libbpf.c                        | 19 ++--
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  6 +-
 30 files changed, 469 insertions(+), 140 deletions(-)


base-commit: 81c6c8c608b6075846d3bd5b6f57958300a56eda
-- 
2.55.0

