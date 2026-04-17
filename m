Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D12C08DC
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453991; cv=none; b=uEjVqbprozRHWr9WFm/UinOO6zE1KaPgsZj51P6EWAl0ncrhRV+IgMNb+7v/ZKEw5b2Pm35YVPwlKzfKTfLbHDRqFuWulYFQvQJ3wj1NtcmfMSg56Fm7VXQGbH/ngcvAVe20lD4nYvuf6XapP7spHesbzzFHToWgUH6YfRjgiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453991; c=relaxed/simple;
	bh=LG89ACORkh5OeaPWCiYSy78acCJUpYG2+ML6awMDrYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvsRWjPWLYYp21ExohynXqB8WEeL6vEyHO8fjVPL4sb7oGBktAB4/ouTrcT02NydBxgtw7H2nNvq32TBhbl+IxewgEyuvqaQaCROuCo3olzMeWzjO3TgOTfLtBI9IZG+iH+eom58G1iqcxtszsBYvyH0zTsch9EGnQB2E4+sA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aufUdNuR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aufUdNuR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f943870baso263802b3a.1
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776453990; x=1777058790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZnslMbT4zZE0kUNr7Y3bhl4J2/WxdR8ZBKTNyw2VdU=;
        b=aufUdNuRamsUBlcucosZ4NBgsihJNOJclcfF1SSy8UuFX9rE5vl7NH3rLxbteUryLP
         COecjVaQnQ0Bdwha6M/UF4ygcW2vcLU7eKPhbui2sS7gjC9bDCyXGb7fakX2MqqweB7Q
         lomWVo/S8ZGOn/t0yoXC34brjyK9Ojbwaq0IrquvdpVl4GuP26aH9Owe/Qdw9CpyWchP
         +IXQCUzu07fa9PmKvkS4x9PzHycwAwiDR7WcLhRckPTlZBIBBtLbMWICQq8+Wqtl+JMB
         tGSpqeuukMLH96G0I0VBixb6qBZBXFc0GdZcv3sfyNHm9PZMM9uOCc0mub8S8rvJqoOl
         lmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453990; x=1777058790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZnslMbT4zZE0kUNr7Y3bhl4J2/WxdR8ZBKTNyw2VdU=;
        b=akkNaijmNuTClxmfvPLkRoclP8rnWw853Ed3ZoWfhTy8BLU5Rf+zxw2bR/hI/4oDT9
         hEmXOmXJ7w5yDTl4uNpPMFiiVayuBApDi2zBx7/2TNhe1waknsuJL8NTpn/BzM2cBmOr
         cvljCiIvFn+bQ1DivjXzYNNZDzmtEETZFC9w5XMHYv365vm5HCheuflx35ia5dV1YfHT
         EFryAeCvZB4PvZn+XokAQe8uSBHYdc25EcTqRl8alcRI4BaslcVK7vabS0zXKGYmGa5h
         EeWlOk29U79ZB2jf8ym9PM7xX8PqmQb8IM6AGcNd4budx5wT8UBWBaVA4f6J+3aDWJj7
         XsTA==
X-Gm-Message-State: AOJu0Yx+5xjT5A4cqvJbQ+5AubR1dkQH6cbOmaAjg5y/lkQOE+UXuHa5
	Hbs2sZOn3amtAuzAzcGdbHg1PehrR8ly7okxyggxoy+AwW50BbbsAE4c
X-Gm-Gg: AeBDieur9FpkTgZzJBuriKRXBZmJxbkqPac970e5USFfdNdUBLev9ajNcWUoPd74aIg
	Iev8wV5sApEJBVmSa6/9fV740cLiQh0JIFEwtF1pqy+0YMR2zsupEVezpZyfpZ8bJ0al9pBNThm
	67oGutzx1mSyfWKRJYwRnWbdR0iKB01xOuNwGK11sF5Lj+Ruw36dN9nbHkfT+EqDeUPsxLh/snm
	6rs3cVDdNXUMK1vfxlZpSY44iKAVBZoZqRH31yhBqftXWNaL/wHmIO4jDTwwt76rKtUirXsIWra
	AlzWedW0R9N1KDT+stLZYyRU3FHvI3rliS5ZD2FJiCZZf2OjwBE+o4jQk++LOLoFbcWVa2G2qFj
	4AUlD9a7cYYrdop6gyY0a7JKNWBj+2V//F2b9QOz5B/w72N78rPqtBbaW1P/XObfGLps+67lH3I
	bBZ+K0kZQMd2/hifUCCiock6e3CIvRzT6i2i3ktWGYjyF2mOXOdDHqXud7X8//lMyDVtRiPmcxM
	140X0ZKiIFiH4PboBjFFoZxMMIy2ZRPqQ+RdY4lztuK35I+49Khbm57GP/onVXU9PuvS4By
