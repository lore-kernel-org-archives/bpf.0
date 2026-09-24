Received: from mail-pj2-f23.google.com (mail-pj2-f23.google.com [74.125.227.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF783016F5
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261726; cv=none; b=iUWHU6tK64NT1r4H1drJO9HiOvmILI+6fNQwodtROfPxm+++aBPaPX9A4Ds2bO3eCjzYbg7OcqWXtTEP13hnD3/MZiHH1GVsCamPPp2HbtTYT0TY3VR8yaibcOKX/rP5TMqI1nWyuI5aL0JJvaaZJIl4GPlJIT+VU6up/1ZSk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261726; c=relaxed/simple;
	bh=Te3ssMToqkEfSsTopPbUeEd8m2C31xjvL1qbl17EEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKjEQ40+job2mVc//NQwJW50/9bf6QWGFwuCr8G9X+1Xv3u6D3hbBem/oNsexCZuAC511U45sdYiyBcCEmTNyhD1nperMTuHrbKZOPkHp8efmFsumfJxwseKJdGv/jeQ0QyvLwwlnXGc/kThW6U7VJsr+mmUsaohDhCQ/JoIffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekS/1O5s; arc=none smtp.client-ip=74.125.227.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekS/1O5s"
Received: by mail-pj2-f23.google.com with SMTP id d9443c01a7336-2d747f066d8so7046455ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261725; x=1790866525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrOrBZfkvKDJBMu4fEPZoEydHpqkMi+t/TlB7J2wP+U=;
        b=ekS/1O5see6o5pPHsmo/tHdmKs0WS1uMH5X/fPAyDhSsCs5mPd24y9W/vzPyOFR83W
         RSgKHKFGp81y/1Q2BX+4acP1CdR0TZFKdcunc59kwcvI0Qop1r1MzWSJjuZTotsmbZLd
         9tiw/z3btUJ7/HnWi+0A8QgyhQig//rRJ9OAg9BRYJg0MsrGb5XIiddcK09/uJ4ps/Mz
         6Fl7VOB5HIqKf7nzrT2xccUvmVDQcJXhmqCNG7hfPUx9eEeqjK5iZnHuDP5oIyMZ131v
         NA0hLxzWXucI0xoDn5qYKOLpmLdSRotxowojBSnkYmrChWqLtw5jcuIXz8VCKtHCdHv9
         bGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261725; x=1790866525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrOrBZfkvKDJBMu4fEPZoEydHpqkMi+t/TlB7J2wP+U=;
        b=dujIt16hg+5TtvpvrB7MHGYLDTybGjA79i0NOiNFfJxFyMv4Pm7vvPbAe6zLGIyxYI
         POyiLVcWJw0VbxMe2A96sVoiigIZSjoGbVvQsM4RYUoZhFi97Oacmz2VKZ2W8XrfVQOH
         TtAc0GRQhdnPuLA/5d8GD3839ppBuxLFH3+SkV95aL8Ra2MteQlipl+qqcvmfoeMReIj
         AsOBz+ngeTv0zCxYoVrY+pAV2+/y/6Qoej6uvnZ7KyrYbsTnptbjNbE9eo/Slzu8UMXd
         Kl4y3h6fCVv2C8wkIe5SE9VbDT3o5UhurVNaoi5lKEtnkqrpK28BcWT9LmaotQDlCAG0
         9VEw==
X-Gm-Message-State: AFuF++l+RULv8yLykZbADfkpcqnrWXI0UeRHpJxdCX1ZEdOz3sSPjH9i
	j/oaAAw/3EQeMDWtCSzLrfgsYUsDgS6uzm++tDF/vYGAbX06XzOW3ksF
X-Gm-Gg: AYBFou11oOH3JUto3fhNznZHTgFfSSpydNNVdvXvAHTZ6nPF7UFHpLju1EmFhCKTifD
	NRCV9KXHvC590MPILhvoh5/PfKV2A+DW03/MOFeQ3E23skJszDQ+JeCkA/Pc7AD81oiAUBRLsPD
	SwKqjY/kYF3r4C3NbCfSvR5WnpczJrJwvxeaexoW8MrN/+E0LP1fwH+hVD1W9TQb4wIUFIFQ5lx
	gibp+/HlImKRdBLSDm4Fo2ZC1aDfhDiTXf+qx2y7rpcFTaY1nrZ9WgshqbhjsQSetRqM9ajt2+6
	96xiRfx6G2ok1kBhGT65JaGFfE5kArzxd51o/Lej4Y7XheqCBQFb0bLuGAkD0hSx3YRoZYS/tZ2
	MKF8ilF0FVLrNBaANTTPdjOk0vatuYZQ17ZY1mPcK1Ixoe7To2rqP3e972gXLaH2Jwz37408Qa9
	s+3JFZ5Nd0QP3SX2uxFw26Wb1jTMYad88O2hbv3G4s8DlJih/IwAwHfGhXSMx00m7KizKoN5G+x
	Ap8Lb6LCeyQiN0dGaDCbw+76l7Lfhid8tysJod5tCasjDaxecEAAJeSYqOlQnwtSksLKq72zSO0
	RUgiJ+BeeoU8cVo7JJrpvGEdqkOpPbPTrcR5SV8XipY=
X-Received: by 2002:a17:903:2acb:b0:2df:8cf5:1fdf with SMTP id d9443c01a7336-2df8cf521b9mr3278955ad.13.1790261724245;
        Thu, 24 Sep 2026 07:55:24 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c2f3bsm28775745ad.39.2026.09.24.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:55:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [GIT PULL] BPF fixes for 7.3-rc5
Date: Thu, 24 Sep 2026 14:55:21 +0000
Message-ID: <20260924145521.3616829-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 1b1dca56828f33bc5e39b930ebed062e77fbe3b2:

  Merge branch 'bpf-fix-per-cpu-initialization-of-a-bpf_f_cpu-created-hash-element' (2026-09-24 14:25:01 +0000)

----------------------------------------------------------------
- Fix bpf_skb_change_tail() to drop the checksum offload instead of
  rejecting the trim of CHECKSUM_PARTIAL skbs (Daniel Borkmann)

- Add KF_PERFMON kfunc flag and require CAP_PERFMON for kfuncs that
  read arbitrary memory and for untrusted read-only memory reads
  (Daniel Borkmann)

- Clear scalar delta on narrowing stack spill (Daniel Borkmann)

- Set up the frame pointer for the exception callback in arm64 JIT,
  and zero-fill other CPUs when BPF_F_CPU update creates a per-cpu
  hash element (Donggeun Yoo)

- Various fixes (Emil Tsalapatis):
    - Fix bounds check underflow for skb-backed dynptrs
    - Fix rx_queue_mapping context access code generation in bpf_sock
    - Reject packet pointer arguments to subprogs that may mutate
      the packet
    - Reject ALU instructions that see arena and non-arena operands
      on different code paths

- Fix copied_seq double-counting on sockmap self-redirect
  (Geliang Tang)

- Fix divide-by-zero in btf_struct_walk() on a flexible array of
  zero-sized elements, fix out-of-bounds read of rtt_min in sock_ops
  (Jiayuan Chen)

- Fix bpf_sock_destroy() out-of-bounds read of sk_protocol on
  TIME_WAIT and request socks, and sleeping under RCU when destroying
  a listener with pending children (Jiayuan Chen)

- Fix JEQ/JNE with immediate operand in MIPS32 JIT and missing zero
  extension of BSWAP 16/32 in MIPS64 JIT (Johan Almbladh)

- Avoid soft lockup in htab lookup[_and_delete] batch operations on
  large maps (Jose Fernandez)

- Various fixes (Kumar Kartikeya Dwivedi):
    - Verify global subprogs in each sleepability context they are
      called from
    - Make post-verification instruction rewrites killable
    - Preserve packet pointer displacement in regsafe()
    - Apply CO-RE relocations before subprogram validation, restrict
      CO-RE poisoning to relocatable instructions, and reject
      truncated ldimm64 CO-RE relocations in libbpf
    - Assign lock identity to callback map values
    - Compare stack frames in regs_exact()
    - Bound ownership depth through local kptrs and graph roots

- Fix u32 overflow in map batch operations when the map size exceeds
  4GB (Masoud Aghasi)

- Fix UAF in bpf memalloc due to concurrent consumption of ttrace
  lists in alloc_bulk() (Pu Lehui)

- Allow gotox as the terminal instruction of a program or a subprogram
  (Siddharth Chintamaneni)

- Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL, skip unsettled
  links in link iterator, and reject dev-bound-only programs on other
  devices (Weiming Shi)

- Reject non-negative stack offsets in stack_slot_obj_get_spi()
  (Xu Yunxiang)

- Check params size before reading reserved fields in
  bpf_crypto_ctx_create() (Yuqi Xu)

- Reject max_entries > INT_MAX in sock_map_alloc() (Zhao Gongyi)

- Use a 32-bit compare in xsk_map_gen_lookup() (Zhiling Zou)

- Use kvfree() in xdp_test_run_teardown() (Zhixing Chen)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (5):
      Merge branch 'bpf-tcp-fix-bpf_sock_destroy-on-time_wait-and-listener-socks'
      Merge branch 'bpf-arm64-fix-the-exception-callback-s-frame-pointer'
      Merge branch 'compare-stack-frames-in-exact-register-states'
      Merge branch 'fix-acyclic-ownership-checks'
      Merge branch 'bpf-fix-per-cpu-initialization-of-a-bpf_f_cpu-created-hash-element'

Andrii Nakryiko (1):
      Merge branch 'bpf-reject-non-negative-stack-object-offsets'

Daniel Borkmann (7):
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs
      selftests/bpf: Add test for bpf_skb_change_tail on csum partial skbs
      bpf: Add KF_PERFMON kfunc flag
      bpf: Require CAP_PERFMON for kfuncs reading memory
      bpf: Require CAP_PERFMON for untrusted read-only memory reads
      selftests/bpf: Add tests for the KF_PERFMON gates
      bpf: Clear scalar delta on narrowing stack spill

Donggeun Yoo (4):
      bpf, arm64: set up the frame pointer for the exception callback
      selftests/bpf: cover the exception callback using its own BPF stack
      bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
      selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element

Eduard Zingerman (1):
      Merge branch 'fix-global-subprog-verification-context'

Emil Tsalapatis (8):
      bpf: Fix bounds check for skb-backed dynptrs
      selftests/bpf: Test dynptr slices past end of skb
      bpf: Fix bpf_sock context code generation
      selftests/bpf: Add selftests for rx_queue_mapping context access
      bpf: Reject pkt arguments in mutating subprogs
      selftests/bpf: Test rejection of pkt args to mutating subprogs
      bpf: Prevent variable arena/non-arena register contents
      selftests/bpf: Test for mixed arena/nonarena code paths

Geliang Tang (1):
      bpf, sockmap: Fix self-redirect copied_seq double-counting

Jiayuan Chen (6):
      bpf: Fix divide-by-zero in btf_struct_walk()
      selftests/bpf: Test BTF walk into a flexible array of zero-sized elements
      bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
      tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
      selftests/bpf: Test bpf_sock_destroy() on TIME_WAIT and listener socks
      bpf: Fix out-of-bounds read of rtt_min in sock_ops

Johan Almbladh (2):
      bpf: Fix immediate JMP JEQ/JNE on MIPS32
      bpf: Fix BSWAP 32 and 16 on MIPS64

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Kumar Kartikeya Dwivedi (16):
      bpf: Verify global subprogs in each sleepability context
      selftests/bpf: Test global subprog callback contexts
      bpf: Make post-verification instruction rewrites killable
      bpf: Preserve packet pointer class displacement in regsafe()
      selftests/bpf: Test packet pointer class displacement pruning
      bpf: Apply CO-RE relocations before subprogram validation
      selftests/bpf: Test early in-kernel CO-RE relocation
      bpf: Restrict CO-RE poisoning to relocatable instructions
      selftests/bpf: Test CO-RE instruction poisoning restrictions
      bpf: Assign lock identity to callback map values
      selftests/bpf: Check callback map value lock identity
      libbpf: Reject truncated ldimm64 CO-RE relocations
      bpf: Compare stack frames in regs_exact()
      selftests/bpf: Cover frame changes in bounded loops
      bpf: Bound ownership depth through local kptrs and graph roots
      selftests/bpf: Check local object ownership depth

Masoud Aghasi (1):
      bpf: Fix u32 overflow issue in map batch operations

Pu Lehui (1):
      bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk

Siddharth Chintamaneni (2):
      bpf: Allow terminal gotox instructions
      selftests/bpf: Test terminal gotox instructions

Weiming Shi (3):
      bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      bpf: Skip unsettled links in link iterator
      bpf: Reject dev-bound-only programs on other devices

Xu Yunxiang (2):
      bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
      selftests/bpf: Reject iterator destruction through fp+0

Yuqi Xu (1):
      bpf: Check params size before reading reserved fields

Zhao Gongyi (1):
      bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Zhiling Zou (1):
      xsk: Use a 32-bit compare in xsk_map_gen_lookup

Zhixing Chen (1):
      bpf: Use kvfree() in xdp_test_run_teardown()

 Documentation/bpf/kfuncs.rst                       |  10 +
 arch/arm64/net/bpf_jit_comp.c                      |   2 +
 arch/mips/net/bpf_jit_comp32.c                     |   2 +-
 arch/mips/net/bpf_jit_comp64.c                     |   3 +-
 include/linux/bpf.h                                |   5 +-
 include/linux/bpf_verifier.h                       |  43 +--
 include/linux/btf.h                                |   1 +
 include/linux/skbuff.h                             |   5 +-
 kernel/bpf/btf.c                                   | 136 ++++++----
 kernel/bpf/check_btf.c                             |  12 +-
 kernel/bpf/core.c                                  |  21 +-
 kernel/bpf/crypto.c                                |   5 +-
 kernel/bpf/fixups.c                                |  24 +-
 kernel/bpf/hashtab.c                               |  43 ++-
 kernel/bpf/helpers.c                               |  60 ++---
 kernel/bpf/memalloc.c                              |  50 ++--
 kernel/bpf/offload.c                               |   2 +
 kernel/bpf/states.c                                |  16 +-
 kernel/bpf/syscall.c                               |  15 +-
 kernel/bpf/verifier.c                              | 162 ++++++++---
 net/bpf/test_run.c                                 |   4 +-
 net/core/filter.c                                  |  46 ++--
 net/core/skmsg.c                                   |   4 +
 net/core/sock_map.c                                |   1 +
 net/ipv4/inet_connection_sock.c                    |   3 +-
 net/xdp/xskmap.c                                   |   2 +-
 tools/lib/bpf/libbpf.c                             |   7 +
 tools/lib/bpf/relo_core.c                          |  58 ++--
 tools/testing/selftests/bpf/prog_tests/cb_refs.c   |   2 +-
 .../selftests/bpf/prog_tests/core_reloc_raw.c      | 192 +++++++++++++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |  10 +
 .../testing/selftests/bpf/prog_tests/exceptions.c  |   1 +
 .../testing/selftests/bpf/prog_tests/linked_list.c |   4 +-
 .../bpf/prog_tests/local_kptr_ownership.c          | 296 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/percpu_alloc.c        | 105 ++++++++
 .../selftests/bpf/prog_tests/sock_destroy.c        | 121 +++++++++
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |   2 +
 .../selftests/bpf/prog_tests/tc_change_tail_pmtu.c | 125 +++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   4 +
 tools/testing/selftests/bpf/progs/dynptr_success.c |  20 ++
 tools/testing/selftests/bpf/progs/exceptions.c     |  30 +++
 .../selftests/bpf/progs/iters_state_safety.c       |  22 ++
 .../selftests/bpf/progs/sock_destroy_prog.c        |  30 +++
 .../selftests/bpf/progs/test_spin_lock_fail.c      |  67 ++++-
 .../selftests/bpf/progs/test_tc_change_tail_pmtu.c | 129 +++++++++
 tools/testing/selftests/bpf/progs/verifier_arena.c |  49 ++++
 .../bpf/progs/verifier_async_cb_context.c          | 106 ++++++++
 .../selftests/bpf/progs/verifier_btf_flex_array.c  |  56 ++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c |  53 ++++
 tools/testing/selftests/bpf/progs/verifier_gotox.c |  48 ++++
 .../selftests/bpf/progs/verifier_kfunc_perfmon.c   |  75 ++++++
 .../testing/selftests/bpf/progs/verifier_loops1.c  |  36 +++
 tools/testing/selftests/bpf/progs/verifier_sock.c  |  38 +++
 .../bpf/progs/verifier_xdp_direct_packet_access.c  |  35 +++
 54 files changed, 2131 insertions(+), 267 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail_pmtu.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail_pmtu.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
