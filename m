Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4846AF0A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634626; cv=none; b=Rl3hoTzFnLJWgy8VrYT7XuK/K5iH2oM/cGHETSl7S13fAZz7ykJXJaIxsDIjzbKdUBIiwU2BlZ/WFnk04SG5YqzE2A99UDxYL1J56fXcFTaVh5zZkBgyz0ZgQkfEvxwiQF3qugG19t6oVIZHiSDAgFvYHiUkDWTf6F0dJQB+pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634626; c=relaxed/simple;
	bh=JUukeKwSq0s2ZTYVQEo/BQtlpG/CuSGyrQa9AS6AaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxU+H5Ad2ELCVeRJARBbrAVBBxVVlQv8LUQYBEiCKOspamniXp/X+di05tBlsUtj72Vmua0z+8L5QHY2MuimdybGtstwgtfFKwvb4wOXpwiCd6caVrR3CL2MMmsKW1VuQqvOPPOkgwGA7PG7rzpyUDQHC3fnI6ZVAAdF6EKSiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gLCh0/r5; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gLCh0/r5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JUukeKwSq0s2ZTYVQEo/BQtlpG/CuSGyrQa9AS6AaCo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786634621; v=1; x=1787239421;
 b=gLCh0/r58WETAdzVQ29SKJKu8Fiuzqhw29CV9lHYGDk685aCD1VbhoTZusfK0Qhs3NKw32DB
 Hwoh5f050w9ZSYfPH7MkGmDzQiJY6A/3NZ2497iApNOZy4q5eQoT6JIXIsc9RZLh/7I2Et4o3tA
 preiO2i6LmsODM81ZIMKxQIw=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id 6441e36c711f3a0a;
	Thu, 13 Aug 2026 15:23:40 +0000
X-Migadu-Flow: FLOW_OUT
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
Subject: [PATCH bpf-next v12 00/10] bpf: Introduce global percpu data
Date: Thu, 13 Aug 2026 23:23:13 +0800
Message-ID: <20260813152324.97937-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v11 -> v12:
* Improve feature check in bpf_object__create_maps() in libbpf.
* Add percpu_array map support in bpf_map__set_value_size() in libbpf.
* Exercise bpf_map__set_value_size() in selftest.
* Drop dead warning in bpf_object__populate_internal_map() in libbpf.
  (Sashiko)
* v11: https://lore.kernel.org/bpf/20260806163125.11172-1-leon.hwang@linux.dev/

v10 -> v11:
* Drop env->prog->jit_requested check when inlining insns for global
  percpu data.
* Do not autocreate percpu_array map when kernel does not have global
  percpu data support in libbpf.
