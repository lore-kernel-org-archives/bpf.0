Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819465;
	b=isnUARSnV5vha/nviK8Z4exPOyN3G9hofar4FclmiZi30VSl7p15wL1cTVgkN7Or91UU
	 LOfcEaalP2WaeqL+Us/B31v2d3G5RiP6W/BZaoh2xPLkWdBBHXN43wNEetgxiefb8vXoW
	 10DbI+fcxzzgOB7GCpWtoBS0CnmAZx8NTUFYVog3Apq5p7Im7cZGz9ugdzKM1fVoLFRTX
	 cwSKIfM93LjMLvWz95C5fKouVnkI1MFVF10HpbCR8Ng80PFueT2tOzPaaloGkN7Fe5EfJ
	 nFzQAjVn6hNmer5wGTCZQPXTP8tp9IBm+A6p9gyp2/NyS0jVoNH47wB+3n9uKg78gFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nU5rNLFGPxyXsNrIEfmTxZBEBLqtZPzeLMQJ6cEA7gU=;
	b=hDRU0fPBSLSqLjvMGPvnG42r22wABwo66cyfp/YRMDU4OqXZRsEd0KoFbUtmfhyzOYp9
	 OpmLFXmFxaBPRNvniz8RCjzIZvG8xq0vKvXM1w5QUAhhs8LjeEOMfUZHVdShduDeUny8Q
	 /EYjeIGA+xnwdhUAKNXhxOnHQYLFyYrUrTo3Ba7vVETwCumeLvHkl4lhMsEdQlYLyl5GY
	 ijbanBBvyhE7xxIpB3CE9OlBxREuDqkoe/0llOC208pnLq5YeqnI0xdOsgbPfFWookXPu
	 rpX9NTW2OmMe3YkqPdRL+t9Riu5lT4AAhFCgsLqMXKNaCv9ha41Bh9FrQ0ALEk6hlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNLZTk9C;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58326606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 22:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58326606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNLZTk9C
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f04bea9a93so74964695ad.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 14:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795819465; x=1796424265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nU5rNLFGPxyXsNrIEfmTxZBEBLqtZPzeLMQJ6cEA7gU=;
        b=rNLZTk9CHG4qWkkmPt4d0PgFoA4lJXmSuO5HSGToCb1WuawrDxaLtlpi4s8BiLSr4b
         DBjLfgTGv63JgMaI/sQrpSbQC5oHTisi7t/VnEkktMACo0VMnk/JpAT+eZFvGxgOdGj1
         9MhEGZqCHBwvRZdCOtoOo5LMXob72TikB6SdXllKw2YDajhtYedBWZ6w6WK8bj6S0SFJ
         FvjG/74PTcvBQiTuKLtD4QicFJhNbiCcr8y3Ut16YmkcPei2olVAmH3G0qoqh5eAzxcR
         AjYJIRfOBziT69LBUMzYWEbXjpjvCkNti9+jMQmi8drns5NCD4SLyk6MGbv6EMhkPy4j
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795819465; x=1796424265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nU5rNLFGPxyXsNrIEfmTxZBEBLqtZPzeLMQJ6cEA7gU=;
        b=S1KIEE5WHOZfqVTqoTBoEgn/VbkDBZpMlHWiK0y3ia6VTNh80awlKQT7PhYRWZLj/5
         LX6AFnwi63Sk0Dqvhk85XeRd75ZCtJCWYteEf3473tVhavnynS+9LeMYy3fEciPngjPj
         HoRDb93eVeWR89Cl9QhSyArf46vAA/ugMZ2Y/eqsnME2h5bt/obIx4yRlA2dHiJG3KDm
         YdMRXwkA+lHzls3GLzdnVL7XmCGqWA6lX+aHJLxyAiAjAIp36OlTlSEmlULRxJ1OtiyT
         87EJpo3Xgbn23qGnA69I3mzKXxNoRsZdr1x+BV+oOloDEjVB7N8+R0W1X5+ofiVeYlvQ
         Qz+A==
X-Gm-Message-State: APuU4Z/CpA87ij5DG5+Kt1EG0PRBQvdwWs5Kgu+2k1vT9Pz2+nt0q5m5
	SD8eam1unI9rPntumeR0HRYZk2hhEUn6J2J5+BaIU0y427RjuckMt6LL
