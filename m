Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6E3E0C68
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930336; cv=none; b=TNHd79mmA+1dyo/5BDvk4wUE2Ra/UzOJPs8RLiHsIEQXzTS3iGsJ9FCgxvfwglzHh9C9T2Ne3fgMWIx+RWQjpqEp2uWoSmeppn27ucwKD1v4ZOVDacHmNzULJh9zFOlgDf4yF5KgwsAmjshX7cAS8rdzf9EWMbDiY5NTDk3ojPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930336; c=relaxed/simple;
	bh=zpTxAxP947s9cJEn9EDZxBoY92LNv2osLiDvR8X0ehc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sM1SrWYLBpyL26g6Qcy7nHibxvHeEydQQt+StMHs9BMU5MigdX9JFft3gy6AaeWScoEpamhex7bw5rc7GHCYcju6VdQqnDIUxo7PyT6SIf+RhLUqVLrrZuy8mIETw8dUvELPP5I9bCV6/V3n3TKNJJ2SQHTnNbUjatHRwa8/edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrWBmAwz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrWBmAwz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780930323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/pciVPC2xqp2EO/Pq57rgsAvQnLo5VK2dLi8MJpMYI=;
	b=vrWBmAwzekGnt9uCJNdmD6semZX85ailhOHPDxU37vPyDTbs5oB2x7ZooUIdSHXlrdrLzr
	x1GNlJLjlOmiIm1PjFzHpUht2iUOimgkbyfItyRjcSUpsrm5Jf5xmdBkB8Nc6qze7kEiob
	XAb64apumnyq5H0iUAUlKf20VR9pcmY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 0/9] bpf: Introduce global percpu data
Date: Mon,  8 Jun 2026 22:51:04 +0800
Message-ID: <20260608145113.65857-1-leon.hwang@linux.dev>
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
v4 -> v5:
* Add prog->jit_requested check to prevent running percpu data in
  interpreter in patch #1.
* Factor out verifier log tests using its own patch.
* Address comments from Alexei:
  * Move map_type check from check_mem_access() to bpf_map_direct_read()
    in patch #2.
  * Move BPF_MAP_TYPE_INSN_ARRAY map_type check from const_reg_xfer() to
    bpf_map_direct_read() in patch #2.
  * Add a test to verify that the off of xlated ldimm64 insn matches the
    off encoded in the ELF ldimm64 insn.
  * Drop patch #5 of v4.
* Address reviews from Sashiko:
  * Update commit message of patch #6 to indicate that maps.percpu->mmaped
    has been marked as read-only in libbpf.
  * Lookup elem on specified CPU using BPF_F_CPU in tests.
  * Drop unnecessary err == -EOPNOTSUPP in test.
  * Locate target field using its offset in the iter test.
* v4: https://lore.kernel.org/bpf/20260414132421.63409-1-leon.hwang@linux.dev/

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

Leon Hwang (9):
  bpf: Drop duplicate blank lines in verifier
  bpf: Introduce global percpu data
  libbpf: Probe percpu data feature
  libbpf: Add support for global percpu data
  bpftool: Generate skeleton for global percpu data
  selftests/bpf: Add tests to verify global percpu data
  selftests/bpf: Add tests to verify verifier log for global percpu data
  selftests/bpf: Add test to verify xlated insns for global percpu data
  selftests/bpf: Add test to verify bpf_iter for global percpu data

 kernel/bpf/arraymap.c                         |  39 +-
 kernel/bpf/const_fold.c                       |   1 -
 kernel/bpf/fixups.c                           |  32 ++
 kernel/bpf/verifier.c                         |  29 +-
 tools/bpf/bpftool/gen.c                       |  24 +-
 tools/lib/bpf/bpf_gen_internal.h              |   3 +-
 tools/lib/bpf/features.c                      |  35 ++
 tools/lib/bpf/gen_loader.c                    |   3 +-
 tools/lib/bpf/libbpf.c                        |  68 +++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 341 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       |  90 +++++
 13 files changed, 626 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

-- 
2.54.0