X-Received: by 2002:a05:6a00:2ea5:b0:82f:37e3:ae82 with SMTP id d2e1a72fcca58-82f8c984060mr4470531b3a.44.1776453989843;
        Fri, 17 Apr 2026 12:26:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec04448sm3261243b3a.55.2026.04.17.12.26.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Apr 2026 12:26:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.1-rc1
Date: Fri, 17 Apr 2026 12:26:27 -0700
Message-ID: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to e1d486445af3c392628532229f7ce5f5cf7891b6:

  bpf, arm32: Reject BPF-to-BPF calls and callbacks in the JIT (2026-04-17 12:05:45 -0700)

----------------------------------------------------------------
Most of the diff stat comes from Xu Kuohai's fix. Since all JITs
had to be touched to move constant blinding out and pass bpf_verifier_env in.

- Fix use-after-free in arena_vm_close on fork (Alexei Starovoitov)

- Dissociate struct_ops program with map if map_update fails (Amery Hung)

- Fix out-of-range and off-by-one bugs in arm64 JIT (Daniel Borkmann)

- Fix precedence bug in convert_bpf_ld_abs alignment check (Daniel Borkmann)

- Fix arg tracking for imprecise/multi-offset in BPF_ST/STX insns
  (Eduard Zingerman)

- Copy token from main to subprogs to fix missing kallsyms (Eduard Zingerman)

- Prevent double close and leak of btf objects in libbpf (Jiri Olsa)

- Fix af_unix null-ptr-deref in sockmap (Michal Luczaj)

- Fix NULL deref in map_kptr_match_type for scalar regs (Mykyta Yatsenko)

- Avoid unnecessary IPIs. Remove redundant bpf_flush_icache() in arm64 and
  riscv JITs (Puranjay Mohan)

- Fix out of bounds access. Validate node_id in arena_alloc_pages() (Puranjay Mohan)

- Reject BPF-to-BPF calls and callbacks in arm32 JIT (Puranjay Mohan)

- Refactor all JITs to pass bpf_verifier_env to emit ENDBR/BTI
  for indirect jump targets on x86-64, arm64 JITs (Xu Kuohai)

- Allow UTF-8 literals in bpf_bprintf_prepare() (Yihan Ding)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (8):
      Merge branch 'bpf-arg-tracking-for-imprecise-multi-offset-bpf_st-stx'
      bpf: Fix use-after-free in arena_vm_close on fork
      Merge branch 'bpf-arm64-riscv-remove-redundant-icache-flush-after-pack-allocator-finalize'
      Merge branch 'fix-garbage-data-in-task-local-data'
      Merge branch 'bpf-copy-bpf-token-from-main-program-to-subprograms'
      Merge branch 'emit-endbr-bti-instructions-for-indirect'
      Merge branch 'bpf-fix-null-deref-when-storing-scalar-into-kptr-slot'
      Merge branch 'bpf-allow-utf-8-literals-in-bpf_bprintf_prepare'

Amery Hung (4):
      selftests/bpf: Prevent allocating data larger than a page
      selftests/bpf: Fix tld_get_data() returning garbage data
      selftests/bpf: Test small task local data allocation
      bpf: Dissociate struct_ops program with map if map_update fails

Daniel Borkmann (3):
      bpf, arm64: Reject out-of-range B.cond targets
      bpf, arm64: Fix off-by-one in check_imm signed range check
      bpf: Fix precedence bug in convert_bpf_ld_abs alignment check

Eduard Zingerman (4):
      bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
      selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
      bpf: copy BPF token from main program to subprograms
      selftests/bpf: verify kallsyms entries for token-loaded subprograms

Jiri Olsa (1):
      libbpf: Prevent double close and leak of btf objects

Martin KaFai Lau (1):
      Merge branch 'bpf-sockmap-fix-af_unix-null-ptr-deref-in-proto-update'

Michal Luczaj (5):
      bpf, sockmap: Annotate af_unix sock:: Sk_state data-races
      bpf, sockmap: Fix af_unix iter deadlock
      selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
      bpf, sockmap: Fix af_unix null-ptr-deref in proto update
      bpf, sockmap: Take state lock for af_unix iter

