Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662444;
	b=iW6OK0gzy4DfJSKCi7LfgsqTsMrVqpvVs/Z77Rte5n8pp27sOZaVj+hQHGHQxA0sluzl
	 UdfJhFdA7wPIND0Es2T4PkmStppDjjt4HJPNDTxouv/r61RF7IAQytZSfXvclbNOvjeSc
	 t2ivfdN2AiQ3PRIvV9SsMmoCRxCpS5y+4Qc8rcyRql3db1ro/xCQcW7s/HOj8rGzjHra9
	 mD+cWCSYSNkfw/wo2ScKl/jlGinXbWJgdnUeAX/y9kYeiYHTnE2J9uVRe1sStrqkmrf+0
	 iK1k06qqJQaaN8QPzS3EfiAUQAxChuDGnLv0yY6+E3owpvJ23oRtWFSWWJo+V+FyRCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IrVlfzEuNURm5gFszSh9Q3w7hC13THmT2x+dNuZcnrk=;
	b=Fz2pOpOthEVmD3b3AfP8Gqi3bhMXW+j/OtqUspdecoX0RN9lugIjXRViOPb2Dpgf6y99
	 F8TUfsHgpG5gCygzg3ebUK95kFzNTtHM/qd4M+u7iGhJRKqakGXxuZdsAmrFj9wnQcSB6
	 05416VL+ktCaDTBsGfGeniLVc/2DcdOMwu04XbOhnWxBi5zYrakGC4iUZjvi/ATFVAFHp
	 nCRnlhv+pIS3qT/37ditFKhJMvOuEngWnertmayYZ1gsd4yFPFrEdL/i8fTikwwEoWKdT
	 tSJcQhato40iH+mep4PruizeV53Tbi6bjVnVcLEjztefQ860TzuasS3Nq9UNVnGJOYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JxfP+7T3;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A5606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 23:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797A5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JxfP+7T3
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e95bd1c14cso32542275ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793662443; x=1794267243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrVlfzEuNURm5gFszSh9Q3w7hC13THmT2x+dNuZcnrk=;
        b=JxfP+7T3Irp8SMR+f8VUJ8U4jO1ecEtulNf2/Ew4HyMhxQlsZ+aFQUg4JQ+iuRbyVH
         BZtmEXEy6StFG1gSvW1CWZ5o1ovPXa2Qh8MvOGZ5kE3TcRbvpiWqj/tVjkGxaK5QPFku
         EVXhMK69T+wiiOqzP39L/+vu0yYNdQsQ3qo02cW9V3H90h0BMqusY+wqD/lFmzQrZ5DX
         WPv6RNZoxQg9mdmYJZloAVFV49W8MDt/0uyAvOcSMjUxi8DeG6YwwHu/Fk7pjm+jS98G
         uKirIzjryQnZl4K+SA7mSrdgHiX/fhlb+T3FlzimRpoij6JSFi0ZX+ILhJFGVqb5GHMt
         uZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662443; x=1794267243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrVlfzEuNURm5gFszSh9Q3w7hC13THmT2x+dNuZcnrk=;
        b=b+heD4gnLghoM4BxiwcRNUqWykWSwI9ocViQjFYLCA05ZWnt8v4fIskcjRbUHBSEkO
         VGmQRXj0REYQK2dPDFy3nUTboq0G45AwUgbKKDCpiignCDeh1TVriSWOmvLyd/zhIgDV
         0Hp6ULq4jnrZZAYxW5MFOe0n/3lbjtX5Qxn0QBwdTs43U4EPbhbs5gnwjAOvpajLU085
         DGH1PhCIZKhtMJ4k9PpD+NalDsAPyy9G/wNcC+eD9r7POUg+6WKnl+GJ0YDwwxOXtTjy
         BAnJomdTUebPa7mXzAAPqaYh+yw/PLVtITiZGJR+JhDKUnel8zT7jqENC7/y3WeC7Hd2
         3XHA==