* Check map->btf_value_type_id in bpftool's is_skel_data().
* Exercise bpf_map__lookup_elem() in selftest.
* Collect Reviewed-by tags from Emil, thanks.
* Drop all duplicate blank lines in kernel/bpf/*.c. (Emil)
* Factor out check_map_mem_read() helper. (Emil)
* Check bpf_jit_supports_percpu_insn() first in
  percpu_array_map_direct_value_addr/meta(). (Emil)
* Add comment for 'map->libbpf_type == LIBBPF_MAP_PERCPU' in libbpf's
  map_is_mmapable(). (Emil)
* Init update_flags as a const var in libbpf's
  bpf_object__populate_internal_map(). (Emil)
* Keep is_mmapable_map() beyond is_skel_data() in bpftool. (Emil)
* Add 'run' and 'cpu_id' in selftest. (Emil)
* Drop subskel test. Verify the generated subskel manually. (Emil)
* Add comment to the raw insns in selftest. (Emil)
* v10: https://lore.kernel.org/bpf/20260715153254.92010-1-leon.hwang@linux.dev/

v9 -> v10:
* Rebase latest bpf-next tree to resolve code conflict in verifier in
  patch #1.
* v9: https://lore.kernel.org/bpf/20260713154024.30851-1-leon.hwang@linux.dev/

v8 -> v9:
* Use real name for percpu data maps in libbpf in patch #4.
* Add long map name test in patch #6.
* Move parse_cpu_mask_file() to test_percpu_data_on_cpus() in test in
  patch #6.
* Validate map type in get_map_ident() for percpu data maps in patch #5.
* Update code comment in verifier in patch #2. (per Andrii)
* Pass 'type' to internal_map_name in libbpf in patch #4. (per Andrii)
* Factor out the helper is_skel_data() in bpftool in patch #5.
  (per Quentin and Andrii)
* v8: https://lore.kernel.org/bpf/20260629152406.52582-1-leon.hwang@linux.dev/

v7 -> v8:
* Send patch #1 and #2 separately that fix interpreter fallback issues.
  (Andrii)
* Use 'array->elem_size' to avoid 'range' local variable in
  percpu_array_map_direct_value_meta(). (Andrii)
* Keep original map name for percpu data's map in libbpf. (Andrii)
* Factor out helper bpf_map_is_skel_data() in bpftool. (Andrii)
* Update commit message of direct access read-only percpu_array map.
  (Andrii)
* Add test to verify that it is disallowed to directly write data of
  read-only percpu_array map. (Andrii)
* Drop unused 'num_cpus' in test. (bot+bpf-ci)
* Factor out helper test_percpu_data_on_cpus() in test. (bot+bpf-ci)
* v7: https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@linux.dev/

v6 -> v7:
* Use tgt_endian() in bpf_gen__map_update_elem() in patch #6. (Sashiko)
* Use sizeof(args) in verifier_snprintf test in patch #10. (Sashiko)
* Drop xlated test of v6. (Alexei)
* v6: https://lore.kernel.org/bpf/20260615152646.27639-1-leon.hwang@linux.dev/

v5 -> v6:
* Prevent running user addr_space_cast and addr_percpu insns in
  interpreter. (Sashiko)
* Cast __percpu pointer to u64 with (__force unsigned long). (lkp)
* Exclude BPF_MAP_TYPE_PERCPU_ARRAY in check_mem_access() before calling
  bpf_map_direct_read(), and add a test to verify it.
  (Sashiko, bot+bpf-ci)
* Skip percpu data variables for subskeleton in bpftool. (Sashiko)
* Protect skel->percpu using mprotect(..., PROT_READ) in light skeleton.
  (Sashiko, bot+bpf-ci)
* Drop roundup() in tests. (Sashiko)
* Call test_global_percpu_data_verifier_log() without
  test__start_subtest(). (Sashiko)
* Cast insn->imm to __u64 with (__u32) in xlated test. (Sashiko)
* Check cnt using the new idx in xlated test. (Sashiko)
* v5: https://lore.kernel.org/bpf/20260608145113.65857-1-leon.hwang@linux.dev/

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

Leon Hwang (10):
  bpf: Drop duplicate blank lines in kernel/bpf/
  bpf: Factor out check_map_mem_read helper in verifier
  bpf: Introduce global percpu data
  libbpf: Probe percpu data feature
  libbpf: Add support for global percpu data
  bpftool: Generate skeleton for global percpu data
  selftests/bpf: Add tests to verify global percpu data
  selftests/bpf: Test direct reading/writing read-only percpu_array map
  selftests/bpf: Test verifier log for global percpu data
  selftests/bpf: Verify bpf_iter for global percpu data

 kernel/bpf/arraymap.c                         |  38 +-
 kernel/bpf/backtrack.c                        |   2 -
 kernel/bpf/btf.c                              |   1 -
 kernel/bpf/cfg.c                              |   1 -
 kernel/bpf/const_fold.c                       |   1 -
 kernel/bpf/fixups.c                           |  38 +-
 kernel/bpf/hashtab.c                          |   2 -
 kernel/bpf/helpers.c                          |   1 -
 kernel/bpf/liveness.c                         |   2 -
 kernel/bpf/queue_stack_maps.c                 |   1 -
 kernel/bpf/syscall.c                          |   5 -
 kernel/bpf/verifier.c                         | 100 +++---
 tools/bpf/bpftool/gen.c                       |  53 ++-
 tools/lib/bpf/bpf_gen_internal.h              |   3 +-
 tools/lib/bpf/features.c                      |  35 ++
 tools/lib/bpf/gen_loader.c                    |   3 +-
 tools/lib/bpf/libbpf.c                        |  81 ++++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/skel_internal.h                 |  24 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 336 ++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       |  89 +++++
 22 files changed, 725 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

--
2.55.0
