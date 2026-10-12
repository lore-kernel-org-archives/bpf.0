Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7D4A1DF1
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819661; cv=none; b=lyvCVMq+Crfx7oFEymRJsDBsAJC0kS5TV0cPiZLN7AFkXAOeTBMzKoQTknNQg2B2EzaiBaA2Wwfw5VmbzbNk6RN8aiF/2T/4ujGDeqJvUTKmrrk/k8DwVNtfxxEl1KsBKRpNwoDmAqXXGNh63Yoz0u06u4Y9c6F/rI65Ux70OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819661; c=relaxed/simple;
	bh=sdKl1gtqk3xvj688fGKe4A5/EYlWEX/GrlUAafq8bb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFesV/2OOe+Y+GSGFJVDqhjFrs7A5qnBtQ4ZIYmxEL1JzTKp6fIfk+IPNOnKyJCG96zHF8TSsAWtQD6mVXb7CXg2QEwHqurABoljHHXjPGl5WhwNI1OUZB8nRYc1x4p2MPXmFoVBtjBLa2mr4yvJGrKntPTVkUJY3QarKG8iuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqI3vp7y; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqI3vp7y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sdKl1gtqk3xvj688fGKe4A5/EYlWEX/GrlUAafq8bb4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819657; v=1; x=1792424457;
 b=fqI3vp7y0fKyTpHkZtywkbQFNHNEX8sqwKhTxdKPubQxgGHPabb0q53mVAm/rUs/UcdI34Nd
 8hzIkgTBSBJSYw10DgmzGkV2xHqyOa222Xb+yE0K4asvHoCGazCr7oxaq3j4tdVelchX/RuYqbI
 EJDNfQPg/4rhz6Er2CJ0VU6M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6c90b0003de49e1;
	Mon, 12 Oct 2026 15:40:34 +0000
X-Mizu-Trace-ID: c6c90b0003de49e1
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 00/21] bpf: Add tracing_multi link support for bpf progs
Date: Mon, 12 Oct 2026 23:40:02 +0800
Message-ID: <20261012154024.29423-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the tracing_multi link support for kernel functions [1], add
support for bpf progs.

With this support, I'll be able to enhance the function-graph feature of
bpfsnoop [2]. It will trace all bpf progs, including their subprogs, to
draw a full function call graph including bpf prog call sites.

The attachment could speed-up when there are hundreds of targets. For
example, on high CPU core count servers, it probably runs 200 tc-bpf
progs as Kubernetes CNI, and each tc-bpf prog might have 4 subprogs.
Hence, there will be 1000 targets to trace for bpfsnoop's function-graph
feature.

With tracing_multi link support for bpf progs, bpfsnoop will be able to
attach to all targets quickly.

When attaching to 1000 targets, fentry.multi is much faster than fentry
on a 16c16g QEMU VM on an AMD EPYC 9745 server.

./bench tracing-multi-attach-progs
Setting up benchmark 'tracing-multi-attach-progs'...
tracing-multi-attach-progs: prepared 1000 identical BPF program targets
tracing-multi-attach-progs: fentry created and attached 1000 programs/links in 338.171ms
tracing-multi-attach-progs: fentry.multi created one program and attached one 1000-target link in 47.345ms
tracing-multi-attach-progs: fentry.multi creation/attachment speedup is 7.14x

Unlike the tracing_multi link support for kernel functions, the support
for bpf progs does not rely on the ftrace
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS. Hence, the support for bpf progs
will apply to all archs that have trampoline support by design.