X-Gm-Message-State: APuU4Z9ZVqtcrezTj5LkDtv/bvc3hXgPF5A6lmU3kHoffs3BLE0tpbgW
	45bRPN1bl81zIdgJirGWt5xn5ip/7UtebhyjkGVUKAIBVxVeueqvgVt3U8ZoKQ==
X-Gm-Gg: AYBFou0bx4v6H561eGsbPeSOk9NvDBi6Fza2fzevK8nfHZcKYXyTyVxZwblhZgPD/xy
	o9WbVxBXI+foD1ndZKllTBsuzSm3b8u/MK9tBnCRn8GS4wqsrB5h6BwK3cXnxihH0Kcrkovmbu5
	FVKttoF8pyH9ALM/WcwZaIAztzwVxkO9VVDGCPIZ20VfpYN+9GBJ707Z04BxTlWst8c8V0NJDtq
	llAkPNYqQI991+H72IPS2bGdq9O15j0GhViW1Znwi/+IhK3wcEsh8/1Z2de6PN4Vspz8dhG+O/L
	Hp3pkyBCNc+X2qS2oIn25gdsL3ceVMIKfhryaXUPNFvLI/mCAcfkW42lfKhAw0PxMMF7NbMV+Hh
	pDED17bwDpQUfbxORgC6IMt4aUKECImsg5irmFSNHUsRLuMc6yqiaaA0ktdgVy7V+4yWh7T5bu9
	MPIHbA5mfrvEZB19Udk+Cjr/TbFSKw8igneOZ1TvT7YifXUT6pgwyxBOyFcqcgNuRl/Cc4qvh8T
	5Hi5MgesFts5P/33XacNf/xAVee8eYrlUkAyhATVNEd8EjDk595kNvE4mcM5+hQHe6Uh7jnCA73
	imWQQyUGTzpRjjeEe7lHIaPX5kJ1BhH2kCMBXTPNqS5/sJkfVas/DccjpUjtgwW4Pa4tFxvNgsg
	vdESiqdbGU7SCkKbFJCeQuB+19DJm1a6XYtqk1Y0wEW3+kUrpNRUi/m52KeWQZDWaVeocWhErt1
	GFJJBSkvs5piPDeIad54M=
X-Received: by 2002:a17:903:1c1:b0:2e9:6333:fbb8 with SMTP id d9443c01a7336-2eb364936fcmr112515725ad.12.1793662442625;
        Mon, 02 Nov 2026 15:34:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc4bsm34153485ad.12.2026.11.02.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:34:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [GIT PULL] BPF fixes for 7.4-rc2
Date: Mon,  2 Nov 2026 23:34:00 +0000
Message-ID: <20261102233400.1941543-1-alexei.starovoitov@gmail.com>
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

The following changes since commit d89e1d186ec9271bf78e62771779e9fc03bf0fc3:

  Merge tag 'fscrypt-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/linux (2026-10-29 14:00:23 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 9abe2c42ecab6c86b54838d2d645ca2e10204606:

  libbpf: Fix use-after-free in btf__add_type (2026-11-02 22:47:44 +0000)

----------------------------------------------------------------
Fix various bugs in bpf core and bpf-lwt.
Looks like the speed of us fixing bugs is higher than the number of new bugs found.
Not out of the woods yet.
sockmap fixes will come later.