Mykyta Yatsenko (2):
      bpf: Fix NULL deref in map_kptr_match_type for scalar regs
      selftests/bpf: Reject scalar store into kptr slot

Puranjay Mohan (4):
      bpf, arm64: Remove redundant bpf_flush_icache() after pack allocator finalize
      bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
      bpf: Validate node_id in arena_alloc_pages()
      bpf, arm32: Reject BPF-to-BPF calls and callbacks in the JIT

Shung-Hsi Yu (1):
      selftests/bpf: Fix timer_start_deadlock failure due to hrtimer change

Xu Kuohai (5):
      bpf: Move constants blinding out of arch-specific JITs
      bpf: Pass bpf_verifier_env to JIT
      bpf: Add helper to detect indirect jump targets
      bpf, x86: Emit ENDBR for indirect jump targets
      bpf, arm64: Emit BTI for indirect jump target

Yihan Ding (2):
      bpf: allow UTF-8 literals in bpf_bprintf_prepare()
      selftests/bpf: cover UTF-8 trace_printk output

 arch/arc/net/bpf_jit_core.c                        |  41 ++---
 arch/arm/net/bpf_jit_32.c                          |  49 ++----
 arch/arm64/lib/insn.c                              |   2 +
 arch/arm64/net/bpf_jit_comp.c                      | 103 ++++-------
 arch/loongarch/net/bpf_jit.c                       |  61 ++-----
 arch/mips/net/bpf_jit_comp.c                       |  22 +--
 arch/parisc/net/bpf_jit_core.c                     |  75 ++++----
 arch/powerpc/net/bpf_jit_comp.c                    |  74 +++-----
 arch/riscv/net/bpf_jit.h                           |   6 -
 arch/riscv/net/bpf_jit_core.c                      |  70 +++-----
 arch/s390/net/bpf_jit_comp.c                       |  61 +++----
 arch/sparc/net/bpf_jit_comp_64.c                   |  63 +++----
 arch/x86/net/bpf_jit_comp.c                        |  73 +++-----
 arch/x86/net/bpf_jit_comp32.c                      |  35 +---
 include/linux/bpf.h                                |   2 +
 include/linux/bpf_verifier.h                       |   9 +-
 include/linux/filter.h                             |  50 +++++-
 kernel/bpf/arena.c                                 |  23 ++-
 kernel/bpf/bpf_struct_ops.c                        |   7 +-
 kernel/bpf/core.c                                  | 138 ++++++++++-----
 kernel/bpf/fixups.c                                | 163 ++++++++++++++---
 kernel/bpf/helpers.c                               |  17 +-
 kernel/bpf/liveness.c                              | 114 ++++++------
 kernel/bpf/syscall.c                               |   4 -
 kernel/bpf/verifier.c                              |  26 ++-
 net/core/filter.c                                  |   2 +-
 net/core/sock_map.c                                |   4 +-
 net/unix/af_unix.c                                 |   9 +-
 net/unix/unix_bpf.c                                |   3 +
 tools/lib/bpf/libbpf.c                             |  21 +--
 tools/testing/selftests/bpf/Makefile               |   1 +
 tools/testing/selftests/bpf/prog_tests/snprintf.c  |   3 +-
 .../selftests/bpf/prog_tests/task_local_data.h     |  13 +-
 .../bpf/prog_tests/test_task_local_data.c          |  96 +++++++++-
 tools/testing/selftests/bpf/prog_tests/token.c     |  86 ++++++++-
 .../selftests/bpf/prog_tests/trace_printk.c        |  28 ++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c |  21 +--
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c  |  10 ++
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |  15 ++
 .../selftests/bpf/progs/task_local_data.bpf.h      |   5 +-
 .../selftests/bpf/progs/timer_start_deadlock.c     |   8 +-
 tools/testing/selftests/bpf/progs/token_kallsyms.c |  19 ++
 tools/testing/selftests/bpf/progs/trace_printk.c   |  10 ++
 .../selftests/bpf/progs/verifier_live_stack.c      | 193 +++++++++++++++++++++
 tools/testing/selftests/bpf/sysctl_helpers.c       |  37 ++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |   8 +
 46 files changed, 1173 insertions(+), 707 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/token_kallsyms.c
 create mode 100644 tools/testing/selftests/bpf/sysctl_helpers.c
 create mode 100644 tools/testing/selftests/bpf/sysctl_helpers.h
