Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A29175A96
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518192; cv=none; b=AkZi1GNYQwmK/k27mKx8UTyeQYOFd1qu1MgAWsSszc8Jh8ZVpZMg0oRgyptuGfSFRF8fvTu5V6ryljIIW8oCvrw8rLeQ9XDV44dlH0Zg2cprWTQkBgkfj4zjTg1l1UkIFGJO6B+C/4VWS0Y+ZTOnm2eRAg5knmbDFPdphEPT2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518192; c=relaxed/simple;
	bh=phw9DBoCLbtlGCxj37mT08U/PsgxThvZMkDXZKhak8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TndC3EAeATwSMJ4yBvfANUo0vXE9AFyxFXfRs27qwfM1Zyv9ELfXqxqQ+MgyUIAJa90VhupzEhVwZtVikqyfVD5Kn+orPZABwXWH0ftiHyxBlmaSvSFxpQxVMFZ1rk6+PO3ISPyX5QZdlbDwxR+HYU0uQrjZBHZ5//ZdsRFWoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoYM+oHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoYM+oHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2ACC19424;
	Sat, 18 Apr 2026 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518191;
	bh=phw9DBoCLbtlGCxj37mT08U/PsgxThvZMkDXZKhak8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=MoYM+oHz5Oy3moQgnV499kmW8IJIYfoeNQ7k05KEaQZx11uIGhejjVX1RROptpzWH
	 gRAJ8oCJHpF0TxphdRXFDpXj55A+HEWQ1Cwnp9nyDfvUEm7uF654z6/DGQx/kGkZF2
	 +wT3OMhEtjWMBlOPKKvIO3dvIO2QR1E33FyJxgihB26atnEju3XAtA9JAmPYsnGaW4
	 AGfkY9Zf9sm3dU7fg8miR/YWeX4B6H2NCK9QtkSM/Bb78IgaQAr5IVism+zMyqDFls
	 egKegCmOIFMecKaB6vaG8HpkLZ3Ovb/vAjgOGuuTjZVOXRVbcghX7UnalTP2v2psMF
	 m7ho7d6rDmBag==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v13 0/6] bpf: add cpu time counter kfuncs
Date: Sat, 18 Apr 2026 06:15:58 -0700
Message-ID: <20260418131614.1501848-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds 2 kfuncs to provide a way to precisely measure the
time spent running some code. The first patch provides a way to get cpu
cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
architecture it is effectively rdtsc_ordered() function. On arm64, it is
JITed to a read of CNTVCT_EL0 with ordering or CNTVCTSS_EL0, depending
on cpu support.

The second patch adds a kfunc to convert cpu cycles to nanoseconds using
shift/mult constants discovered by kernel. The main use-case for this
kfunc is to convert deltas of timestamp counter values into nanoseconds.
It is not supposed to get CLOCK_MONOTONIC_RAW values as offset part is
skipped. JIT version is done for x86 and arm64 for now, on other
architectures it falls back to get CLOCK_MONOTONIC_RAW values.

The reason to have these functions is to avoid overhead added by
a bpf_ktime_get_ns() call in case of benchmarking, when two timestamps
are taken to get delta value. With both functions being JITed, the
overhead is minimal and the result has better precision. New functions
can be used to benchmark BPF code directly in the program, or can be
used in kprobe/uprobe to store timestamp counter in the session cookie
and then in kretprobe/uretprobe the delta can be calculated and
converted into nanoseconds.

These will be used in under-development BPF benchmarks, the first of
which is available at [1].

Pre-requriement for this patch is to adjust CONFIG_BPF_JIT to depend on
CONFIG_BPF_SYSCALL as it simplify things and it's actually a long
overdue patch.

Selftests are also added to check whether the JIT implementation is
correct and to show the simplest usage example.

[1] https://github.com/puranjaymohan/bpf/commits/bpf_bench/

Change log:
v12: https://lore.kernel.org/bpf/20250319163638.3607043-1-vadfed@meta.com/
Changes in v13:
- Added support for arm64
- Rebased on latest bpf-next/master
- Changed the word helper to kfunc in the commit message to not confuse
  with bpf helpers.

v11 -> v12:
* drop x86_32 JIT implementation because previous implementation of
  mul_u64_u32_shr() was not fully correct and the amount of work to
	properly implement it in asm is not worth the result.