- Various fixes (Alexei Starovoitov):
    - Use one may_goto time slice per prog invocation instead of one
      per stack frame to fix a soft lockup in loops that nest across
      calls
    - Fix use-after-free in btf__add_type() in libbpf
    - Invalidate a dynptr slice when its stack buffer is written or
      when the frame of the buffer returns
    - Fix the tracking of pointers to the stack in SCEV
    - Keep the valid bytes of a packet pointer in SCEV
    - Fix bpf_throw() in a prog with a private stack in x86 JIT
    - Compare the arguments of an extension prog with those of its
      target
    - Don't accept memory of the prog for struct arguments of
      KF_ACQUIRE kfuncs and for arguments of an empty struct type
    - Fix mmap() of an arena: refuse address 0 and a length above
      max_entries pages, etc.
    - Don't let bpf_skb_adjust_room() raise gso_size to GSO_BY_FRAGS
    - Fix lwt progs: reset skb->cb and don't leave a stale MAC header
      after a prog pushes an IP header, require BPF_LWT_REROUTE when
      an lwt_in prog changes the protocol, don't call into IPv6 when
      it is disabled, don't look for the SRH again in the End.BPF
      helpers, and set a dst for test runs of lwt_in progs

- Fix bpf_dynptr_copy() for overlapping ranges in one packet
  (Ayushman Rout)

- Various fixes (Chris Mason):
    - Reject memory of the prog for kfunc projection type arguments
    - Require prog fd or capability for cgroup prog detach
    - Keep the skb network offset signed in cgroup skb progs
    - Reject non-IPv6 packets in BPF_LWT_ENCAP_SEG6
    - Limit the SRH length and move the MAC header in
      bpf_lwt_seg6_adjust_srh()
    - Move the transport header together with the headers that
      bpf_skb_adjust_room() and bpf_lwt_seg6_adjust_srh() move, and
      use the inner transport header after a decap
    - Check the offset in bpf_skb_generic_{push,pop}()

- Mark jmp mode of ftrace direct trampolines on x86 by clearing bit 63
  of the address instead of setting bit 0, since an ftrace callback
  can start at an odd address (Daniel Borkmann)

- Fix psock update-side data races on sk->sk_prot and progs in sockmap
  (Jakub Sitnicki)

- Fix skb_pull() BUG in __bpf_redirect_neigh(): make sure that the MAC
  and IP headers are there and are linear (Jamal Hadi Salim)

- Fix jited line info that is off by the CFI preamble on x86-64, arm64
  and riscv64 (Jose Fernandez)

- Clamp the trace length in __bpf_get_stack() to fix a write after the
  end of the buffer (Josef Bacik)

- Drop percpu_counter from the htab element count, since its lock can
  deadlock with NMI and tracing progs that update the same map
  (Puranjay Mohan)

- Propagate scalar precision through stack arguments (Xu Yunxiang)

- Fix callback recursion selftest with llvm24 (Yonghong Song)

