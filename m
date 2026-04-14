Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1393E6DD4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173083; cv=none; b=gATm36HlfWPwJd6HDavqh9ASgEoeYEKaLoh0TuVZQo3jZLXB7MdCwm90nsL/7/BBpBpuIPvn18MeQ7ry48VXed+uHnX607AvRvy8gZVBrOPS4wnhfSa6BL+lm6iHKoYhHRikXQE8mw3HHYnjgMocIoLkQnGIkGO5uoepz+VavM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173083; c=relaxed/simple;
	bh=7WEm9mWebfGrU7XBfffEDTPMXRxQv4vRzgDzjIPWxug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqWza8TtjqOSgyrxGsmp4ZQTY4N91OCp6XnSqsxptmjFvjVOOMNCtYdp8oEf106+vup7N5IroZ1Cb6AJVcxMv2Gkl98atJZ9H+lvXD9eCjFncCL2WfMsWVkJANx3r08ua+vGu33J+jX6t78VSGmV82Y7XPbVQqbvQvikls+DqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BUwEFf8m; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BUwEFf8m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l2Dz7WuyC1JD2lPyLZaTDuaCzH3iQxVlxQ4Rll2XrU0=;
	b=BUwEFf8mn/tl8CH82+7j3T+V5lym3MPnT0AJBGl1zKSpp+oDkM6uZSXg4pPGooM7jqeDXd
	v0x+KVlABIdiGX/VCciBtf/qzbdvmtG/k33mvSCQvt7JckmDmvsBIjI2I74b0ymxWd0QTc
	HropTGMaViz3BZ4J502T+4jGjump8lQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/8] bpf: Introduce global percpu data
Date: Tue, 14 Apr 2026 21:24:12 +0800
Message-ID: <20260414132421.63409-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces global percpu data, similar to commit
6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
in C for BPF programs.

With this enhancement, it becomes possible to define and use global percpu
variables, like the DEFINE_PER_CPU() macro in the kernel
include/linux/percpu-defs.h.

The section name for global peurcpu data is ".percpu". Even though, a one-byte
percpu variable (e.g., char run SEC(".percpu") = 0;) can trigger a crash
with Clang 17 [1], users are expected to use such small variables as global
percpu data with newer Clang versions, which don't have the issue.

The idea stems from the bpfsnoop [2], which itself was inspired by
retsnoop [3]. During testing of bpfsnoop on the v6.6 kernel, two LBR
(Last Branch Record) entries were observed related to the
bpf_get_smp_processor_id() helper.

Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
the overhead and consequently minimizing these two LBR records.

However, the introduction of global percpu data offers a more robust
solution. By leveraging the percpu_array map and percpu instruction,
global percpu data can be implemented intrinsically.

This feature also facilitates sharing percpu information between tail
callers and callees or between freplace callers and callees through a
shared global percpu variable. Previously, this was achieved using a
1-entry percpu_array map, which this patch set aims to improve upon.

Links:
[1] https://lore.kernel.org/bpf/fd1b3f58-c27f-403d-ad99-644b7d06ecb3@linux.dev/
[2] https://github.com/bpfsnoop/bpfsnoop
[3] https://github.com/anakryiko/retsnoop

Changes:
v3 -> v4:
* Drop duplicate blank lines in verifier.
* Add percpu data feature probe in libbpf.
* Update percpu_array map using BPF_F_ALL_CPUS flag for lskel, if no cpu flag
  is set.
* Add two tests to verify verifier log.
* Add a test to verify mov64_percpu_reg instruction.
* Add a test to verify bpf_iter for percpu data map.
* Update percpu_array map using BPF_F_ALL_CPUS flag in libbpf
  (per Alexei and Andrii).
* Address comments from Andrii:
  * Use .percpu as section identifier.
  * Use bpf_jit_supports_percpu_insn() instead of CONFIG_SMP.
  * Drop bpf_map__is_internal_percpu() API.
  * Drop unnecessary __aligned(8) in libbpf, verified by selftest.
  * Make mmap data read-only after loading prog.
v3: https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

v2 -> v3:
  * Use ".data..percpu" as PERCPU_DATA_SEC.
  * Address comment from Alexei:
    * Add u8, array of ints and struct { .. } vars to selftest.
v2: https://lore.kernel.org/bpf/20250213161931.46399-1-leon.hwang@linux.dev/

v1 -> v2:
  * Address comments from Andrii:
    * Use LIBBPF_MAP_PERCPU and SEC_PERCPU.
    * Reuse mmaped of libbpf's struct bpf_map for .percpu map data.
    * Set .percpu struct pointer to NULL after loading skeleton.
    * Make sure value size of .percpu map is __aligned(8).
    * Use raw_tp and opts.cpu to test global percpu variables on all CPUs.
  * Address comments from Alexei:
    * Test non-zero offset of global percpu variable.
    * Test case about BPF_PSEUDO_MAP_IDX_VALUE.
v1: https://lore.kernel.org/bpf/20250127162158.84906-1-leon.hwang@linux.dev/

rfc -> v1:
  * Address comments from Andrii:
    * Keep one image of global percpu variable for all CPUs.
    * Reject non-ARRAY map in bpf_map_direct_read(), check_reg_const_str(),
      and check_bpf_snprintf_call() in verifier.
    * Split out libbpf changes from kernel-side changes.
    * Use ".percpu" as PERCPU_DATA_SEC.
    * Use enum libbpf_map_type to distinguish BSS, DATA, RODATA and
      PERCPU_DATA.
    * Avoid using errno for checking err from libbpf_num_possible_cpus().
    * Use "map '%s': " prefix for error message.
rfc: https://lore.kernel.org/bpf/20250113152437.67196-1-leon.hwang@linux.dev/

Leon Hwang (8):
  bpf: Drop duplicate blank lines in verifier
  bpf: Introduce global percpu data
  libbpf: Probe percpu data feature
  libbpf: Add support for global percpu data
  bpf: Update per-CPU maps using BPF_F_ALL_CPUS flag
  bpftool: Generate skeleton for global percpu data
  selftests/bpf: Add tests to verify global percpu data
  selftests/bpf: Add a test to verify bpf_iter for global percpu data

 kernel/bpf/arraymap.c                         |  41 ++-
 kernel/bpf/fixups.c                           |  31 ++
 kernel/bpf/syscall.c                          |  15 +
 kernel/bpf/verifier.c                         |  27 +-
 tools/bpf/bpftool/gen.c                       |  24 +-
 tools/lib/bpf/bpf_gen_internal.h              |   3 +-
 tools/lib/bpf/features.c                      |  35 +++
 tools/lib/bpf/gen_loader.c                    |   3 +-
 tools/lib/bpf/libbpf.c                        |  67 ++++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 276 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 102 +++++++
 13 files changed, 582 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

--
2.53.0