* add comment explaining stablility of shift and mult values
* add comment explaining the reasoning behind CLOCK_MONOTONIC_RAW
  usage in fallback mode
* drop KF_FASTCALL tag from bpf_get_cpu_time_counter() as it cannot
  be implemented as fastcall in the verifier
* re-implement verifier checks for possible JIT of kfuncs
* adjust selftests to use JIT code for x86_64 and verifier inlining
  for arm64
v10 -> v11:
* add missing IS_ENABLED(CONFIG_BPF_SYSCALL)
* reword "cycles" -> "counter"
v9 -> v10:
* rework fallback implementation to avoid using vDSO data from
  kernel space.
* add comment about using "LFENCE; RDTSC" instead of "RDTSCP"
* guard x86 JIT implementation to be sure that TSC is enabled and
  stable
* v9 link:
  https://lore.kernel.org/bpf/20241123005833.810044-1-vadfed@meta.com/
v8 -> v9:
* rewording of commit messages, no code changes
* move change log from each patch into cover letter
v7 -> v8:
* rename kfuncs again to bpf_get_cpu_time_counter() and
  bpf_cpu_time_counter_to_ns()
* use cyc2ns_read_begin()/cyc2ns_read_end() to get mult and shift
  constants in bpf_cpu_time_counter_to_ns()
v6 -> v7:
* change boot_cpu_has() to cpu_feature_enabled() (Borislav)
* return constant clock_mode in __arch_get_hw_counter() call
v5 -> v6:
* added cover letter
* add comment about dropping S64_MAX manipulation in jitted
  implementation of rdtsc_oredered (Alexey)
* add comment about using 'lfence;rdtsc' variant (Alexey)
* change the check in fixup_kfunc_call() (Eduard)
* make __arch_get_hw_counter() call more aligned with vDSO
  implementation (Yonghong)
v4 -> v5:
* use #if instead of #ifdef with IS_ENABLED
v3 -> v4:
* change name of the helper to bpf_get_cpu_cycles (Andrii)
* Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
  it on architectures which do not have vDSO functions and data
* reduce the scope of check of inlined functions in verifier to only 2,
  which are actually inlined.
* change helper name to bpf_cpu_cycles_to_ns.
* hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
  unsupported architectures.
v2 -> v3:
* change name of the helper to bpf_get_cpu_cycles_counter to
  explicitly mention what counter it provides (Andrii)
* move kfunc definition to bpf.h to use it in JIT.
* introduce another kfunc to convert cycles into nanoseconds as
  more meaningful time units for generic tracing use case (Andrii)
v1 -> v2:
* Fix incorrect function return value type to u64
* Introduce bpf_jit_inlines_kfunc_call() and use it in
	mark_fastcall_pattern_for_call() to avoid clobbering in case
	of running programs with no JIT (Eduard)
* Avoid rewriting instruction and check function pointer directly
	in JIT (Alexei)
* Change includes to fix compile issues on non x86 architectures

Puranjay Mohan (1):
  bpf, arm64: Add JIT support for cpu time counter kfuncs

Vadim Fedorenko (5):
  bpf: adjust BPF JIT dependency to BPF_SYSCALL
  bpf: add bpf_get_cpu_time_counter kfunc
  bpf: add bpf_cpu_time_counter_to_ns kfunc
  selftests/bpf: add selftest to check bpf_get_cpu_time_counter jit
  selftests/bpf: add usage example for cpu time counter kfuncs

 arch/arm64/include/asm/insn.h                 |   2 +
 arch/arm64/net/bpf_jit.h                      |   4 +
 arch/arm64/net/bpf_jit_comp.c                 |  54 ++++++
 arch/x86/net/bpf_jit_comp.c                   |  72 ++++++++
 arch/x86/net/bpf_jit_comp32.c                 |   2 +
 include/linux/bpf.h                           |   4 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/Kconfig                            |   2 +-
 kernel/bpf/core.c                             |  11 ++
 kernel/bpf/helpers.c                          |  17 ++
 kernel/bpf/verifier.c                         |  14 +-
 .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 168 ++++++++++++++++++
 15 files changed, 408 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c


base-commit: eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2
-- 
2.52.0