- Free the skb when bpf_xmit() fails to expand the headroom
  (Yuqiang Sun)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (48):
      Merge branch 'bpf-fix-overlapping-copies-in-bpf_dynptr_copy'
      bpf: Keep the valid bytes of a packet pointer in scalar evolution
      selftests/bpf: Test the valid bytes of a packet pointer in a counted loop
      Merge branch 'bpf-keep-the-valid-bytes-of-a-packet-pointer-in-scalar-evolution'
      bpf, x86: Fix bpf_throw() in a prog with a private stack
      selftests/bpf: Test bpf_throw() in a prog with a private stack
      Merge branch 'bpf-x86-fix-bpf_throw-in-a-prog-with-a-private-stack'
      bpf: Clamp the trace length before the skip test in stackid_init()
      bpf: Refuse to map an arena at address 0
      bpf: Don't let bpf_arena_free_pages() see a half-set user range
      bpf: Refuse an arena mmap() longer than max_entries pages
      bpf: Remove the WARN from arena_get_unmapped_area()
      selftests/bpf: Test the length and the address of an arena mmap()
      bpf: Don't turn struct arguments of KF_ACQUIRE kfuncs into memory
      bpf: Don't turn kfunc arguments of an empty struct type into memory
      bpf: Compare the arguments of an extension with those of its target
      selftests/bpf: Test the arguments of an extension prog
      bpf: Don't let bpf_skb_adjust_room() raise gso_size to GSO_BY_FRAGS
      bpf: Set a dst for test runs of lwt_in progs
      bpf: Don't look for the SRH again in the End.BPF helpers
      bpf: Don't leave a stale MAC header in bpf_lwt_push_ip_encap()
      bpf: Reset skb->cb after an lwt prog pushes an IP header
      bpf: Require BPF_LWT_REROUTE when an lwt_in prog changes the protocol
      bpf: Don't let lwt_in progs call into IPv6 when it is disabled
      Merge branch 'bpf-fixes-for-the-verifier-arena-skb-and-lwt-helpers'
      bpf: Don't move a MAP_FIXED address in arena_get_unmapped_area()
      selftests/bpf: Run arena_mmap serially and test MAP_FIXED addresses
      Merge branch 'bpf-follow-ups-for-the-arena-mmap-fixes'
      bpf: Fix the join of fp+0 with a value that is not a pointer to stack
      selftests/bpf: Test the join of fp+0 with a value that is not a pointer to stack
      bpf: Don't trust pointers spilled in slots that a callee can write
      selftests/bpf: Test a callee that overwrites a spilled pointer of its caller
      Merge branch 'bpf-fix-two-holes-in-the-analysis-of-stack-arguments'
      bpf: Invalidate a dynptr slice when its stack buffer is written
      selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()
      Merge branch 'bpf-fix-the-stack-buffer-that-bpf_dynptr_slice_rdwr-returns'
      bpf: Emit timed may_goto for JITed progs only
      selftests/bpf: Don't cast a pointer to .bss in arena_htab_asm
      selftests/bpf: Give the first loop of cond_break5 an end
      selftests/bpf: End the loop of parallel_test_bitmap after 50 ms
      s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
      bpf: Pass a pointer to arch_bpf_timed_may_goto()
      bpf: One may_goto time slice per prog invocation
      bpf: End bpf_loop() when the time of may_goto is up
      selftests/bpf: Test one may_goto time slice per prog invocation
      Merge branch 'bpf-one-may_goto-time-slice-per-prog-invocation'
      Merge branch 'bpf-fix-stack-argument-precision-propagation'
      libbpf: Fix use-after-free in btf__add_type

Ayushman Rout (2):
      bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
      selftests/bpf: Test overlapping dynptr copies on xdp frags

Chris Mason (9):
      bpf: Reject memory for kfunc projection type args
      bpf: Require prog fd or capability for cgroup detach
      bpf, cgroup: Keep the skb network offset signed
      bpf: Reject non-IPv6 packets in BPF_LWT_ENCAP_SEG6
      bpf: Limit the SRH length in bpf_lwt_seg6_adjust_srh()
      bpf: Move the MAC header in bpf_lwt_seg6_adjust_srh()
      bpf: Move the transport header with the moved headers
      bpf: Use the inner transport header after a decap
      bpf: Check the offset in bpf_skb_generic_{push,pop}()

Daniel Borkmann (2):
      x86/ftrace: Mark jmp mode by clearing bit 63 of trampoline address
      selftests/bpf: Test kprobe and fentry/fexit programs on one function

Jakub Sitnicki (1):
      bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs

Jamal Hadi Salim (1):
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

Jose Fernandez (Anthropic) (1):
      bpf: Fix jited line info off by the CFI preamble

Josef Bacik (1):
      bpf: Clamp the trace length in __bpf_get_stack() again

Puranjay Mohan (1):
      bpf: Drop percpu_counter from the htab element count

Xu Yunxiang (2):
      bpf: Propagate scalar precision through stack arguments
      selftests/bpf: Exercise stack argument precision on state reuse

Yonghong Song (1):
      selftests/bpf: Fix callback recursion test with noipa global func