Links:
[1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.org/
[2] https://github.com/bpfsnoop/bpfsnoop

Changes:
v1 -> v2:
* Drop the factoring update_fentry_multi() helper.
* Add bpf_arch_text_poke_batch() to x86_64 JIT backend.
* Add bpf_text_poke_batch() helper.
* Move trampoline_lock_all(), trampoline_unlock_all(), and
  bpf_trampoline_multi_attach_init() out of the
  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard.
* Factor out bpf_trampoline_multi_prog_attach/detach() to get rid of
  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS.
* Shrink CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard scope for
  bpf_tracing_multi_attach().
* Explain justification in cover letter. (Andrii)
* Check '!funcs[i]' before libbpf_find_prog_btf_id() in libbpf. (Sashiko)
* Add BPF_F_TRACING_MULTI_TGT_PROGS in link info UAPI. (Sashiko)
* Verify '\0' before skipping '_' when parsing prog name from symbol
  name in bpftool. (Sashiko)
* Expose libbpf's libbpf_find_prog_btf_id() in attach failure tests.
  (Sashiko)
* Select the target prog according to the 'first' value. (Sashiko)
* Add qsort() in link info test's setup_tmulti_bpf_prog_targets().
  (Sashiko)
* Drop '((u64)tgt_prog->aux->id << 32) | ids[i]' in link fdinfo.
  (bot+bpf-ci)
* Use different cookie values for different targets in cookie tests.
  (bot+bpf-ci)
* v1: https://lore.kernel.org/bpf/20260809150111.45000-1-leon.hwang@linux.dev/

Leon Hwang (21):
  bpf: Initialize ftrace_managed in bpf_trampoline_get()
  bpf: Drop unnecessary ftrace_location() in
    register/unregister/modify_fentry_multi()
  bpf, x86: Factor out bpf_arch_text_poke_prepare_insns() helper on
    x86_64
  bpf, x86: Factor out bpf_arch_text_poke_check_ip() helper on x86_64
  bpf, x86: Introduce bpf_arch_text_poke_batch() on x86_64
  bpf: Add bpf_text_poke_batch() helper in trampoline
  bpf: Check tgt_prog before is_tracing_multi_id() in verifier
  bpf: Move helpers out of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard in
    trampoline
  bpf: Add bpf_trampoline_multi_prog_attach/detach()
  bpf: Shrink CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS guard scope for
    bpf_tracing_multi_attach()
  bpf: Add tracing_multi link support for bpf progs
  libbpf: Add tracing_multi link support for bpf progs
  bpf: Add tracing_multi link fdinfo support for bpf progs
  bpf: Add tracing_multi link info support for bpf progs
  selftests/bpf: Add tracing_multi bpf prog attach test
  selftests/bpf: Add tracing_multi bpf prog attach failure tests
  selftests/bpf: Add tracing_multi bpf prog cookie test
  selftests/bpf: Add tracing_multi bpf prog rollback test
  selftests/bpf: Add tracing_multi bpf prog link info test
  selftests/bpf: Test tailcall with fentry.multi
  selftests/bpf: Benchmark tracing_multi bpf progs attachment

 arch/x86/net/bpf_jit_comp.c                   | 100 +++++-
 include/linux/bpf.h                           |  38 +-
 include/uapi/linux/bpf.h                      |   9 +-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/trampoline.c                       | 339 ++++++++++++++++--
 kernel/bpf/verifier.c                         |  22 +-
 kernel/trace/bpf_trace.c                      | 243 ++++++++++---
 tools/bpf/bpftool/link.c                      |  63 +++-
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.c                        |  43 ++-
 tools/lib/bpf/libbpf.h                        |   4 +-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/bench.c           |   5 +
 .../benchs/bench_tracing_multi_attach_progs.c | 193 ++++++++++
 .../selftests/bpf/prog_tests/fill_link_info.c | 169 ++++++++-
 .../selftests/bpf/prog_tests/tailcalls.c      |  64 ++++
 .../selftests/bpf/prog_tests/tracing_multi.c  | 254 +++++++++++++
 .../bpf/progs/tracing_multi_attach_progs.c    |  24 ++
 .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 ++++
 22 files changed, 1495 insertions(+), 155 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_progs.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c

-- 
2.55.0