X-Gm-Gg: AZFdTZfvfrYDzXr4kHvfix/WvnMQBxOtXfRTSao7UEPyi4VtNFSGOpvV0ts0kMU/wiR
	YGpoliC+4Xc2oEdmCVxrXL6lef7+ycX6J++VYEXyVCbC711GzQeItwz+ciN0p8I2dV+ktMVmcrz
	+QTHB+ZJVv8j6s5QnCkdDU+OgK2xKNkwQb3KPRXX+5ZtGL8s/I8LPTtpX5akkBLdl1/ard4Vmyo
	GasW8aBZ9St0knwUhwdIZC2OKI7qPQQw/yLar0ShFRzD+AASl7figH/pqTkFOfFPfGYHwKq8qz4
	++C/kIXYl0sFzzafgzRDl7yFzqnQ3XHtC401BFgTU6VgKL0/XhgSJm/2ieT4Xp2VeybXo6mBKuz
	cB/2yMPzPS8hbJ8VGQLjvwt79R7owlfCf8EY9ZKODMpBolquRGTAA9bOzJ3an7H983rjfGk4AM+
	ppNswxC6Vw5P3lmF0VA7OJZvv0Rf5cpCymkuucAZVfca7A2cA1DReDgjveGa/YTjIULFt8Q+S4c
	L9vTM41/3rHKXwlu3JhBuFWN4+nuqqps3icH5rPOJ+BfbDg8in9cXKR60aeM1gevvWE34OrXlxb
	VHaVHl5IzcunO25lDWvHcT/4upmIT43ZcQ4E4jGLH0wBhjQZ7dolonFQLKHt05Io1EH/xDFcsWo
	m7yTsPedVVgwMF8ZXzGUuz0THc3+FiVsYrSWQ8wk19OGxsDXFhL8/tKK8jTKRLl4QftRK1WDt7J
	NIEa2p8KSXnSV1mVYMCP4=
X-Received: by 2002:a17:903:3783:b0:2ed:379:1596 with SMTP id d9443c01a7336-2f03f1cf700mr292375245ad.19.1795819464384;
        Fri, 27 Nov 2026 14:44:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dbe86sm126792545ad.32.2026.11.27.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:44:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [GIT PULL] BPF fixes for 7.4-rc5
Date: Fri, 27 Nov 2026 22:44:22 +0000
Message-ID: <20261127224422.3451200-1-alexei.starovoitov@gmail.com>
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

Hi Linus,

The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 02d3452bdd80cf645694110128db2ed67da96490:

  bpf: Set the run context for async callbacks (2026-11-27 06:12:26 +0000)

----------------------------------------------------------------
Small fixes for various bugs all over bpf. The main themes:
. fix verifier bugs that let unsafe progs load
. require CAP_PERFMON in places where CAP_BPF alone leaked kernel addresses
. fix x86 JIT crash with FineIBT, split locks from arena atomics
  and unreliable stack traces
. fix arm64 JIT crash in bpf_throw() with shadow call stack
. fix leaks of uninitialized memory in skb, XDP, sk_msg and sockaddr helpers
. add missing NULL checks and speculation barriers

- Various fixes (Alexei Starovoitov):
    - Require CAP_PERFMON where CAP_BPF was enough to see kernel
      addresses or to touch other tasks: tracing helpers in syscall
      progs, arena and task work kfuncs, streams, kernel variables,
      dumps of xlated insns, etc.
    - Zero bpf_list_head in copies of map values
    - Check that an extension prog fits the hook of its target
    - Compare the attach type and the properties of a hook at tail
      calls, reserve cookie and ip in the trampoline for them
    - Look at the type of a prog next to expected_attach_type
    - Check the attach type when a cgroup link gets another prog
    - Check that a prog and a struct_ops map are for the same struct
    - Fix the checks of R0 and bpf_get_retval() in struct_ops progs
    - Don't trust pointers in flexible arrays and the neighbour of
      tp_btf/neigh_create
    - Check for NULL in helpers that take a kernel pointer
    - Don't allow bpf_d_path() by an id of another BTF
    - Emit nospec after calls and atomics that write to the stack,
      undo insn aux changes of a failed speculative path
    - Treat NOT_INIT as a pointer in __is_pointer_value()
    - Let the bpf_fastcall boundary cover the longest pattern
    - Give the error of bpf_res_spin_lock() a 32-bit range
    - Use get_unaligned() in bpf_map_direct_read()
    - Set the run context for async callbacks, fix NULL dereference
      in XDP redirect from them
    - Fix bpf_throw() with tracers, KASAN and arm64 shadow call stack,
      add the symbol of a prog before its id, etc.
    - Fix bpf_kfree_skb(), bpf_lock and the free of a list head or
      rb root with irqs off
    - Bound the time that dumps of the stack take
    - Fix arena: refuse mmap() of a part of it, flush TLB when a page
      replaces the scratch page, enforce alignment of atomics on x86
    - Don't use the paranoid ITS thunk in x86 JIT, fix the range of
      BPF code that has a frame pointer
    - Refuse metadata maps of signed progs that can be mapped writable
    - Fix reads past an enum in prints of BTF data
    - Keep the names in front of a number in bpffs delegate options
    - Don't expose uninitialized bytes in bpf_msg_push_data(), loads
      from the network header and cgroup sockaddr hooks
    - Fix dynptr slices behind the end of an XDP packet
    - Take a neighbour of the L3 master in bpf_redirect_neigh()
    - Keep the MAC header in bpf_skb_change_tail()
    - Keep the parser and sk_data_ready in sync in sockmap, hold the
      psock of the work in sk_psock_backlog()
    - Fix struct_ops members 59-61 and optional struct_ops maps in
      libbpf