Yuqiang Sun (1):
      bpf: lwt: Free the skb when bpf_xmit() fails to expand the headroom

 Documentation/bpf/kfuncs.rst                       |   7 +
 arch/arm64/net/bpf_timed_may_goto.S                |  12 +-
 arch/loongarch/net/bpf_timed_may_goto.S            |  10 +-
 arch/powerpc/net/bpf_timed_may_goto.S              |   9 +-
 arch/riscv/net/bpf_timed_may_goto.S                |  10 +-
 arch/s390/net/bpf_jit_comp.c                       |  24 +-
 arch/s390/net/bpf_timed_may_goto.S                 |   8 +-
 arch/x86/kernel/ftrace_64.S                        |   6 +-
 arch/x86/net/bpf_jit_comp.c                        |  19 +-
 arch/x86/net/bpf_timed_may_goto.S                  |   5 +-
 include/linux/bpf.h                                |  14 +
 include/linux/bpf_verifier.h                       |  30 +-
 include/linux/btf.h                                |   1 +
 include/linux/filter.h                             |   8 +
 include/linux/ftrace.h                             |   8 +-
 kernel/bpf/arena.c                                 |  29 +-
 kernel/bpf/backtrack.c                             |  11 +
 kernel/bpf/btf.c                                   |  19 +-
 kernel/bpf/cgroup.c                                |  26 +-
 kernel/bpf/core.c                                  |  41 +-
 kernel/bpf/diagnostics.c                           |   6 +-
 kernel/bpf/diagnostics.h                           |   1 +
 kernel/bpf/fixups.c                                | 149 +++-
 kernel/bpf/hashtab.c                               |  64 +-
 kernel/bpf/helpers.c                               |  45 +-
 kernel/bpf/liveness.c                              |  83 +-
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/scev.c                                  |  13 +-
 kernel/bpf/stackmap.c                              |  33 +-
 kernel/bpf/states.c                                |  14 +
 kernel/bpf/verifier.c                              | 151 +++-
 net/bpf/test_run.c                                 |   3 +-
 net/core/filter.c                                  | 154 +++-
 net/core/lwt_bpf.c                                 |  57 +-
 net/core/sock_map.c                                |  22 +-
 tools/lib/bpf/btf.c                                |  14 +
 .../libarena/selftests/test_parallel_bitmap.bpf.c  |  10 +
 .../testing/selftests/bpf/prog_tests/arena_mmap.c  |  53 ++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   4 +
 .../bpf/prog_tests/fentry_kprobe_shared.c          |  65 ++
 .../selftests/bpf/prog_tests/freplace_args.c       |  92 +++
 .../selftests/bpf/prog_tests/may_goto_far.c        |  24 +-
 .../selftests/bpf/prog_tests/timed_may_goto.c      | 195 +++++
 tools/testing/selftests/bpf/progs/arena_htab.c     |   2 -
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 264 ++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 124 +++
 .../selftests/bpf/progs/fentry_kprobe_shared.c     |  49 ++
 tools/testing/selftests/bpf/progs/freplace_args.c  |  53 ++
 .../selftests/bpf/progs/freplace_args_tgt.c        |  70 ++
 tools/testing/selftests/bpf/progs/timed_may_goto.c | 898 +++++++++++++++++++++
 .../selftests/bpf/progs/timed_may_goto_ext.c       |  23 +
 .../selftests/bpf/progs/timed_may_goto_user.c      | 311 +++++++
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  72 +-
 tools/testing/selftests/bpf/progs/verifier_callx.c |  20 +
 .../selftests/bpf/progs/verifier_global_subprogs.c |   7 +-
 .../bpf/progs/verifier_iterating_callbacks.c       |   6 +-
 .../selftests/bpf/progs/verifier_live_stack.c      | 195 ++++-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |  32 +-
 .../selftests/bpf/progs/verifier_private_stack.c   |  99 +++
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 182 +++++
 .../selftests/bpf/progs/verifier_stack_arg.c       | 115 +++
 61 files changed, 3749 insertions(+), 324 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mmap.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_user.c