- Various fixes (Sechang Lim):
    - Reject kernel threads in bpf_task_work_schedule()
    - Clear the redirect target after the sockmap stream parser runs

- Check program type on the migration path of sock_reuseport
  (Shihuang Liu)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (57):
      bpf: Let the bpf_fastcall boundary cover the longest pattern
      bpf: net_sched: Defer bpf_kfree_skb() to irq_work with irqs off
      bpf: Save irq flags on the stack when freeing a list head or rb root
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
      bpf: Refuse metadata maps of signed programs that can be mapped writable
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
      bpf: Clear family and port of a short address for cgroup sockaddr hooks
      bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
      bpf: Keep the MAC header in bpf_skb_change_tail()
      bpf, sockmap: Keep the parser and sk_data_ready in sync
      bpf, sockmap: Hold the psock of the work in sk_psock_backlog()
      libbpf: Fix struct_ops members 59-61 and optional struct_ops maps
      bpf: Check the type of R0 at the exit of a struct_ops program
      Merge branch 'bpf-fixes-for-hooks-tail-calls-cap_bpf-jits-and-sockmap'
      bpf: Undo insn aux changes of a failed speculative path
      bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
      bpf: Use get_unaligned() in bpf_map_direct_read()
      bpf: Emit nospec after calls and atomics that write to the stack
      Merge branch 'bpf-fixes-for-speculation-barriers-and-constant-reads'
      bpf: Set the run context for async callbacks

Sechang Lim (2):
      bpf: Reject kernel threads in bpf_task_work_schedule()
      bpf, sockmap: Clear the redirect target after the stream parser runs

Shihuang Liu (1):
      net: sock_reuseport: Check program type on the migration path

 Documentation/bpf/kfuncs.rst                       |   3 +-
 Documentation/bpf/signing.rst                      |   3 +-
 arch/arm64/net/bpf_jit_comp.c                      |   7 ++
 arch/x86/net/bpf_jit_comp.c                        |  53 ++++++++--
 include/linux/bpf.h                                |  44 ++++++--
 include/linux/btf.h                                |   1 +
 include/linux/filter.h                             |  15 ++-
 include/uapi/linux/bpf.h                           |   3 +-
 kernel/bpf/arena.c                                 |  40 ++++---
 kernel/bpf/bpf_struct_ops.c                        |  20 +++-
 kernel/bpf/btf.c                                   |  52 +++++++--
 kernel/bpf/cgroup.c                                |  33 +++++-
 kernel/bpf/core.c                                  |  50 +++++++--
 kernel/bpf/fixups.c                                |  18 +++-
 kernel/bpf/helpers.c                               |  86 ++++++++-------
 kernel/bpf/inode.c                                 |  10 +-
 kernel/bpf/stackmap.c                              |   2 +-
 kernel/bpf/stream.c                                |  25 ++++-
 kernel/bpf/syscall.c                               |  42 ++++++--
 kernel/bpf/verifier.c                              | 117 ++++++++++++++++-----
 kernel/sched/ext/internal.h                        |   5 +-
 kernel/trace/bpf_trace.c                           |   8 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   2 +-
 net/core/bpf_sk_storage.c                          |   4 +
 net/core/filter.c                                  |  46 +++++---
 net/core/skmsg.c                                   |  16 ++-
 net/core/sock_map.c                                |   3 +-
 net/core/sock_reuseport.c                          |  16 ++-
 net/ipv4/bpf_tcp_ops.c                             |   2 +-
 net/sched/bpf_qdisc.c                              |  27 +++++
 tools/include/uapi/linux/bpf.h                     |   3 +-
 tools/lib/bpf/libbpf.c                             |  19 ++--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   6 +-
 33 files changed, 606 insertions(+), 175 deletions(-)
