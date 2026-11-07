Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022966;
	b=R/zgZtNInWI4Fj6JIp4HIWJ+I5z4t+H0vqldtkY+Crj3Jf2pGyLnBnXKW6u6M3GiVCzy
	 XfzAKuDYrsl5T6+605aHBfeyhxhZetlI2aBl41g31BpVCpCHLbWlmYna4NzGAiXsINJXG
	 ko5JCo2hogiiC/mmhCtqLl7LsU2+/a/m1xZnclVkGCOKZIx+R95oXxglZZEettaGDqI2g
	 Q2nzDGtrquVA6Kw6G21QUiCT9zTy7bUpsnaViMXG8tIkgTyEb4YOxQmsTH74vuLbSQEmk
	 x6q8Dqn6xM9jcrkvzKL45gSa1wtI/ePoJrroX40v0EFfXQ8N01bU6y9ygrB0pNrL3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yHJVQTNgpDllBcpwM9z0tQJFpbticnXV1njTAC0ynbo=;
	b=3C6oSwyMRQSuvAq+R88jgR3/9X8QpWOEkPxii+qXePi/yPWmMf71inxXmxREnxOYBN2k
	 u/DKA4MprMcWm4Bmjh/1pqOs0fAUtOlVv7qayz2VuCi2UgN0cO90Twe+Tf3Orno2xoLjt
	 oBJopBoUuxRjDSUtl4ys/Y0n+ZOZbv89sFXT5OVkDmHQ+N3MwlVzrAqj5YC0tVhxn6vXS
	 jHEYokP+RgIjojzfs5GcaRsRU9MKojNkJo0NvsmoIHhNoxHnyytYaQyUjNvzss3rCP51K
	 2a8ha8vJ5OEjGlnYJJNYrPAx2iFuOSfXg46UMDQ5seG+E8WiM1M89GxNuQXf1HyboZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnD2iqDg;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB1606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDB1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnD2iqDg
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0fd031198so280310a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022964; x=1794627764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHJVQTNgpDllBcpwM9z0tQJFpbticnXV1njTAC0ynbo=;
        b=fnD2iqDgP4ywT7FYDsh1JwxwU3Q9jSq4+h+hD0qfyaenhd0sNFwD6HlVJJ9PuUbKDu
         d5s6OrR1RHLyJfq9CCHq7xmEoQ3ACDTkK+/rBGmi3KvdeOSPzYHPvUlb8yHqtBWfTmXL
         CHSGhfU9Po0QprNKexUyzkVPr2HB7XlPub0nZsjxcIK5Rb8Z3ChsrftOnB6hcAfUY5zj
         A6Knr+kAZ7NfPw1NPSW5pvN0KNIc2IfsQwb9rmzQToR65L0VcwNI7K7sIClZxwtb6Uvc
         ydw3KazqjiFEbMr2mbxPtrqTWaboottJfQg3vUucaLlNYMqm6O/6u/q5bWX5Chty7bmH
         Br8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022964; x=1794627764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHJVQTNgpDllBcpwM9z0tQJFpbticnXV1njTAC0ynbo=;
        b=doofHXWa+M9Y7Lexx24PiiTcwkI+amgx+LRfDOPOkiFXAxk+iZkGSBzPMOPn6YmPqh
         LmQHhG93EIzT3tZlZU3leD9ORNZiYB0faNRbaEexDlPXY2a/Nqh2u0Owgw54yPk0k2Pz
         x4BIlK9GjyK502gTKNOSZ85wWOqkCyFPAwCkcmcu518Z4bmLhOOI9lYhid29Q6vIGQSO
         ZOrkP1gqTilJxtrZNmmEA38Z7e0dTDMiS/FLyN/kFCTbkfwEDJwRtITGq4gD6OQyL9Hp
         FoCvyBCnKZT2XDwbhTXZFpsqgt93mlvq1Myw+KaBGRlWe1KBBsf64Dts/LHSCFFmeaMn
         wEkw==
X-Gm-Message-State: APuU4Z/fz32RnWZ2g+XttuwkXGgvQLaU3oRrm28M15vyPsRgjKOhh1lF
	UcAS6LMYItcFNdqThoODkiHuxVHqTEy+w2hmAwHvX2UNCHPbllkrYbf1kMBnaQ==
X-Gm-Gg: AYBFou2ZMrzWTmDqRJk3I2FoREq3tyd0B/k7BwAeeozbZGsXxRa2AZgnJzx602cjnG8
	wQawUMSZqV8NjE55h5UrnzQzYa/H4hX7hK2jh8+QoJ0E1FkpRLtUYuYwdtpr3v5azpBlo8sOmUI
	5XTN6p+BjQm27wjoiY/2pWu5iLi2pmazrXxqhi8kW9MIQ/vbm00UkKjanJXv5NZewH38FFgFK0G
	kCaPzwTL9tbvuEqkpAyH4O2BSoy+zugPWpjl9VEipARcEA3lZtRg1/hseu9exqKAo5oaROsANbR
	ol+FKkvZOunWIRq7D/ALx5oHsBF8PYT26gwl9jtQ6Mrm5zWB4hQD9MFUMEEzU8rspj7MaKpo+DV
	PbY8/lNsgOyZPcq6kH3Ub2QoUHDO8J4u/1diuTHZPJWbQSFb9yRLk1rAWzNlgh2VTDS666nsw2m
	tuY51BZ+sk85GwDo1LNpdVUckpO/vDRfX++0GB2sz8P89pUgo8+chKwQuYQRkQiG+Ihq0SN4LdJ
	rU+asLkjSg5BM+WfeDHMRUEcTs9zH/igXSfUL0kMMtf1ftprGttd01tdYVtK3vtsTTg+ws7eFwQ
	IPThxCVvSUrL/Nexl+treaOc2+SbjWBZfk4X6xBA1K9ZDhOnAyGq/nH4MDQ4ALomyovYB5EP9q+
	v5goIlwFBxmQEcbTn7EectHCyCIAx5Tyzro3eIT5uvzWCCavhUWBSmYREctMJomSm79+J5tPZBQ
	ZzyChAPHaWRZ1XoYrLCWvC
X-Received: by 2002:a17:90b:1c0d:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3b0db6e0342mr4279092a91.22.1794022962358;
        Fri, 06 Nov 2026 19:42:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101c28791sm1046293a91.3.2026.11.06.19.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:42:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 46/46] selftests/bpf: Test progs without bpf_for(), zero, can_loop and such
Date: Sat,  7 Nov 2026 03:37:54 +0000
Message-ID: <20261107033758.1547725-47-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

Loops in BPF progs are written for the verifier, not for the reader:

  bpf_qdisc_fifo.c       bpf_for(i, 0, sch->q.qlen) {
  arena_htab.c           for (i = zero; i < 100000 && can_loop; i++) {
  rbtree_search_kptr.c   while (rb_n && can_loop) {
  tailcall_bpf2bpf2.c    barrier_var(ret); return ret;

progs/plain_c_X.c has progs of progs/X.c in plain C, with the maps,
globals, functions and headers that they use:

  bpf_for(i, a, b)               for (i = a; i < b; i++)
  bpf_repeat(n)                  for (int i = 0; i < n; i++)
  i = zero                       i = 0
  cond && can_loop               cond
  while (can_loop)               while (1)
  barrier_var(x); cond_break;    removed
  static __always_inline         static

Only progs that bpf-next rejects in this form are taken. It says:

  12  The sequence of 8193 jumps is too complex
   7  infinite loop detected
   6  BPF program is too large. Processed 1000001 insn
   6  tail_call / LD_ABS is only allowed in functions that return 'int'
   3  invalid size of register spill

bpf-next rejects all 34, five of them in some flavours of test_progs only.
With this series they load.

RUN_TESTS() loads each prog, and runs it where the result is known.
arena_list, bpf_ma_ttrace and dynptr_success have short drivers.
Nothing bounds a walk of a list or a tree: the verifier adds may_goto.
Five functions of xdp_lb_bench.c become subprogs, two with stack args.
Three progs are unsafe with and without the macros: they keep __failure
and __msg(). With GCC 11 of the 34 are skipped: __skip() says why.
pyperf600_bpf_loop and loop_takes_reference_once are still rejected in
plain C: left out.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/plain_c.c        | 160 ++++
 .../selftests/bpf/progs/plain_c_arena_htab.c  | 222 ++++++
 .../bpf/progs/plain_c_arena_htab_asm.c        |   5 +
 .../selftests/bpf/progs/plain_c_arena_list.c  | 181 +++++
 .../selftests/bpf/progs/plain_c_arena_race.c  |  45 ++
 .../bpf/progs/plain_c_arena_strsearch.c       | 263 +++++++
 .../bpf/progs/plain_c_bpf_ma_ttrace.c         |  53 ++
 .../bpf/progs/plain_c_bpf_nop_bench.c         |  75 ++
 .../bpf/progs/plain_c_bpf_qdisc_fifo.c        | 132 ++++
 .../bpf/progs/plain_c_bpf_qdisc_fq.c          | 728 ++++++++++++++++++
 .../bpf/progs/plain_c_cpumask_success.c       |  83 ++
 .../bpf/progs/plain_c_dynptr_success.c        | 175 +++++
 .../selftests/bpf/progs/plain_c_iters.c       | 147 ++++
 .../bpf/progs/plain_c_mem_rdonly_untrusted.c  |  24 +
 .../bpf/progs/plain_c_mptcp_subflow.c         | 116 +++
 .../bpf/progs/plain_c_rbtree_search.c         | 136 ++++
 .../bpf/progs/plain_c_rbtree_search_kptr.c    | 264 +++++++
 .../bpf/progs/plain_c_strobemeta_bpf_loop.c   | 583 ++++++++++++++
 .../bpf/progs/plain_c_tailcall_bpf2bpf2.c     |  40 +
 .../plain_c_tailcall_bpf2bpf_hierarchy1.c     |  44 ++
 .../plain_c_tailcall_bpf2bpf_hierarchy2.c     |  81 ++
 .../plain_c_tailcall_bpf2bpf_hierarchy3.c     |  74 ++
 .../bpf/progs/plain_c_tailcall_callback.c     |  80 ++
 .../bpf/progs/plain_c_test_wakeup_source.c    |  93 +++
 .../plain_c_tracing_stack_arg_tailcall_tgt.c  |  55 ++
 .../bpf/progs/plain_c_verifier_arena_large.c  | 122 +++
 .../plain_c_verifier_iterating_callbacks.c    |  25 +
 .../bpf/progs/plain_c_verifier_loop_as_is.c   |  40 +
 .../bpf/progs/plain_c_xdp_lb_bench.c          | 723 +++++++++++++++++
 29 files changed, 4769 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/plain_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_strsearch.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_nop_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_cpumask_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_mptcp_subflow.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_rbtree_search.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_rbtree_search_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf2.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_callback.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tracing_stack_arg_tailcall_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_arena_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_iterating_callbacks.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_loop_as_is.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_xdp_lb_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/testing/selftests/bpf/prog_tests/plain_c.c
new file mode 100644
index 000000000000..b7305118a454
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * progs/plain_c_X.c has the progs of progs/X.c that needed bpf_for(), bpf_repeat(),
+ * 'i = zero', barrier_var(), can_loop or cond_break to get past the verifier, without these.
+ */
+
+#include <test_progs.h>
+
+/* types of globals in the skeletons */
+#include "bpf_arena_list.h"
+
+#include "plain_c_arena_htab.skel.h"
+#include "plain_c_arena_htab_asm.skel.h"
+#include "plain_c_arena_list.skel.h"
+#include "plain_c_arena_race.skel.h"
+#include "plain_c_arena_strsearch.skel.h"
+#include "plain_c_bpf_ma_ttrace.skel.h"
+#include "plain_c_bpf_nop_bench.skel.h"
+#include "plain_c_bpf_qdisc_fifo.skel.h"
+#include "plain_c_bpf_qdisc_fq.skel.h"
+#include "plain_c_cpumask_success.skel.h"
+#include "plain_c_dynptr_success.skel.h"
+#include "plain_c_iters.skel.h"
+#include "plain_c_mem_rdonly_untrusted.skel.h"
+#include "plain_c_mptcp_subflow.skel.h"
+#include "plain_c_rbtree_search.skel.h"
+#include "plain_c_rbtree_search_kptr.skel.h"
+#include "plain_c_strobemeta_bpf_loop.skel.h"
+#include "plain_c_tailcall_bpf2bpf2.skel.h"
+#include "plain_c_tailcall_bpf2bpf_hierarchy1.skel.h"
+#include "plain_c_tailcall_bpf2bpf_hierarchy2.skel.h"
+#include "plain_c_tailcall_bpf2bpf_hierarchy3.skel.h"
+#include "plain_c_tailcall_callback.skel.h"
+#include "plain_c_test_wakeup_source.skel.h"
+#include "plain_c_tracing_stack_arg_tailcall_tgt.skel.h"
+#include "plain_c_verifier_arena_large.skel.h"
+#include "plain_c_verifier_iterating_callbacks.skel.h"
+#include "plain_c_verifier_loop_as_is.skel.h"
+#include "plain_c_xdp_lb_bench.skel.h"
+
+#define RUN(name) RUN_TESTS(plain_c_##name)
+
+/* prog_tests/arena_list.c: add 1000 elems, delete them, compare the sums */
+static void arena_list_add_del(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct plain_c_arena_list *skel;
+	int cnt = 1000, sum = cnt * (cnt - 1) / 2;
+
+	skel = plain_c_arena_list__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->cnt = cnt;
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_add), &opts),
+		  "add");
+	if (skel->bss->skip) {
+		test__skip();
+		goto out;
+	}
+	ASSERT_EQ(skel->arena->arena_sum, sum, "sum of elems");
+	ASSERT_EQ(skel->arena->test_val, cnt + 1, "num of elems");
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_del), &opts),
+		  "del");
+	ASSERT_EQ(skel->bss->list_sum, sum, "sum of deleted elems");
+out:
+	plain_c_arena_list__destroy(skel);
+}
+
+/* prog_tests/bpf_ma_ttrace.c: the loop finds one cache per cpu */
+static void ma_ttrace_run(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct plain_c_bpf_ma_ttrace *skel;
+
+	skel = plain_c_bpf_ma_ttrace__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->nr_cpus = libbpf_num_possible_cpus();
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.check_ttrace), &opts),
+		  "test_run");
+	ASSERT_OK(opts.retval, "retval");
+	ASSERT_EQ(skel->bss->nr_caches, skel->bss->nr_cpus, "nr_caches");
+	plain_c_bpf_ma_ttrace__destroy(skel);
+}
+
+/* prog_tests/dynptr.c: run each prog, it leaves 0 in 'err' */
+static void dynptr_run(void)
+{
+	char data[90000];
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = data, .repeat = 1,
+		    .data_size_in = getpagesize() == 65536 ? sizeof(data) : 5000);
+	struct plain_c_dynptr_success *skel;
+	struct bpf_program *prog;
+
+	skel = plain_c_dynptr_success__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, true);
+	if (!ASSERT_OK(plain_c_dynptr_success__load(skel), "load"))
+		goto out;
+	bpf_object__for_each_program(prog, skel->obj) {
+		skel->bss->err = 0;
+		ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run");
+		ASSERT_EQ(skel->bss->err, 0, bpf_program__name(prog));
+	}
+out:
+	plain_c_dynptr_success__destroy(skel);
+}
+
+void test_plain_c_arena_htab(void) { RUN(arena_htab); }
+void test_plain_c_arena_htab_asm(void) { RUN(arena_htab_asm); }
+
+void test_plain_c_arena_list(void)
+{
+	RUN(arena_list);
+	if (test__start_subtest("run"))
+		arena_list_add_del();
+}
+
+void test_plain_c_arena_race(void) { RUN(arena_race); }
+void test_plain_c_arena_strsearch(void) { RUN(arena_strsearch); }
+
+void test_plain_c_bpf_ma_ttrace(void)
+{
+	RUN(bpf_ma_ttrace);
+	if (test__start_subtest("run"))
+		ma_ttrace_run();
+}
+
+void test_plain_c_bpf_nop_bench(void) { RUN(bpf_nop_bench); }
+void test_plain_c_bpf_qdisc_fifo(void) { RUN(bpf_qdisc_fifo); }
+void test_plain_c_bpf_qdisc_fq(void) { RUN(bpf_qdisc_fq); }
+void test_plain_c_cpumask_success(void) { RUN(cpumask_success); }
+
+void test_plain_c_dynptr_success(void)
+{
+	RUN(dynptr_success);
+	if (test__start_subtest("run"))
+		dynptr_run();
+}
+
+void test_plain_c_iters(void) { RUN(iters); }
+void test_plain_c_mem_rdonly_untrusted(void) { RUN(mem_rdonly_untrusted); }
+void test_plain_c_mptcp_subflow(void) { RUN(mptcp_subflow); }
+void test_plain_c_rbtree_search(void) { RUN(rbtree_search); }
+void test_plain_c_rbtree_search_kptr(void) { RUN(rbtree_search_kptr); }
+void test_plain_c_strobemeta_bpf_loop(void) { RUN(strobemeta_bpf_loop); }
+void test_plain_c_tailcall_bpf2bpf2(void) { RUN(tailcall_bpf2bpf2); }
+void test_plain_c_tailcall_bpf2bpf_hierarchy1(void) { RUN(tailcall_bpf2bpf_hierarchy1); }
+void test_plain_c_tailcall_bpf2bpf_hierarchy2(void) { RUN(tailcall_bpf2bpf_hierarchy2); }
+void test_plain_c_tailcall_bpf2bpf_hierarchy3(void) { RUN(tailcall_bpf2bpf_hierarchy3); }
+void test_plain_c_tailcall_callback(void) { RUN(tailcall_callback); }
+void test_plain_c_test_wakeup_source(void) { RUN(test_wakeup_source); }
+void test_plain_c_tracing_stack_arg_tailcall_tgt(void) { RUN(tracing_stack_arg_tailcall_tgt); }
+void test_plain_c_verifier_arena_large(void) { RUN(verifier_arena_large); }
+void test_plain_c_verifier_iterating_callbacks(void) { RUN(verifier_iterating_callbacks); }
+void test_plain_c_verifier_loop_as_is(void) { RUN(verifier_loop_as_is); }
+void test_plain_c_xdp_lb_bench(void) { RUN(xdp_lb_bench); }
diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_htab.c b/tools/testing/selftests/bpf/progs/plain_c_arena_htab.c
new file mode 100644
index 000000000000..10a50b5058dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_arena_htab.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+/* arena_htab.c, bpf_arena_htab.h and bpf_arena_list.h in plain C */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+} arena SEC(".maps");
+
+#include <errno.h>
+#include "bpf_arena_alloc.h"
+#include <bpf_arena_common.h>
+
+struct arena_list_node;
+
+typedef struct arena_list_node __arena arena_list_node_t;
+
+struct arena_list_node {
+	arena_list_node_t *next;
+	arena_list_node_t * __arena *pprev;
+};
+
+struct arena_list_head {
+	struct arena_list_node __arena *first;
+};
+typedef struct arena_list_head __arena arena_list_head_t;
+
+#define list_entry(ptr, type, member) arena_container_of(ptr, type, member)
+
+#define list_entry_safe(ptr, type, member) \
+	({ typeof(*ptr) * ___ptr = (ptr); \
+	 ___ptr ? ({ cast_kern(___ptr); list_entry(___ptr, type, member); }) : NULL; \
+	 })
+
+/* Safely walk link list elements. Deletion of elements is allowed. */
+#define list_for_each_entry(pos, head, member)					\
+	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
+						    typeof(*(pos)), member),	\
+			      (void *)0);					\
+	     pos && ({ ___tmp = (void *)pos->member.next; 1; });                \
+	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))
+
+static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
+{
+	arena_list_node_t *first = h->first, * __arena *tmp;
+
+	cast_user(first);
+	cast_kern(n);
+	WRITE_ONCE(n->next, first);
+	cast_kern(first);
+	if (first) {
+		tmp = &n->next;
+		cast_user(tmp);
+		WRITE_ONCE(first->pprev, tmp);
+	}
+	cast_user(n);
+	WRITE_ONCE(h->first, n);
+
+	tmp = &h->first;
+	cast_user(tmp);
+	cast_kern(n);
+	WRITE_ONCE(n->pprev, tmp);
+}
+
+static inline void __list_del(arena_list_node_t *n)
+{
+	arena_list_node_t *next = n->next;
+	arena_list_node_t * __arena *pprev = n->pprev;
+
+	cast_user(next);
+	cast_kern(pprev);
+	WRITE_ONCE(*pprev, next);
+	if (next) {
+		cast_user(pprev);
+		cast_kern(next);
+		WRITE_ONCE(next->pprev, pprev);
+	}
+}
+
+#define POISON_POINTER_DELTA 0
+
+#define LIST_POISON1  ((void __arena *) 0x100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void __arena *) 0x122 + POISON_POINTER_DELTA)
+
+static inline void list_del(arena_list_node_t *n)
+{
+	__list_del(n);
+	n->next = LIST_POISON1;
+	n->pprev = LIST_POISON2;
+}
+
+struct htab_bucket {
+	struct arena_list_head head;
+};
+typedef struct htab_bucket __arena htab_bucket_t;
+
+struct htab {
+	htab_bucket_t *buckets;
+	int n_buckets;
+};
+
+static inline htab_bucket_t *__select_bucket(struct htab __arena *htab, __u32 hash)
+{
+	htab_bucket_t *b = htab->buckets;
+
+	cast_kern(b);
+	return &b[hash & (htab->n_buckets - 1)];
+}
+
+static inline arena_list_head_t *select_bucket(struct htab __arena *htab, __u32 hash)
+{
+	return &__select_bucket(htab, hash)->head;
+}
+
+struct hashtab_elem {
+	int hash;
+	int key;
+	int value;
+	struct arena_list_node hash_node;
+};
+typedef struct hashtab_elem __arena hashtab_elem_t;
+
+static hashtab_elem_t *lookup_elem_raw(arena_list_head_t *head, __u32 hash, int key)
+{
+	hashtab_elem_t *l;
+
+	list_for_each_entry(l, head, hash_node)
+		if (l->hash == hash && l->key == key)
+			return l;
+
+	return NULL;
+}
+
+static int htab_hash(int key)
+{
+	return key;
+}
+
+__weak int htab_update_elem(struct htab __arena *htab, int key, int value)
+{
+	hashtab_elem_t *l_new = NULL, *l_old;
+	arena_list_head_t *head;
+
+	cast_kern(htab);
+	head = select_bucket(htab, key);
+	l_old = lookup_elem_raw(head, htab_hash(key), key);
+
+	l_new = bpf_alloc(sizeof(*l_new));
+	if (!l_new)
+		return -ENOMEM;
+	l_new->key = key;
+	l_new->hash = htab_hash(key);
+	l_new->value = value;
+
+	list_add_head(&l_new->hash_node, head);
+	if (l_old) {
+		list_del(&l_old->hash_node);
+		bpf_free(l_old);
+	}
+	return 0;
+}
+
+void htab_init(struct htab __arena *htab)
+{
+	void __arena *buckets = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+
+	cast_user(buckets);
+	htab->buckets = buckets;
+	htab->n_buckets = 2 * PAGE_SIZE / sizeof(struct htab_bucket);
+}
+
+void __arena *htab_for_user;
+bool skip = false;
+
+char __arena arr1[100000];
+char arr2[1000];
+
+SEC("syscall")
+__success __retval(0)
+#if !defined(__clang__) && defined(BPF_ARENA_FORCE_ASM)
+__skip("GCC calls htab_init(): a global function gets an arena pointer as a scalar")
+#endif
+int arena_htab_llvm(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	struct htab __arena *htab;
+	char __arena *arr = arr1;
+	__u64 i;
+
+	htab = bpf_alloc(sizeof(*htab));
+	cast_kern(htab);
+	htab_init(htab);
+
+	/* first run. No old elems in the table */
+	for (i = 0; i < 100000; i++) {
+		htab_update_elem(htab, i, i);
+		arr[i] = i;
+	}
+
+	/* should replace some elems with new ones */
+	for (i = 0; i < 1000; i++) {
+		htab_update_elem(htab, i, i);
+		/* Access mem to make the verifier use bounded loop logic */
+		arr2[i] = i;
+	}
+	cast_user(htab);
+	htab_for_user = htab;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_htab_asm.c b/tools/testing/selftests/bpf/progs/plain_c_arena_htab_asm.c
new file mode 100644
index 000000000000..0b74223e8c8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_arena_htab_asm.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#define BPF_ARENA_FORCE_ASM
+#define arena_htab_llvm arena_htab_asm
+#include "plain_c_arena_htab.c"
diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_list.c b/tools/testing/selftests/bpf/progs/plain_c_arena_list.c
new file mode 100644
index 000000000000..996488b6eabc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_arena_list.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+/* arena_list.c and bpf_arena_list.h in plain C */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+#include "bpf_arena_alloc.h"
+#include <bpf_arena_common.h>
+
+struct arena_list_node;
+
+typedef struct arena_list_node __arena arena_list_node_t;
+
+struct arena_list_node {
+	arena_list_node_t *next;
+	arena_list_node_t * __arena *pprev;
+};
+
+struct arena_list_head {
+	struct arena_list_node __arena *first;
+};
+typedef struct arena_list_head __arena arena_list_head_t;
+
+#define list_entry(ptr, type, member) arena_container_of(ptr, type, member)
+
+#define list_entry_safe(ptr, type, member) \
+	({ typeof(*ptr) * ___ptr = (ptr); \
+	 ___ptr ? ({ cast_kern(___ptr); list_entry(___ptr, type, member); }) : NULL; \
+	 })
+
+/* Safely walk link list elements. Deletion of elements is allowed. */
+#define list_for_each_entry(pos, head, member)					\
+	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
+						    typeof(*(pos)), member),	\
+			      (void *)0);					\
+	     pos && ({ ___tmp = (void *)pos->member.next; 1; });                \
+	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))
+
+__attribute__((unused))
+static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
+{
+	arena_list_node_t *first = h->first, * __arena *tmp;
+
+	cast_user(first);
+	cast_kern(n);
+	WRITE_ONCE(n->next, first);
+	cast_kern(first);
+	if (first) {
+		tmp = &n->next;
+		cast_user(tmp);
+		WRITE_ONCE(first->pprev, tmp);
+	}
+	cast_user(n);
+	WRITE_ONCE(h->first, n);
+
+	tmp = &h->first;
+	cast_user(tmp);
+	cast_kern(n);
+	WRITE_ONCE(n->pprev, tmp);
+}
+
+static inline void __list_del(arena_list_node_t *n)
+{
+	arena_list_node_t *next = n->next;
+	arena_list_node_t * __arena *pprev = n->pprev;
+
+	cast_user(next);
+	cast_kern(pprev);
+	WRITE_ONCE(*pprev, next);
+	if (next) {
+		cast_user(pprev);
+		cast_kern(next);
+		WRITE_ONCE(next->pprev, pprev);
+	}
+}
+
+#define POISON_POINTER_DELTA 0
+
+#define LIST_POISON1  ((void __arena *) 0x100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void __arena *) 0x122 + POISON_POINTER_DELTA)
+
+__attribute__((unused))
+static inline void list_del(arena_list_node_t *n)
+{
+	__list_del(n);
+	n->next = LIST_POISON1;
+	n->pprev = LIST_POISON2;
+}
+
+struct elem {
+	struct arena_list_node node;
+	__u64 value;
+};
+
+struct arena_list_head __arena *list_head;
+int list_sum;
+int cnt;
+bool skip = false;
+const volatile bool nonsleepable = false;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+long __arena arena_sum;
+int __arena test_val = 1;
+struct arena_list_head __arena global_head;
+#else
+long arena_sum SEC(".addr_space.1");
+int test_val SEC(".addr_space.1");
+#endif
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("syscall")
+__success
+int arena_list_add(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	__u64 i;
+
+	list_head = &global_head;
+
+	for (i = 0; i < cnt; i++) {
+		struct elem __arena *n = bpf_alloc(sizeof(*n));
+
+		test_val++;
+		n->value = i;
+		arena_sum += i;
+		list_add_head(&n->node, list_head);
+	}
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__success
+int arena_list_del(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	struct elem __arena *n;
+	int sum = 0;
+
+	/* Take rcu_read_lock to test non-sleepable context */
+	if (nonsleepable)
+		bpf_rcu_read_lock();
+
+	arena_sum = 0;
+	list_for_each_entry(n, list_head, node) {
+		sum += n->value;
+		arena_sum += n->value;
+		list_del(&n->node);
+		bpf_free(n);
+	}
+	list_sum = sum;
+
+	if (nonsleepable)
+		bpf_rcu_read_unlock();
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_race.c b/tools/testing/selftests/bpf/progs/plain_c_arena_race.c
new file mode 100644
index 000000000000..ea200b857a8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_arena_race.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* arena_race.c in plain C */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+
+int target_tid;
+int pause_on_zap;
+int zap_entered;
+int release;
+int timed_out;
+
+static void wait_for_release(void)
+{
+	while (!*(volatile int *)&release)
+		;
+	if (!*(volatile int *)&release)
+		timed_out = 1;
+}
+
+/*
+ * Pause a free while it zaps user mappings: after it cleared the kernel PTEs
+ * and flushed the TLB, but before it releases the range. zap_vma_range() is
+ * generic MM code, so it is an fentry target even where
+ * flush_tlb_kernel_range() is inline (arm64).
+ */
+SEC("?fentry/zap_vma_range")
+__success
+int BPF_PROG(trace_zap, struct vm_area_struct *vma, unsigned long address,
+	     unsigned long size)
+{
+	if ((__u32)bpf_get_current_pid_tgid() != target_tid)
+		return 0;
+	zap_entered = 1;
+	if (pause_on_zap)
+		wait_for_release();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_strsearch.c b/tools/testing/selftests/bpf/progs/plain_c_arena_strsearch.c
new file mode 100644
index 000000000000..f05cf023c4d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_arena_strsearch.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+/* arena_strsearch.c and bpf_arena_strsearch.h in plain C */
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+} arena SEC(".maps");
+
+#include <bpf_arena_common.h>
+
+__noinline int bpf_arena_strlen(const char __arena *s)
+{
+	const char __arena *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		;
+	return sc - s;
+}
+
+/**
+ * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
+ * @pat: Shell-style pattern to match, e.g. "*.[ch]".
+ * @str: String to match.  The pattern must match the entire string.
+ *
+ * Perform shell-style glob matching, returning true (1) if the match
+ * succeeds, or false (0) if it fails.  Equivalent to !fnmatch(@pat, @str, 0).
+ *
+ * Pattern metacharacters are ?, *, [ and \.
+ * (And, inside character classes, !, - and ].)
+ *
+ * This is small and simple implementation intended for device blacklists
+ * where a string is matched against a number of patterns.  Thus, it
+ * does not preprocess the patterns.  It is non-recursive, and run-time
+ * is at most quadratic: strlen(@str)*strlen(@pat).
+ *
+ * An example of the worst case is glob_match("*aaaaa", "aaaaaaaaaa");
+ * it takes 6 passes over the pattern before matching the string.
+ *
+ * Like !fnmatch(@pat, @str, 0) and unlike the shell, this does NOT
+ * treat / or leading . specially; it isn't actually used for pathnames.
+ *
+ * Note that according to glob(7) (and unlike bash), character classes
+ * are complemented by a leading !; this does not support the regex-style
+ * [^a-z] syntax.
+ *
+ * An opening bracket without a matching close is matched literally.
+ */
+__noinline bool glob_match(char const __arena *pat, char const __arena *str)
+{
+	/*
+	 * Backtrack to previous * on mismatch and retry starting one
+	 * character later in the string.  Because * matches all characters
+	 * (no exception for /), it can be easily proved that there's
+	 * never a need to backtrack multiple levels.
+	 */
+	char const __arena *back_pat = NULL, *back_str;
+
+	/*
+	 * Loop over each token (character or class) in pat, matching
+	 * it against the remaining unmatched tail of str.  Return false
+	 * on mismatch, or true after matching the trailing nul bytes.
+	 */
+	for (;;) {
+		unsigned char c = *str++;
+		unsigned char d = *pat++;
+
+		switch (d) {
+		case '?':	/* Wildcard: anything but nul */
+			if (c == '\0')
+				return false;
+			break;
+		case '*':	/* Any-length wildcard */
+			if (*pat == '\0')	/* Optimize trailing * case */
+				return true;
+			back_pat = pat;
+			back_str = --str;	/* Allow zero-length match */
+			break;
+		case '[': {	/* Character class */
+			bool match = false, inverted = (*pat == '!');
+			char const __arena *class = pat + inverted;
+			unsigned char a = *class++;
+
+			/*
+			 * Iterate over each span in the character class.
+			 * A span is either a single character a, or a
+			 * range a-b.  The first span may begin with ']'.
+			 */
+			do {
+				unsigned char b = a;
+
+				if (a == '\0')	/* Malformed */
+					goto literal;
+
+				if (class[0] == '-' && class[1] != ']') {
+					b = class[1];
+
+					if (b == '\0')
+						goto literal;
+
+					class += 2;
+					/* Any special action if a > b? */
+				}
+				match |= (a <= c && c <= b);
+			} while ((a = *class++) != ']');
+
+			if (match == inverted)
+				goto backtrack;
+			pat = class;
+			}
+			break;
+		case '\\':
+			d = *pat++;
+			__attribute__((__fallthrough__));
+		default:	/* Literal character */
+literal:
+			if (c == d) {
+				if (d == '\0')
+					return true;
+				break;
+			}
+backtrack:
+			if (c == '\0' || !back_pat)
+				return false;	/* No point continuing */
+			/* Try again from last *, one character later in str. */
+			pat = back_pat;
+			str = ++back_str;
+			break;
+		}
+	}
+	return false;
+}
+
+static bool test(char const __arena *pat, char const __arena *str, bool expected)
+{
+	bool match = glob_match(pat, str);
+	bool success = match == expected;
+
+	/* bpf_printk("glob_match %s %s res %d ok %d", pat, str, match, success); */
+	return success;
+}
+
+/*
+ * The tests are all jammed together in one array to make it simpler
+ * to place that array in the .init.rodata section.  The obvious
+ * "array of structures containing char *" has no way to force the
+ * pointed-to strings to be in a particular section.
+ *
+ * Anyway, a test consists of:
+ * 1. Expected glob_match result: '1' or '0'.
+ * 2. Pattern to match: null-terminated string
+ * 3. String to match against: null-terminated string
+ *
+ * The list of tests is terminated with a final '\0' instead of
+ * a glob_match result character.
+ */
+static const char __arena glob_tests[] =
+	/* Some basic tests */
+	"1" "a\0" "a\0"
+	"0" "a\0" "b\0"
+	"0" "a\0" "aa\0"
+	"0" "a\0" "\0"
+	"1" "\0" "\0"
+	"0" "\0" "a\0"
+	/* Simple character class tests */
+	"1" "[a]\0" "a\0"
+	"0" "[a]\0" "b\0"
+	"0" "[!a]\0" "a\0"
+	"1" "[!a]\0" "b\0"
+	"1" "[ab]\0" "a\0"
+	"1" "[ab]\0" "b\0"
+	"0" "[ab]\0" "c\0"
+	"1" "[!ab]\0" "c\0"
+	"1" "[a-c]\0" "b\0"
+	"0" "[a-c]\0" "d\0"
+	/* Corner cases in character class parsing */
+	"1" "[a-c-e-g]\0" "-\0"
+	"0" "[a-c-e-g]\0" "d\0"
+	"1" "[a-c-e-g]\0" "f\0"
+	"1" "[]a-ceg-ik[]\0" "a\0"
+	"1" "[]a-ceg-ik[]\0" "]\0"
+	"1" "[]a-ceg-ik[]\0" "[\0"
+	"1" "[]a-ceg-ik[]\0" "h\0"
+	"0" "[]a-ceg-ik[]\0" "f\0"
+	"0" "[!]a-ceg-ik[]\0" "h\0"
+	"0" "[!]a-ceg-ik[]\0" "]\0"
+	"1" "[!]a-ceg-ik[]\0" "f\0"
+	/* Simple wild cards */
+	"1" "?\0" "a\0"
+	"0" "?\0" "aa\0"
+	"0" "??\0" "a\0"
+	"1" "?x?\0" "axb\0"
+	"0" "?x?\0" "abx\0"
+	"0" "?x?\0" "xab\0"
+	/* Asterisk wild cards (backtracking) */
+	"0" "*??\0" "a\0"
+	"1" "*??\0" "ab\0"
+	"1" "*??\0" "abc\0"
+	"1" "*??\0" "abcd\0"
+	"0" "??*\0" "a\0"
+	"1" "??*\0" "ab\0"
+	"1" "??*\0" "abc\0"
+	"1" "??*\0" "abcd\0"
+	"0" "?*?\0" "a\0"
+	"1" "?*?\0" "ab\0"
+	"1" "?*?\0" "abc\0"
+	"1" "?*?\0" "abcd\0"
+	"1" "*b\0" "b\0"
+	"1" "*b\0" "ab\0"
+	"0" "*b\0" "ba\0"
+	"1" "*b\0" "bb\0"
+	"1" "*b\0" "abb\0"
+	"1" "*b\0" "bab\0"
+	"1" "*bc\0" "abbc\0"
+	"1" "*bc\0" "bc\0"
+	"1" "*bc\0" "bbc\0"
+	"1" "*bc\0" "bcbc\0"
+	/* Multiple asterisks (complex backtracking) */
+	"1" "*ac*\0" "abacadaeafag\0"
+	"1" "*ac*ae*ag*\0" "abacadaeafag\0"
+	"1" "*a*b*[bc]*[ef]*g*\0" "abacadaeafag\0"
+	"0" "*a*b*[ef]*[cd]*g*\0" "abacadaeafag\0"
+	"1" "*abcd*\0" "abcabcabcabcdefg\0"
+	"1" "*ab*cd*\0" "abcabcabcabcdefg\0"
+	"1" "*abcd*abcdef*\0" "abcabcdabcdeabcdefg\0"
+	"0" "*abcd*\0" "abcabcabcabcefg\0"
+	"0" "*ab*cd*\0" "abcabcabcabcefg\0";
+
+SEC("syscall")
+__success __retval(0) __skip_without_arena
+int arena_strsearch(void *ctx)
+{
+	unsigned successes = 0;
+	unsigned n = 0;
+	char const __arena *p = glob_tests;
+
+	/*
+	 * Tests are jammed together in a string.  The first byte is '1'
+	 * or '0' to indicate the expected outcome, or '\0' to indicate the
+	 * end of the tests.  Then come two null-terminated strings: the
+	 * pattern and the string to match it against.
+	 */
+	while (*p) {
+		bool expected = *p++ & 1;
+		char const __arena *pat = p;
+
+		p += bpf_arena_strlen(p) + 1;
+		successes += test(pat, p, expected);
+		p += bpf_arena_strlen(p) + 1;
+		n++;
+	}
+
+	n -= successes;
+	/* bpf_printk("glob: %u self-tests passed, %u failed\n", successes, n); */
+
+	return n ? -1 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_bpf_ma_ttrace.c b/tools/testing/selftests/bpf/progs/plain_c_bpf_ma_ttrace.c
new file mode 100644
index 000000000000..71df2e037f5b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_bpf_ma_ttrace.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* bpf_ma_ttrace.c in plain C */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 4096);
+	__type(key, int);
+	__type(value, long);
+} htab SEC(".maps");
+
+extern const void __per_cpu_offset __ksym;
+
+int nr_cpus;
+int nr_caches;
+int in_progress;
+int not_freed;
+
+/* Look at bpf_mem_cache of every cpu that htab allocates its elements from */
+SEC("syscall")
+__success
+int check_ttrace(void *ctx)
+{
+	struct bpf_htab *h = bpf_core_cast(&htab, struct bpf_htab);
+	unsigned long cache = (unsigned long)BPF_CORE_READ(h, ma.cache);
+	const unsigned long *offsets = &__per_cpu_offset;
+	struct bpf_mem_cache *c;
+	unsigned long off;
+	int cpu;
+
+	nr_caches = 0;
+	in_progress = 0;
+	not_freed = 0;
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (bpf_probe_read_kernel(&off, sizeof(off), offsets + cpu))
+			return -1;
+		c = bpf_core_cast((void *)(cache + off), struct bpf_mem_cache);
+		if (c->unit_size)
+			nr_caches++;
+		if (c->call_rcu_ttrace_in_progress.counter)
+			in_progress++;
+		if (c->free_by_rcu_ttrace.first || c->waiting_for_gp_ttrace.first)
+			not_freed++;
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_bpf_nop_bench.c b/tools/testing/selftests/bpf/progs/plain_c_bpf_nop_bench.c
new file mode 100644
index 000000000000..fdb7260b0fdf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_bpf_nop_bench.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/* bpf_nop_bench.c and bench_bpf_timing.bpf.h in plain C */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#include <stdbool.h>
+#include "bpf_misc.h"
+
+#ifndef BENCH_NR_SAMPLES
+#define BENCH_NR_SAMPLES	4096
+#endif
+#ifndef BENCH_NR_CPUS
+#define BENCH_NR_CPUS		256
+#endif
+#define BENCH_CPU_MASK		(BENCH_NR_CPUS - 1)
+
+__u64 timing_samples[BENCH_NR_CPUS][BENCH_NR_SAMPLES];
+__u32 timing_idx[BENCH_NR_CPUS];
+
+volatile __u32 batch_iters;
+volatile __u32 timing_enabled;
+
+static void bench_record_sample(__u64 elapsed_ns)
+{
+	__u32 cpu, idx;
+
+	if (!timing_enabled)
+		return;
+
+	cpu = bpf_get_smp_processor_id() & BENCH_CPU_MASK;
+	idx = timing_idx[cpu];
+
+	if (idx >= BENCH_NR_SAMPLES)
+		return;
+
+	timing_samples[cpu][idx] = elapsed_ns;
+	timing_idx[cpu] = idx + 1;
+}
+
+/*
+ * @body:  expression to time; return value (int) stored in __bench_result.
+ * @reset: undo body's side-effects so each iteration starts identically.
+ *         May reference __bench_result.  Use ({}) for empty reset.
+ *
+ * Runs batch_iters timed iterations, then one untimed iteration whose
+ * return value the macro evaluates to (for validation).
+ */
+#define BENCH_BPF_LOOP(body, reset) ({					\
+	__u64 __bench_start = bpf_ktime_get_ns();			\
+	__u32 __bench_i;						\
+	int __bench_result;						\
+									\
+	for (__bench_i = 0;						\
+	     __bench_i < batch_iters;					\
+	     __bench_i++) {						\
+		__bench_result = (body);				\
+		reset;							\
+	}								\
+									\
+	bench_record_sample(bpf_ktime_get_ns() - __bench_start);	\
+									\
+	__bench_result = (body);					\
+	__bench_result;							\
+})
+
+SEC("syscall")
+__success __retval(0)
+int bench_nop(void *ctx)
+{
+	return BENCH_BPF_LOOP(0, ({}));
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fifo.c
new file mode 100644
index 000000000000..846385204a29
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fifo.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* bpf_qdisc_fifo.c in plain C */
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct skb_node {
+	struct sk_buff __kptr * skb;
+	struct bpf_list_node node;
+};
+
+private(A) struct bpf_spin_lock q_fifo_lock;
+private(A) struct bpf_list_head q_fifo __contains(skb_node, node);
+
+bool init_called;
+
+SEC("struct_ops/bpf_fifo_enqueue")
+__auxiliary
+int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct skb_node *skbn;
+	u32 pkt_len;
+
+	if (sch->q.qlen == sch->limit)
+		goto drop;
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn)
+		goto drop;
+
+	pkt_len = qdisc_pkt_len(skb);
+
+	sch->q.qlen++;
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	bpf_spin_lock(&q_fifo_lock);
+	bpf_list_push_back(&q_fifo, &skbn->node);
+	bpf_spin_unlock(&q_fifo_lock);
+
+	sch->qstats.backlog += pkt_len;
+	return NET_XMIT_SUCCESS;
+drop:
+	bpf_qdisc_skb_drop(skb, to_free);
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops/bpf_fifo_dequeue")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
+{
+	struct bpf_list_node *node;
+	struct sk_buff *skb = NULL;
+	struct skb_node *skbn;
+
+	bpf_spin_lock(&q_fifo_lock);
+	node = bpf_list_pop_front(&q_fifo);
+	bpf_spin_unlock(&q_fifo_lock);
+	if (!node)
+		return NULL;
+
+	skbn = container_of(node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+	if (!skb)
+		return NULL;
+
+	sch->qstats.backlog -= qdisc_pkt_len(skb);
+	bpf_qdisc_bstats_update(sch, skb);
+	sch->q.qlen--;
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_fifo_init")
+__auxiliary
+int BPF_PROG(bpf_fifo_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	sch->limit = 1000;
+	init_called = true;
+	return 0;
+}
+
+SEC("struct_ops/bpf_fifo_reset")
+__success
+void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
+{
+	struct bpf_list_node *node;
+	struct skb_node *skbn;
+	int i;
+
+	for (i = 0; i < sch->q.qlen; i++) {
+		struct sk_buff *skb = NULL;
+
+		bpf_spin_lock(&q_fifo_lock);
+		node = bpf_list_pop_front(&q_fifo);
+		bpf_spin_unlock(&q_fifo_lock);
+
+		if (!node)
+			break;
+
+		skbn = container_of(node, struct skb_node, node);
+		skb = bpf_kptr_xchg(&skbn->skb, skb);
+		if (skb)
+			bpf_kfree_skb(skb);
+		bpf_obj_drop(skbn);
+	}
+	sch->q.qlen = 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_fifo_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fifo = {
+	.enqueue   = (void *)bpf_fifo_enqueue,
+	.dequeue   = (void *)bpf_fifo_dequeue,
+	.init      = (void *)bpf_fifo_init,
+	.reset     = (void *)bpf_fifo_reset,
+	.destroy   = (void *)bpf_fifo_destroy,
+	.id        = "bpf_fifo",
+};
diff --git a/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fq.c
new file mode 100644
index 000000000000..e4e40ceb07cc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fq.c
@@ -0,0 +1,728 @@
+// SPDX-License-Identifier: GPL-2.0
+/* bpf_qdisc_fq.c in plain C */
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define NSEC_PER_USEC 1000L
+#define NSEC_PER_SEC 1000000000L
+
+#define NUM_QUEUE (1 << 20)
+
+struct fq_bpf_data {
+	u32 quantum;
+	u32 initial_quantum;
+	u32 flow_refill_delay;
+	u32 flow_plimit;
+	u64 horizon;
+	u32 orphan_mask;
+	u32 timer_slack;
+	u64 time_next_delayed_flow;
+	u64 unthrottle_latency_ns;
+	u8 horizon_drop;
+	u32 new_flow_cnt;
+	u32 old_flow_cnt;
+	u64 ktime_cache;
+};
+
+enum {
+	CLS_RET_PRIO	= 0,
+	CLS_RET_NONPRIO = 1,
+	CLS_RET_ERR	= 2,
+};
+
+struct skb_node {
+	u64 tstamp;
+	struct sk_buff __kptr * skb;
+	struct bpf_rb_node node;
+};
+
+struct fq_flow_node {
+	int credit;
+	u32 qlen;
+	u64 age;
+	u64 time_next_packet;
+	struct bpf_list_node list_node;
+	struct bpf_rb_node rb_node;
+	struct bpf_rb_root queue __contains(skb_node, node);
+	struct bpf_spin_lock lock;
+	struct bpf_refcount refcount;
+};
+
+struct dequeue_nonprio_ctx {
+	bool stop_iter;
+	u64 expire;
+	u64 now;
+};
+
+struct remove_flows_ctx {
+	bool gc_only;
+	u32 reset_cnt;
+	u32 reset_max;
+};
+
+struct unset_throttled_flows_ctx {
+	bool unset_all;
+	u64 now;
+};
+
+struct fq_stashed_flow {
+	struct fq_flow_node __kptr * flow;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, struct fq_stashed_flow);
+	__uint(max_entries, NUM_QUEUE);
+} fq_nonprio_flows SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, struct fq_stashed_flow);
+	__uint(max_entries, 1);
+} fq_prio_flows SEC(".maps");
+
+private(A) struct bpf_spin_lock fq_delayed_lock;
+private(A) struct bpf_rb_root fq_delayed __contains(fq_flow_node, rb_node);
+
+private(B) struct bpf_spin_lock fq_new_flows_lock;
+private(B) struct bpf_list_head fq_new_flows __contains(fq_flow_node, list_node);
+
+private(C) struct bpf_spin_lock fq_old_flows_lock;
+private(C) struct bpf_list_head fq_old_flows __contains(fq_flow_node, list_node);
+
+private(D) struct fq_bpf_data q;
+
+/* Wrapper for bpf_kptr_xchg that expects NULL dst */
+static void bpf_kptr_xchg_back(void *map_val, void *ptr)
+{
+	void *ret;
+
+	ret = bpf_kptr_xchg(map_val, ptr);
+	if (ret)
+		bpf_obj_drop(ret);
+}
+
+static bool skbn_tstamp_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct skb_node *skbn_a;
+	struct skb_node *skbn_b;
+
+	skbn_a = container_of(a, struct skb_node, node);
+	skbn_b = container_of(b, struct skb_node, node);
+
+	return skbn_a->tstamp < skbn_b->tstamp;
+}
+
+static bool fn_time_next_packet_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct fq_flow_node *flow_a;
+	struct fq_flow_node *flow_b;
+
+	flow_a = container_of(a, struct fq_flow_node, rb_node);
+	flow_b = container_of(b, struct fq_flow_node, rb_node);
+
+	return flow_a->time_next_packet < flow_b->time_next_packet;
+}
+
+static void
+fq_flows_add_head(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+	*flow_cnt += 1;
+}
+
+static void
+fq_flows_add_tail(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_back(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+	*flow_cnt += 1;
+}
+
+static void
+fq_flows_remove_front(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		      struct bpf_list_node **node, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	*node = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	*flow_cnt -= 1;
+}
+
+static bool
+fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
+{
+	bool empty;
+
+	bpf_spin_lock(lock);
+	empty = bpf_list_empty(head);
+	bpf_spin_unlock(lock);
+
+	return empty;
+}
+
+/*
+ * flow->age is used to denote the state of the flow (not-detached, detached, throttled)
+ * as well as the timestamp when the flow is detached.
+ *
+ * 0: not-detached
+ * 1 - (~0ULL-1): detached
+ * ~0ULL: throttled
+ */
+static void fq_flow_set_detached(struct fq_flow_node *flow)
+{
+	flow->age = bpf_jiffies64();
+}
+
+static bool fq_flow_is_detached(struct fq_flow_node *flow)
+{
+	return flow->age != 0 && flow->age != ~0ULL;
+}
+
+static bool sk_listener(struct sock *sk)
+{
+	return (1 << sk->__sk_common.skc_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
+}
+
+static void fq_gc(void);
+
+static int fq_new_flow(void *flow_map, struct fq_stashed_flow **sflow, u64 hash)
+{
+	struct fq_stashed_flow tmp = {};
+	struct fq_flow_node *flow;
+	int ret;
+
+	flow = bpf_obj_new(typeof(*flow));
+	if (!flow)
+		return -ENOMEM;
+
+	flow->credit = q.initial_quantum,
+	flow->qlen = 0,
+	flow->age = 1,
+	flow->time_next_packet = 0,
+
+	ret = bpf_map_update_elem(flow_map, &hash, &tmp, 0);
+	if (ret == -ENOMEM || ret == -E2BIG) {
+		fq_gc();
+		bpf_map_update_elem(&fq_nonprio_flows, &hash, &tmp, 0);
+	}
+
+	*sflow = bpf_map_lookup_elem(flow_map, &hash);
+	if (!*sflow) {
+		bpf_obj_drop(flow);
+		return -ENOMEM;
+	}
+
+	bpf_kptr_xchg_back(&(*sflow)->flow, flow);
+	return 0;
+}
+
+static int
+fq_classify(struct sk_buff *skb, struct fq_stashed_flow **sflow)
+{
+	struct sock *sk = skb->sk;
+	int ret = CLS_RET_NONPRIO;
+	u64 hash = 0;
+
+	if ((skb->priority & TC_PRIO_MAX) == TC_PRIO_CONTROL) {
+		*sflow = bpf_map_lookup_elem(&fq_prio_flows, &hash);
+		ret = CLS_RET_PRIO;
+	} else {
+		if (!sk || sk_listener(sk)) {
+			hash = bpf_skb_get_hash(skb) & q.orphan_mask;
+			/*
+			 * Avoid collision with an existing flow hash, which
+			 * only uses the lower 32 bits of hash, by setting the
+			 * upper half of hash to 1.
+			 */
+			hash |= (1ULL << 32);
+		} else if (sk->__sk_common.skc_state == TCP_CLOSE) {
+			hash = bpf_skb_get_hash(skb) & q.orphan_mask;
+			hash |= (1ULL << 32);
+		} else {
+			hash = sk->__sk_common.skc_hash;
+		}
+		*sflow = bpf_map_lookup_elem(&fq_nonprio_flows, &hash);
+	}
+
+	if (!*sflow)
+		ret = fq_new_flow(&fq_nonprio_flows, sflow, hash) < 0 ?
+		      CLS_RET_ERR : CLS_RET_NONPRIO;
+
+	return ret;
+}
+
+static bool fq_packet_beyond_horizon(struct sk_buff *skb)
+{
+	return (s64)skb->tstamp > (s64)(q.ktime_cache + q.horizon);
+}
+
+SEC("struct_ops/bpf_fq_enqueue")
+__auxiliary
+int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct fq_flow_node *flow = NULL, *flow_copy;
+	struct fq_stashed_flow *sflow;
+	u64 time_to_send, jiffies;
+	struct skb_node *skbn;
+	int ret;
+
+	if (sch->q.qlen >= sch->limit)
+		goto drop;
+
+	if (!skb->tstamp) {
+		time_to_send = q.ktime_cache = bpf_ktime_get_ns();
+	} else {
+		if (fq_packet_beyond_horizon(skb)) {
+			q.ktime_cache = bpf_ktime_get_ns();
+			if (fq_packet_beyond_horizon(skb)) {
+				if (q.horizon_drop)
+					goto drop;
+
+				skb->tstamp = q.ktime_cache + q.horizon;
+			}
+		}
+		time_to_send = skb->tstamp;
+	}
+
+	ret = fq_classify(skb, &sflow);
+	if (ret == CLS_RET_ERR)
+		goto drop;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		goto drop;
+
+	if (ret == CLS_RET_NONPRIO) {
+		if (flow->qlen >= q.flow_plimit) {
+			bpf_kptr_xchg_back(&sflow->flow, flow);
+			goto drop;
+		}
+
+		if (fq_flow_is_detached(flow)) {
+			flow_copy = bpf_refcount_acquire(flow);
+
+			jiffies = bpf_jiffies64();
+			if ((s64)(jiffies - (flow_copy->age + q.flow_refill_delay)) > 0) {
+				if (flow_copy->credit < q.quantum)
+					flow_copy->credit = q.quantum;
+			}
+			flow_copy->age = 0;
+			fq_flows_add_tail(&fq_new_flows, &fq_new_flows_lock, flow_copy,
+					  &q.new_flow_cnt);
+		}
+	}
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn) {
+		bpf_kptr_xchg_back(&sflow->flow, flow);
+		goto drop;
+	}
+
+	skbn->tstamp = skb->tstamp = time_to_send;
+
+	sch->qstats.backlog += qdisc_pkt_len(skb);
+
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	bpf_spin_lock(&flow->lock);
+	bpf_rbtree_add(&flow->queue, &skbn->node, skbn_tstamp_less);
+	bpf_spin_unlock(&flow->lock);
+
+	flow->qlen++;
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	sch->q.qlen++;
+	return NET_XMIT_SUCCESS;
+
+drop:
+	bpf_qdisc_skb_drop(skb, to_free);
+	sch->qstats.drops++;
+	return NET_XMIT_DROP;
+}
+
+static int fq_unset_throttled_flows(u32 index, struct unset_throttled_flows_ctx *ctx)
+{
+	struct bpf_rb_node *node = NULL;
+	struct fq_flow_node *flow;
+
+	bpf_spin_lock(&fq_delayed_lock);
+
+	node = bpf_rbtree_first(&fq_delayed);
+	if (!node) {
+		bpf_spin_unlock(&fq_delayed_lock);
+		return 1;
+	}
+
+	flow = container_of(node, struct fq_flow_node, rb_node);
+	if (!ctx->unset_all && flow->time_next_packet > ctx->now) {
+		q.time_next_delayed_flow = flow->time_next_packet;
+		bpf_spin_unlock(&fq_delayed_lock);
+		return 1;
+	}
+
+	node = bpf_rbtree_remove(&fq_delayed, &flow->rb_node);
+
+	bpf_spin_unlock(&fq_delayed_lock);
+
+	if (!node)
+		return 1;
+
+	flow = container_of(node, struct fq_flow_node, rb_node);
+	flow->age = 0;
+	fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+
+	return 0;
+}
+
+static void fq_flow_set_throttled(struct fq_flow_node *flow)
+{
+	flow->age = ~0ULL;
+
+	if (q.time_next_delayed_flow > flow->time_next_packet)
+		q.time_next_delayed_flow = flow->time_next_packet;
+
+	bpf_spin_lock(&fq_delayed_lock);
+	bpf_rbtree_add(&fq_delayed, &flow->rb_node, fn_time_next_packet_less);
+	bpf_spin_unlock(&fq_delayed_lock);
+}
+
+static void fq_check_throttled(u64 now)
+{
+	struct unset_throttled_flows_ctx ctx = {
+		.unset_all = false,
+		.now = now,
+	};
+	unsigned long sample;
+
+	if (q.time_next_delayed_flow > now)
+		return;
+
+	sample = (unsigned long)(now - q.time_next_delayed_flow);
+	q.unthrottle_latency_ns -= q.unthrottle_latency_ns >> 3;
+	q.unthrottle_latency_ns += sample >> 3;
+
+	q.time_next_delayed_flow = ~0ULL;
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &ctx, 0);
+}
+
+static struct sk_buff*
+fq_dequeue_nonprio_flows(u32 index, struct dequeue_nonprio_ctx *ctx)
+{
+	u64 time_next_packet, time_to_send;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct bpf_list_head *head;
+	struct bpf_list_node *node;
+	struct bpf_spin_lock *lock;
+	struct fq_flow_node *flow;
+	struct skb_node *skbn;
+	bool is_empty;
+	u32 *cnt;
+
+	if (q.new_flow_cnt) {
+		head = &fq_new_flows;
+		lock = &fq_new_flows_lock;
+		cnt = &q.new_flow_cnt;
+	} else if (q.old_flow_cnt) {
+		head = &fq_old_flows;
+		lock = &fq_old_flows_lock;
+		cnt = &q.old_flow_cnt;
+	} else {
+		if (q.time_next_delayed_flow != ~0ULL)
+			ctx->expire = q.time_next_delayed_flow;
+		goto break_loop;
+	}
+
+	fq_flows_remove_front(head, lock, &node, cnt);
+	if (!node)
+		goto break_loop;
+
+	flow = container_of(node, struct fq_flow_node, list_node);
+	if (flow->credit <= 0) {
+		flow->credit += q.quantum;
+		fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+		return NULL;
+	}
+
+	bpf_spin_lock(&flow->lock);
+	rb_node = bpf_rbtree_first(&flow->queue);
+	if (!rb_node) {
+		bpf_spin_unlock(&flow->lock);
+		is_empty = fq_flows_is_empty(&fq_old_flows, &fq_old_flows_lock);
+		if (head == &fq_new_flows && !is_empty) {
+			fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+		} else {
+			fq_flow_set_detached(flow);
+			bpf_obj_drop(flow);
+		}
+		return NULL;
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	time_to_send = skbn->tstamp;
+
+	time_next_packet = (time_to_send > flow->time_next_packet) ?
+		time_to_send : flow->time_next_packet;
+	if (ctx->now < time_next_packet) {
+		bpf_spin_unlock(&flow->lock);
+		flow->time_next_packet = time_next_packet;
+		fq_flow_set_throttled(flow);
+		return NULL;
+	}
+
+	rb_node = bpf_rbtree_remove(&flow->queue, rb_node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node)
+		goto add_flow_and_break;
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+
+	if (!skb)
+		goto add_flow_and_break;
+
+	flow->credit -= qdisc_skb_cb(skb)->pkt_len;
+	flow->qlen--;
+
+add_flow_and_break:
+	fq_flows_add_head(head, lock, flow, cnt);
+
+break_loop:
+	ctx->stop_iter = true;
+	return skb;
+}
+
+static struct sk_buff *fq_dequeue_prio(void)
+{
+	struct fq_flow_node *flow = NULL;
+	struct fq_stashed_flow *sflow;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct skb_node *skbn;
+	u64 hash = 0;
+
+	sflow = bpf_map_lookup_elem(&fq_prio_flows, &hash);
+	if (!sflow)
+		return NULL;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		return NULL;
+
+	bpf_spin_lock(&flow->lock);
+	rb_node = bpf_rbtree_first(&flow->queue);
+	if (!rb_node) {
+		bpf_spin_unlock(&flow->lock);
+		goto out;
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	rb_node = bpf_rbtree_remove(&flow->queue, &skbn->node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node)
+		goto out;
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+
+out:
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_fq_dequeue")
+__success
+struct sk_buff *BPF_PROG(bpf_fq_dequeue, struct Qdisc *sch)
+{
+	struct dequeue_nonprio_ctx cb_ctx = {};
+	struct sk_buff *skb = NULL;
+	int i;
+
+	if (!sch->q.qlen)
+		goto out;
+
+	skb = fq_dequeue_prio();
+	if (skb)
+		goto dequeue;
+
+	q.ktime_cache = cb_ctx.now = bpf_ktime_get_ns();
+	fq_check_throttled(q.ktime_cache);
+	for (i = 0; i < sch->limit; i++) {
+		skb = fq_dequeue_nonprio_flows(i, &cb_ctx);
+		if (cb_ctx.stop_iter)
+			break;
+	};
+
+	if (skb) {
+dequeue:
+		sch->q.qlen--;
+		sch->qstats.backlog -= qdisc_pkt_len(skb);
+		bpf_qdisc_bstats_update(sch, skb);
+		return skb;
+	}
+
+	if (cb_ctx.expire)
+		bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q.timer_slack);
+out:
+	return NULL;
+}
+
+static int fq_remove_flows_in_list(u32 index, void *ctx)
+{
+	struct bpf_list_node *node;
+	struct fq_flow_node *flow;
+
+	bpf_spin_lock(&fq_new_flows_lock);
+	node = bpf_list_pop_front(&fq_new_flows);
+	bpf_spin_unlock(&fq_new_flows_lock);
+	if (!node) {
+		bpf_spin_lock(&fq_old_flows_lock);
+		node = bpf_list_pop_front(&fq_old_flows);
+		bpf_spin_unlock(&fq_old_flows_lock);
+		if (!node)
+			return 1;
+	}
+
+	flow = container_of(node, struct fq_flow_node, list_node);
+	bpf_obj_drop(flow);
+
+	return 0;
+}
+
+extern unsigned CONFIG_HZ __kconfig;
+
+/* limit number of collected flows per round */
+#define FQ_GC_MAX 8
+#define FQ_GC_AGE (3*CONFIG_HZ)
+
+static bool fq_gc_candidate(struct fq_flow_node *flow)
+{
+	u64 jiffies = bpf_jiffies64();
+
+	return fq_flow_is_detached(flow) &&
+	       ((s64)(jiffies - (flow->age + FQ_GC_AGE)) > 0);
+}
+
+static int
+fq_remove_flows(struct bpf_map *flow_map, u64 *hash,
+		struct fq_stashed_flow *sflow, struct remove_flows_ctx *ctx)
+{
+	if (sflow->flow &&
+	    (!ctx->gc_only || fq_gc_candidate(sflow->flow))) {
+		bpf_map_delete_elem(flow_map, hash);
+		ctx->reset_cnt++;
+	}
+
+	return ctx->reset_cnt < ctx->reset_max ? 0 : 1;
+}
+
+static void fq_gc(void)
+{
+	struct remove_flows_ctx cb_ctx = {
+		.gc_only = true,
+		.reset_cnt = 0,
+		.reset_max = FQ_GC_MAX,
+	};
+
+	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &cb_ctx, 0);
+}
+
+SEC("struct_ops/bpf_fq_reset")
+__auxiliary
+void BPF_PROG(bpf_fq_reset, struct Qdisc *sch)
+{
+	struct unset_throttled_flows_ctx utf_ctx = {
+		.unset_all = true,
+	};
+	struct remove_flows_ctx rf_ctx = {
+		.gc_only = false,
+		.reset_cnt = 0,
+		.reset_max = NUM_QUEUE,
+	};
+	struct fq_stashed_flow *sflow;
+	u64 hash = 0;
+
+	sch->q.qlen = 0;
+	sch->qstats.backlog = 0;
+
+	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &rf_ctx, 0);
+
+	rf_ctx.reset_cnt = 0;
+	bpf_for_each_map_elem(&fq_prio_flows, fq_remove_flows, &rf_ctx, 0);
+	fq_new_flow(&fq_prio_flows, &sflow, hash);
+
+	bpf_loop(NUM_QUEUE, fq_remove_flows_in_list, NULL, 0);
+	q.new_flow_cnt = 0;
+	q.old_flow_cnt = 0;
+
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &utf_ctx, 0);
+}
+
+SEC("struct_ops/bpf_fq_init")
+__auxiliary
+int BPF_PROG(bpf_fq_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = sch->dev_queue->dev;
+	u32 psched_mtu = dev->mtu + dev->hard_header_len;
+	struct fq_stashed_flow *sflow;
+	u64 hash = 0;
+
+	if (fq_new_flow(&fq_prio_flows, &sflow, hash) < 0)
+		return -ENOMEM;
+
+	sch->limit = 10000;
+	q.initial_quantum = 10 * psched_mtu;
+	q.quantum = 2 * psched_mtu;
+	q.flow_refill_delay = 40;
+	q.flow_plimit = 100;
+	q.horizon = 10ULL * NSEC_PER_SEC;
+	q.horizon_drop = 1;
+	q.orphan_mask = 1024 - 1;
+	q.timer_slack = 10 * NSEC_PER_USEC;
+	q.time_next_delayed_flow = ~0ULL;
+	q.unthrottle_latency_ns = 0ULL;
+	q.new_flow_cnt = 0;
+	q.old_flow_cnt = 0;
+
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_fq_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fq = {
+	.enqueue   = (void *)bpf_fq_enqueue,
+	.dequeue   = (void *)bpf_fq_dequeue,
+	.reset     = (void *)bpf_fq_reset,
+	.init      = (void *)bpf_fq_init,
+	.destroy   = (void *)bpf_fq_destroy,
+	.id        = "bpf_fq",
+};
diff --git a/tools/testing/selftests/bpf/progs/plain_c_cpumask_success.c b/tools/testing/selftests/bpf/progs/plain_c_cpumask_success.c
new file mode 100644
index 000000000000..fb1032386d99
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_cpumask_success.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+/* cpumask_success.c in plain C */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "cpumask_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid, nr_cpus;
+
+static bool is_test_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
+/* Mask is guaranteed to be large enough for bpf_cpumask_t. */
+#define CPUMASK_TEST_MASKLEN (sizeof(cpumask_t))
+
+/* Add an extra word for the test_populate_reject_unaligned test. */
+u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask;
+	bool bit;
+	int ret;
+	int i;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Set only odd bits. */
+	__builtin_memset(bits, 0xaa, CPUMASK_TEST_MASKLEN);
+
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		err = 1;
+		return 0;
+	}
+
+	/* Pass the entire bits array, the kfunc will only copy the valid bits. */
+	ret = bpf_cpumask_populate(mask, bits, CPUMASK_TEST_MASKLEN);
+	if (ret) {
+		err = 2;
+		goto out;
+	}
+
+	/*
+	 * Test is there to appease the verifier. We cannot directly
+	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
+	 * it from the size of cpumask_t.
+	 */
+	if (nr_cpus < 0 || nr_cpus > CPUMASK_TEST_MASKLEN * 8) {
+		err = 3;
+		goto out;
+	}
+
+	for (i = 0; i < nr_cpus; i++) {
+		/* Odd-numbered bits should be set, even ones unset. */
+		bit = bpf_cpumask_test_cpu(i, (const struct cpumask *)mask);
+		if (bit == (i % 2 != 0))
+			continue;
+
+		err = 4;
+		break;
+	}
+
+out:
+	bpf_cpumask_release(mask);
+
+	return 0;
+}
+
+#undef CPUMASK_TEST_MASKLEN
diff --git a/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c b/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
new file mode 100644
index 000000000000..2c1c4f7c38a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+/* dynptr_success.c in plain C */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+#define PAGE_SIZE_64K 65536
+
+char _license[] SEC("license") = "GPL";
+
+int err;
+
+static inline int bpf_memcmp(const char *a, const char *b, u32 size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (a[i] != b[i])
+			return a[i] < b[i] ? -1 : 1;
+	}
+	return 0;
+}
+
+static int fill_xdp(struct bpf_dynptr *ptr, __u32 start, __u32 n)
+{
+	__u8 b;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		b = (start + i) % 251;
+		if (bpf_dynptr_write(ptr, start + i, &b, 1, 0))
+			return 1;
+	}
+	return 0;
+}
+
+static int check_xdp(struct bpf_dynptr *ptr, __u32 at, __u32 n, __u32 from)
+{
+	__u8 b;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (bpf_dynptr_read(&b, 1, ptr, at + i, 0))
+			return 1;
+		if (b != (__u8)((from + i) % 251))
+			return 1;
+	}
+	return 0;
+}
+
+SEC("?xdp")
+__success
+int test_dynptr_copy_xdp_overlap(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 off = data_end - data - 1000;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, off, 1300)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, off + 100, &ptr, off, 1200);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, off + 100, 1200, off))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+__success
+int test_dynptr_copy_xdp_overlap_src_linear(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 64, 118)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin - 10, &ptr, lin - 64, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin - 10, 64, lin - 64))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+__success
+int test_dynptr_copy_xdp_overlap_dst_frag(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 10, 84)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin + 10, &ptr, lin - 10, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin + 10, 64, lin - 10))
+		err = 2;
+	return XDP_DROP;
+}
+
+#define DYNPTR_MEMSET_VAL 42
+
+#define min_t(type, x, y) ({		\
+	type __x = (x);			\
+	type __y = (y);			\
+	__x < __y ? __x : __y; })
+
+SEC("xdp")
+__success
+int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
+{
+	u32 data_sz, chunk_sz, offset = 0;
+	const int max_chunks = 200;
+	struct bpf_dynptr ptr_xdp;
+	char expected_buf[32];
+	char buf[32];
+	int i;
+
+	__builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, sizeof(expected_buf));
+
+	/* ptr_xdp is backed by non-contiguous memory */
+	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	data_sz = bpf_dynptr_size(&ptr_xdp);
+
+	err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
+	if (err) {
+		/*
+		 * bpf_dynptr_memset() eventually called bpf_xdp_pointer()
+		 * where if data_sz is greater than 0xffff, -EFAULT will be
+		 * returned. For 64K page size, data_sz is greater than
+		 * 64K, so error is expected and let us zero out error and
+		 * return success.
+		 */
+		if (data_sz >= PAGE_SIZE_64K)
+			err = 0;
+		goto out;
+	}
+
+	for (i = 0; i < max_chunks; i++) {
+		offset = i * sizeof(buf);
+		if (offset >= data_sz)
+			goto out;
+		chunk_sz = min_t(u32, sizeof(buf), data_sz - offset);
+		err = bpf_dynptr_read(&buf, chunk_sz, &ptr_xdp, offset, 0);
+		if (err)
+			goto out;
+		err = bpf_memcmp(buf, expected_buf, sizeof(buf));
+		if (err)
+			goto out;
+	}
+out:
+	return XDP_DROP;
+}
diff --git a/tools/testing/selftests/bpf/progs/plain_c_iters.c b/tools/testing/selftests/bpf/progs/plain_c_iters.c
new file mode 100644
index 000000000000..9c639d6423e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_iters.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+/* iters.c in plain C */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_compiler.h"
+
+int my_pid;
+
+#ifdef REAL_TEST
+#define MY_PID_GUARD() if (my_pid != (bpf_get_current_pid_tgid() >> 32)) return 0
+#else
+#define MY_PID_GUARD() ({ })
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1000);
+} hash_map SEC(".maps");
+
+SEC("?raw_tp")
+__failure
+__msg("invalid mem access 'map_value_or_null'")
+int iter_err_too_permissive2(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+
+	MY_PID_GUARD();
+
+	map_val = bpf_map_lookup_elem(&hash_map, &key);
+	if (!map_val)
+		return 0;
+
+	for (int i = 0; i < 1000000; i++) {
+		map_val = bpf_map_lookup_elem(&hash_map, &key);
+	}
+
+	*map_val = 123;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure
+__msg("invalid mem access 'map_value_or_null'")
+int iter_err_too_permissive3(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+	bool found = false;
+
+	MY_PID_GUARD();
+
+	for (int i = 0; i < 1000000; i++) {
+		map_val = bpf_map_lookup_elem(&hash_map, &key);
+		found = true;
+	}
+
+	if (found)
+		*map_val = 123;
+
+	return 0;
+}
+
+__u32 upper, select_n, result;
+__u64 global;
+
+static __noinline bool nest_2(char *str)
+{
+	/*
+	 * some insns (including branch insns) to ensure stacksafe() is triggered
+	 * in nest_2(). This way, stacksafe() can compare frame associated with nest_1().
+	 */
+	if (str[0] == 't')
+		return true;
+	if (str[1] == 'e')
+		return true;
+	if (str[2] == 's')
+		return true;
+	if (str[3] == 't')
+		return true;
+	return false;
+}
+
+static __noinline bool nest_1(int n)
+{
+	/* case 0: allocate stack, case 1: no allocate stack */
+	switch (n) {
+	case 0: {
+		char comm[16];
+
+		if (bpf_get_current_comm(comm, 16))
+			return false;
+		return nest_2(comm);
+	}
+	case 1:
+		return nest_2((char *)&global);
+	default:
+		return false;
+	}
+}
+
+SEC("raw_tp")
+__success __retval(0)
+int iter_subprog_check_stacksafe(const void *ctx)
+{
+	long i;
+
+	for (i = 0; i < upper; i++) {
+		if (!nest_1(select_n)) {
+			result = 1;
+			return 0;
+		}
+	}
+
+	result = 2;
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int clean_live_states(const void *ctx)
+{
+	char buf[1];
+	int i, j, k, l, m, n, o;
+
+	for (i = 0; i < 10; i++)
+	for (j = 0; j < 10; j++)
+	for (k = 0; k < 10; k++)
+	for (l = 0; l < 10; l++)
+	for (m = 0; m < 10; m++)
+	for (n = 0; n < 10; n++)
+	for (o = 0; o < 10; o++) {
+		if (unlikely(bpf_get_prandom_u32()))
+			buf[0] = 42;
+		bpf_printk("%s", buf);
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/plain_c_mem_rdonly_untrusted.c
new file mode 100644
index 000000000000..7e94b575e5eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_mem_rdonly_untrusted.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* mem_rdonly_untrusted.c in plain C */
+
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+SEC("socket")
+__success
+int offset_not_tracked(void *ctx)
+{
+	int *p, i, s;
+
+	p = bpf_rdonly_cast(0, 0);
+	s = 0;
+	for (i = 0; i < 1000 * 1000 * 1000; i++) {
+		p++;
+		s += *p;
+	}
+	return s;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_mptcp_subflow.c b/tools/testing/selftests/bpf/progs/plain_c_mptcp_subflow.c
new file mode 100644
index 000000000000..b1d0cdedc534
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_mptcp_subflow.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2024, Kylin Software */
+/* mptcp_subflow.c and mptcp_bpf.h in plain C */
+
+#include "bpf_tracing_net.h"
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+/* list helpers from include/linux/list.h */
+static inline int list_is_head(const struct list_head *list,
+			       const struct list_head *head)
+{
+	return list == head;
+}
+
+#define list_entry(ptr, type, member)					\
+	container_of(ptr, type, member)
+
+#define list_first_entry(ptr, type, member)				\
+	list_entry((ptr)->next, type, member)
+
+#define list_next_entry(pos, member)					\
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+/* mptcp helpers from protocol.h */
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+
+static struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
+
+char _license[] SEC("license") = "GPL";
+
+char cc[TCP_CA_NAME_MAX] = "reno";
+int pid;
+
+static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i) {
+			ctx->retval = -2;
+			break;
+		}
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if (ssk->sk_mark == 2 &&
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) {
+			ctx->retval = -2;
+			break;
+		}
+	}
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+__success
+int _getsockopt_subflow(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	struct mptcp_sock *msk;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    (!(ctx->level == SOL_SOCKET && ctx->optname == SO_MARK) &&
+	     !(ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)))
+		return 1;
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.extra_subflows != 1) {
+		ctx->retval = -1;
+		return 1;
+	}
+
+	if (ctx->optname == SO_MARK)
+		return _check_getsockopt_subflow_mark(msk, ctx);
+	return _check_getsockopt_subflow_cc(msk, ctx);
+}
diff --git a/tools/testing/selftests/bpf/progs/plain_c_rbtree_search.c b/tools/testing/selftests/bpf/progs/plain_c_rbtree_search.c
new file mode 100644
index 000000000000..d3bfbde6f90e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_rbtree_search.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+/* rbtree_search.c in plain C */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	struct bpf_refcount ref;
+	struct bpf_rb_node r0;
+	struct bpf_rb_node r1;
+	int key0;
+	int key1;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_spin_lock glock0;
+private(A) struct bpf_rb_root groot0 __contains(node_data, r0);
+
+private(B) struct bpf_spin_lock glock1;
+private(B) struct bpf_rb_root groot1 __contains(node_data, r1);
+
+#define rb_entry(ptr, type, member) container_of(ptr, type, member)
+#define NR_NODES 16
+
+static bool less0(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = rb_entry(a, struct node_data, r0);
+	node_b = rb_entry(b, struct node_data, r0);
+
+	return node_a->key0 < node_b->key0;
+}
+
+static bool less1(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = rb_entry(a, struct node_data, r1);
+	node_b = rb_entry(b, struct node_data, r1);
+
+	return node_a->key1 < node_b->key1;
+}
+
+SEC("syscall")
+__success __retval(0)
+#ifndef __clang__
+__skip("GCC walks the array on the stack with a pointer")
+#endif
+long rbtree_search(void *ctx)
+{
+	struct bpf_rb_node *rb_n, *rb_m, *gc_ns[NR_NODES];
+	long lookup_key = NR_NODES / 2;
+	struct node_data *n, *m;
+	int i, nr_gc = 0;
+
+	for (i = 0; i < NR_NODES; i++) {
+		n = bpf_obj_new(typeof(*n));
+		if (!n)
+			return __LINE__;
+
+		m = bpf_refcount_acquire(n);
+
+		n->key0 = i;
+		m->key1 = i;
+
+		bpf_spin_lock(&glock0);
+		bpf_rbtree_add(&groot0, &n->r0, less0);
+		bpf_spin_unlock(&glock0);
+
+		bpf_spin_lock(&glock1);
+		bpf_rbtree_add(&groot1, &m->r1, less1);
+		bpf_spin_unlock(&glock1);
+	}
+
+	n = NULL;
+	bpf_spin_lock(&glock0);
+	rb_n = bpf_rbtree_root(&groot0);
+	while (1) {
+		if (!rb_n) {
+			bpf_spin_unlock(&glock0);
+			return __LINE__;
+		}
+
+		n = rb_entry(rb_n, struct node_data, r0);
+		if (lookup_key == n->key0)
+			break;
+		if (nr_gc < NR_NODES)
+			gc_ns[nr_gc++] = rb_n;
+		if (lookup_key < n->key0)
+			rb_n = bpf_rbtree_left(&groot0, rb_n);
+		else
+			rb_n = bpf_rbtree_right(&groot0, rb_n);
+	}
+
+	if (!n || lookup_key != n->key0) {
+		bpf_spin_unlock(&glock0);
+		return __LINE__;
+	}
+
+	for (i = 0; i < nr_gc; i++) {
+		rb_n = gc_ns[i];
+		gc_ns[i] = bpf_rbtree_remove(&groot0, rb_n);
+	}
+
+	m = bpf_refcount_acquire(n);
+	bpf_spin_unlock(&glock0);
+
+	for (i = 0; i < nr_gc; i++) {
+		rb_n = gc_ns[i];
+		if (rb_n) {
+			n = rb_entry(rb_n, struct node_data, r0);
+			bpf_obj_drop(n);
+		}
+	}
+
+	if (!m)
+		return __LINE__;
+
+	bpf_spin_lock(&glock1);
+	rb_m = bpf_rbtree_remove(&groot1, &m->r1);
+	bpf_spin_unlock(&glock1);
+	bpf_obj_drop(m);
+	if (!rb_m)
+		return __LINE__;
+	bpf_obj_drop(rb_entry(rb_m, struct node_data, r1));
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_rbtree_search_kptr.c b/tools/testing/selftests/bpf/progs/plain_c_rbtree_search_kptr.c
new file mode 100644
index 000000000000..5808d873fedd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_rbtree_search_kptr.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+/* rbtree_search_kptr.c in plain C */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define NR_NODES 16
+
+struct node_data {
+	int data;
+};
+
+struct tree_node {
+	struct bpf_rb_node node;
+	u64 key;
+	struct node_data __kptr * node_data;
+};
+
+struct tree_node_ref {
+	struct bpf_refcount ref;
+	struct bpf_rb_node node;
+	u64 key;
+	struct node_data __kptr * node_data;
+};
+
+#define private(name) SEC(".data." #name) __hidden __aligned(8)
+
+private(A) struct bpf_rb_root root __contains(tree_node, node);
+private(A) struct bpf_spin_lock lock;
+
+private(B) struct bpf_rb_root root_r __contains(tree_node_ref, node);
+private(B) struct bpf_spin_lock lock_r;
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct tree_node *node_a, *node_b;
+
+	node_a = container_of(a, struct tree_node, node);
+	node_b = container_of(b, struct tree_node, node);
+
+	return node_a->key < node_b->key;
+}
+
+SEC("syscall")
+__success __retval(0)
+#ifndef __clang__
+__skip("GCC's layout: the may_goto that the verifier adds leaves the loop with a reference")
+#endif
+long rbtree_search_kptr(void *ctx)
+{
+	struct tree_node *tnode;
+	struct bpf_rb_node *rb_n;
+	struct node_data __kptr * node_data;
+	int lookup_key  = NR_NODES / 2;
+	int lookup_data = NR_NODES / 2;
+	int i, data, ret = 0;
+
+	for (i = 0; i < NR_NODES; i++) {
+		tnode = bpf_obj_new(typeof(*tnode));
+		if (!tnode)
+			return __LINE__;
+
+		node_data = bpf_obj_new(typeof(*node_data));
+		if (!node_data) {
+			bpf_obj_drop(tnode);
+			return __LINE__;
+		}
+
+		tnode->key = i;
+		node_data->data = i;
+
+		node_data = bpf_kptr_xchg(&tnode->node_data, node_data);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		bpf_spin_lock(&lock);
+		bpf_rbtree_add(&root, &tnode->node, less);
+		bpf_spin_unlock(&lock);
+	}
+
+	bpf_spin_lock(&lock);
+	rb_n = bpf_rbtree_root(&root);
+	while (rb_n) {
+		tnode = container_of(rb_n, struct tree_node, node);
+		node_data = bpf_kptr_xchg(&tnode->node_data, NULL);
+		if (!node_data) {
+			ret = __LINE__;
+			goto fail;
+		}
+
+		data = node_data->data;
+		node_data = bpf_kptr_xchg(&tnode->node_data, node_data);
+		if (node_data) {
+			bpf_spin_unlock(&lock);
+			bpf_obj_drop(node_data);
+			return __LINE__;
+		}
+
+		if (lookup_key == tnode->key) {
+			if (data == lookup_data)
+				break;
+
+			ret = __LINE__;
+			goto fail;
+		}
+
+		if (lookup_key < tnode->key)
+			rb_n = bpf_rbtree_left(&root, rb_n);
+		else
+			rb_n = bpf_rbtree_right(&root, rb_n);
+	}
+	bpf_spin_unlock(&lock);
+
+	while (1) {
+		bpf_spin_lock(&lock);
+		rb_n = bpf_rbtree_first(&root);
+		if (!rb_n) {
+			bpf_spin_unlock(&lock);
+			return 0;
+		}
+
+		rb_n = bpf_rbtree_remove(&root, rb_n);
+		if (!rb_n) {
+			ret = __LINE__;
+			goto fail;
+		}
+		bpf_spin_unlock(&lock);
+
+		tnode = container_of(rb_n, struct tree_node, node);
+
+		node_data = bpf_kptr_xchg(&tnode->node_data, NULL);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		bpf_obj_drop(tnode);
+	}
+
+	return 0;
+fail:
+	bpf_spin_unlock(&lock);
+	return ret;
+}
+
+static bool less_r(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct tree_node_ref *node_a, *node_b;
+
+	node_a = container_of(a, struct tree_node_ref, node);
+	node_b = container_of(b, struct tree_node_ref, node);
+
+	return node_a->key < node_b->key;
+}
+
+SEC("syscall")
+__success __retval(0)
+#ifndef __clang__
+__skip("GCC's layout: the may_goto that the verifier adds leaves the loop with a reference")
+#endif
+long rbtree_search_kptr_ref(void *ctx)
+{
+	struct tree_node_ref *tnode_r, *tnode_m;
+	struct bpf_rb_node *rb_n;
+	struct node_data __kptr * node_data;
+	int lookup_key  = NR_NODES / 2;
+	int lookup_data = NR_NODES / 2;
+	int i, data, ret = 0;
+
+	for (i = 0; i < NR_NODES; i++) {
+		tnode_r = bpf_obj_new(typeof(*tnode_r));
+		if (!tnode_r)
+			return __LINE__;
+
+		node_data = bpf_obj_new(typeof(*node_data));
+		if (!node_data) {
+			bpf_obj_drop(tnode_r);
+			return __LINE__;
+		}
+
+		tnode_r->key = i;
+		node_data->data = i;
+
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, node_data);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		/* Unused reference */
+		tnode_m = bpf_refcount_acquire(tnode_r);
+		if (!tnode_m)
+			return __LINE__;
+
+		bpf_spin_lock(&lock_r);
+		bpf_rbtree_add(&root_r, &tnode_r->node, less_r);
+		bpf_spin_unlock(&lock_r);
+
+		bpf_obj_drop(tnode_m);
+	}
+
+	bpf_spin_lock(&lock_r);
+	rb_n = bpf_rbtree_root(&root_r);
+	while (rb_n) {
+		tnode_r = container_of(rb_n, struct tree_node_ref, node);
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, NULL);
+		if (!node_data) {
+			ret = __LINE__;
+			goto fail;
+		}
+
+		data = node_data->data;
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, node_data);
+		if (node_data) {
+			bpf_spin_unlock(&lock_r);
+			bpf_obj_drop(node_data);
+			return __LINE__;
+		}
+
+		if (lookup_key == tnode_r->key) {
+			if (data == lookup_data)
+				break;
+
+			ret = __LINE__;
+			goto fail;
+		}
+
+		if (lookup_key < tnode_r->key)
+			rb_n = bpf_rbtree_left(&root_r, rb_n);
+		else
+			rb_n = bpf_rbtree_right(&root_r, rb_n);
+	}
+	bpf_spin_unlock(&lock_r);
+
+	while (1) {
+		bpf_spin_lock(&lock_r);
+		rb_n = bpf_rbtree_first(&root_r);
+		if (!rb_n) {
+			bpf_spin_unlock(&lock_r);
+			return 0;
+		}
+
+		rb_n = bpf_rbtree_remove(&root_r, rb_n);
+		if (!rb_n) {
+			ret = __LINE__;
+			goto fail;
+		}
+		bpf_spin_unlock(&lock_r);
+
+		tnode_r = container_of(rb_n, struct tree_node_ref, node);
+
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, NULL);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		bpf_obj_drop(tnode_r);
+	}
+
+	return 0;
+fail:
+	bpf_spin_unlock(&lock_r);
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c b/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
new file mode 100644
index 000000000000..b4f53c42e098
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+// Copyright (c) 2019 Facebook
+/* strobemeta_bpf_loop.c and strobemeta.h in plain C */
+
+#define STROBE_MAX_INTS 2
+#define STROBE_MAX_STRS 25
+#define STROBE_MAX_MAPS 100
+#define STROBE_MAX_MAP_ENTRIES 20
+
+#include <stdint.h>
+#include <stddef.h>
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_compiler.h"
+#include "bpf_misc.h"
+
+#ifdef __clang__
+
+typedef uint32_t pid_t;
+struct task_struct {};
+
+#define TASK_COMM_LEN 16
+#define PERF_MAX_STACK_DEPTH 127
+
+#define STACK_TABLE_EPOCH_SHIFT 20
+#define STROBE_MAX_STR_LEN 1
+#define STROBE_MAX_CFGS 32
+#define READ_MAP_VAR_PAYLOAD_CAP					\
+	((1 + STROBE_MAX_MAP_ENTRIES * 2) * STROBE_MAX_STR_LEN)
+#define STROBE_MAX_PAYLOAD						\
+	(STROBE_MAX_STRS * STROBE_MAX_STR_LEN +				\
+	 STROBE_MAX_MAPS * READ_MAP_VAR_PAYLOAD_CAP)
+
+struct strobe_value_header {
+	/*
+	 * meaning depends on type:
+	 * 1. int: 0, if value not set, 1 otherwise
+	 * 2. str: 1 always, whether value is set or not is determined by ptr
+	 * 3. map: 1 always, pointer points to additional struct with number
+	 *    of entries (up to STROBE_MAX_MAP_ENTRIES)
+	 */
+	uint16_t len;
+	/*
+	 * _reserved might be used for some future fields/flags, but we always
+	 * want to keep strobe_value_header to be 8 bytes, so BPF can read 16
+	 * bytes in one go and get both header and value
+	 */
+	uint8_t _reserved[6];
+};
+
+/*
+ * strobe_value_generic is used from BPF probe only, but needs to be a union
+ * of strobe_value_int/strobe_value_str/strobe_value_map
+ */
+struct strobe_value_generic {
+	struct strobe_value_header header;
+	union {
+		int64_t val;
+		void *ptr;
+	};
+};
+
+struct strobe_map_entry {
+	const char* key;
+	const char* val;
+};
+
+/*
+ * Map of C-string key/value pairs with fixed maximum capacity. Each map has
+ * corresponding int64 ID, which application can use (or ignore) in whatever
+ * way appropriate. Map is "write-only", there is no way to get data out of
+ * map. Map is intended to be used to provide metadata for profilers and is
+ * not to be used for internal in-app communication. All methods are
+ * thread-safe.
+ */
+struct strobe_map_raw {
+	/*
+	 * general purpose unique ID that's up to application to decide
+	 * whether and how to use; for request metadata use case id is unique
+	 * request ID that's used to match metadata with stack traces on
+	 * Strobelight backend side
+	 */
+	int64_t id;
+	/* number of used entries in map */
+	int64_t cnt;
+	/*
+	 * having volatile doesn't change anything on BPF side, but clang
+	 * emits warnings for passing `volatile const char *` into
+	 * bpf_probe_read_user_str that expects just `const char *`
+	 */
+	const char* tag;
+	/*
+	 * key/value entries, each consisting of 2 pointers to key and value
+	 * C strings
+	 */
+	struct strobe_map_entry entries[STROBE_MAX_MAP_ENTRIES];
+};
+
+#define TLS_LOCAL_EXEC 0
+
+/*
+ * structure that universally represents TLS location (both for static
+ * executables and shared libraries)
+ */
+struct strobe_value_loc {
+	/*
+	 * tls_mode defines what TLS mode was used for particular metavariable:
+	 * - -1 (TLS_NOT_SET) - no metavariable;
+	 * - 0 (TLS_LOCAL_EXEC) - Local Executable mode;
+	 * - 1 (TLS_IMM_EXEC) - Immediate Executable mode;
+	 * - 2 (TLS_GENERAL_DYN) - General Dynamic mode;
+	 * Local Dynamic mode is not yet supported, because never seen in
+	 * practice.  Mode defines how offset field is interpreted. See
+	 * calc_location() in below for details.
+	 */
+	int64_t tls_mode;
+	/*
+	 * TLS_LOCAL_EXEC: offset from thread pointer (fs:0 for x86-64,
+	 * tpidr_el0 for aarch64).
+	 * TLS_IMM_EXEC: absolute address of GOT entry containing offset
+	 * from thread pointer;
+	 * TLS_GENERAL_DYN: absolute address of double GOT entry
+	 * containing tls_index_t struct;
+	 */
+	int64_t offset;
+};
+
+struct strobemeta_cfg {
+	int64_t req_meta_idx;
+	struct strobe_value_loc int_locs[STROBE_MAX_INTS];
+	struct strobe_value_loc str_locs[STROBE_MAX_STRS];
+	struct strobe_value_loc map_locs[STROBE_MAX_MAPS];
+};
+
+struct strobe_map_descr {
+	uint64_t id;
+	int16_t tag_len;
+	/*
+	 * cnt <0 - map value isn't set;
+	 * 0 - map has id set, but no key/value entries
+	 */
+	int16_t cnt;
+	/*
+	 * both key_lens[i] and val_lens[i] should be >0 for present key/value
+	 * entry
+	 */
+	uint16_t key_lens[STROBE_MAX_MAP_ENTRIES];
+	uint16_t val_lens[STROBE_MAX_MAP_ENTRIES];
+};
+
+struct strobemeta_payload {
+	/* req_id has valid request ID, if req_meta_valid == 1 */
+	int64_t req_id;
+	uint8_t req_meta_valid;
+	/*
+	 * mask has Nth bit set to 1, if Nth metavar was present and
+	 * successfully read
+	 */
+	uint64_t int_vals_set_mask;
+	int64_t int_vals[STROBE_MAX_INTS];
+	/* len is >0 for present values */
+	uint16_t str_lens[STROBE_MAX_STRS];
+	/* if map_descrs[i].cnt == -1, metavar is not present/set */
+	struct strobe_map_descr map_descrs[STROBE_MAX_MAPS];
+	/*
+	 * payload has compactly packed values of str and map variables in the
+	 * form: strval1\0strval2\0map1key1\0map1val1\0map2key1\0map2val1\0
+	 * (and so on); str_lens[i], key_lens[i] and val_lens[i] determines
+	 * value length
+	 */
+	char payload[STROBE_MAX_PAYLOAD];
+};
+
+struct strobelight_bpf_sample {
+	uint64_t ktime;
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	int user_stack_id;
+	int kernel_stack_id;
+	int has_meta;
+	struct strobemeta_payload metadata;
+	/*
+	 * makes it possible to pass (<real payload size> + 1) as data size to
+	 * perf_submit() to avoid perf_submit's paranoia about passing zero as
+	 * size, as it deduces that <real payload size> might be
+	 * **theoretically** zero
+	 */
+	char dummy_safeguard;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, 32);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} samples SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint64_t) * PERF_MAX_STACK_DEPTH);
+} stacks_0 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint64_t) * PERF_MAX_STACK_DEPTH);
+} stacks_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, uint32_t);
+	__type(value, struct strobelight_bpf_sample);
+} sample_heap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, STROBE_MAX_CFGS);
+	__type(key, pid_t);
+	__type(value, struct strobemeta_cfg);
+} strobemeta_cfgs SEC(".maps");
+
+/* Type for the dtv.  */
+/* https://github.com/lattera/glibc/blob/master/nptl/sysdeps/x86_64/tls.h#L34 */
+typedef union dtv {
+	size_t counter;
+	struct {
+		void* val;
+		bool is_static;
+	} pointer;
+} dtv_t;
+
+/* Partial definition for tcbhead_t */
+/* https://github.com/bminor/glibc/blob/master/sysdeps/x86_64/nptl/tls.h#L42 */
+struct tcbhead {
+	void* tcb;
+	dtv_t* dtv;
+};
+
+/*
+ * TLS module/offset information for shared library case.
+ * For x86-64, this is mapped onto two entries in GOT.
+ * For aarch64, this is pointed to by second GOT entry.
+ */
+struct tls_index {
+	uint64_t module;
+	uint64_t offset;
+};
+
+static void *calc_location(struct strobe_value_loc *loc, void *tls_base)
+{
+	/*
+	 * tls_mode value is:
+	 * - -1 (TLS_NOT_SET), if no metavar is present;
+	 * - 0 (TLS_LOCAL_EXEC), if metavar uses Local Executable mode of TLS
+	 * (offset from fs:0 for x86-64 or tpidr_el0 for aarch64);
+	 * - 1 (TLS_IMM_EXEC), if metavar uses Immediate Executable mode of TLS;
+	 * - 2 (TLS_GENERAL_DYN), if metavar uses General Dynamic mode of TLS;
+	 * This schema allows to use something like:
+	 * (tls_mode + 1) * (tls_base + offset)
+	 * to get NULL for "no metavar" location, or correct pointer for local
+	 * executable mode without doing extra ifs.
+	 */
+	if (loc->tls_mode <= TLS_LOCAL_EXEC) {
+		/*
+		 * static executable is simple, we just have offset from
+		 * tls_base
+		 */
+		void *addr = tls_base + loc->offset;
+		/*
+		 * multiply by (tls_mode + 1) to get NULL, if we have no
+		 * metavar in this slot
+		 */
+		return (void *)((loc->tls_mode + 1) * (int64_t)addr);
+	}
+	/*
+	 * Other modes are more complicated, we need to jump through few hoops.
+	 *
+	 * For immediate executable mode (currently supported only for aarch64):
+	 *  - loc->offset is pointing to a GOT entry containing fixed offset
+	 *  relative to tls_base;
+	 *
+	 * For general dynamic mode:
+	 *  - loc->offset is pointing to a beginning of double GOT entries;
+	 *  - (for aarch64 only) second entry points to tls_index_t struct;
+	 *  - (for x86-64 only) two GOT entries are already tls_index_t;
+	 *  - tls_index_t->module is used to find start of TLS section in
+	 *  which variable resides;
+	 *  - tls_index_t->offset provides offset within that TLS section,
+	 *  pointing to value of variable.
+	 */
+	struct tls_index tls_index;
+	dtv_t *dtv;
+	void *tls_ptr;
+
+	bpf_probe_read_user(&tls_index, sizeof(struct tls_index),
+			    (void *)loc->offset);
+	/* valid module index is always positive */
+	if (tls_index.module > 0) {
+		/* dtv = ((struct tcbhead *)tls_base)->dtv[tls_index.module] */
+		bpf_probe_read_user(&dtv, sizeof(dtv),
+				    &((struct tcbhead *)tls_base)->dtv);
+		dtv += tls_index.module;
+	} else {
+		dtv = NULL;
+	}
+	bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
+	/* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
+	if (!tls_ptr || tls_ptr == (void *)-1)
+		return NULL;
+	return tls_ptr + tls_index.offset;
+}
+
+static void read_int_var(struct strobemeta_cfg *cfg,
+			 size_t idx, void *tls_base,
+			 struct strobe_value_generic *value,
+			 struct strobemeta_payload *data)
+{
+	void *location = calc_location(&cfg->int_locs[idx], tls_base);
+	if (!location)
+		return;
+
+	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
+	data->int_vals[idx] = value->val;
+	if (value->header.len)
+		data->int_vals_set_mask |= (1 << idx);
+}
+
+static uint64_t read_str_var(struct strobemeta_cfg *cfg,
+			     size_t idx, void *tls_base,
+			     struct strobe_value_generic *value,
+			     struct strobemeta_payload *data,
+			     size_t off)
+{
+	void *location;
+	uint64_t len;
+
+	data->str_lens[idx] = 0;
+	location = calc_location(&cfg->str_locs[idx], tls_base);
+	if (bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location))
+		return off;
+
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
+	/*
+	 * if bpf_probe_read_user_str returns error (<0), due to casting to
+	 * unsigned int, it will become big number, so next check is
+	 * sufficient to check for errors AND prove to BPF verifier, that
+	 * bpf_probe_read_user_str won't return anything bigger than
+	 * STROBE_MAX_STR_LEN
+	 */
+	if (len > STROBE_MAX_STR_LEN)
+		return off;
+
+	data->str_lens[idx] = len;
+	return off + len;
+}
+
+static uint64_t read_map_var(struct strobemeta_cfg *cfg,
+			     size_t idx, void *tls_base,
+			     struct strobe_value_generic *value,
+			     struct strobemeta_payload *data,
+			     size_t off)
+{
+	struct strobe_map_descr* descr = &data->map_descrs[idx];
+	struct strobe_map_raw map;
+	void *location;
+	uint64_t len;
+
+	descr->tag_len = 0; /* presume no tag is set */
+	descr->cnt = -1; /* presume no value is set */
+
+	location = calc_location(&cfg->map_locs[idx], tls_base);
+	if (unlikely(bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location)))
+		return off;
+
+	if (unlikely(bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr)))
+		return off;
+
+	descr->id = map.id;
+	descr->cnt = map.cnt;
+	if (cfg->req_meta_idx == idx) {
+		data->req_id = map.id;
+		data->req_meta_valid = 1;
+	}
+
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, map.tag);
+	if (len <= STROBE_MAX_STR_LEN) {
+		descr->tag_len = len;
+		off += len;
+	}
+
+	__pragma_loop_unroll
+	for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
+		if (i >= map.cnt)
+			break;
+
+		descr->key_lens[i] = 0;
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
+					      map.entries[i].key);
+		if (len <= STROBE_MAX_STR_LEN) {
+			descr->key_lens[i] = len;
+			off += len;
+		}
+		descr->val_lens[i] = 0;
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
+					      map.entries[i].val);
+		if (len <= STROBE_MAX_STR_LEN) {
+			descr->val_lens[i] = len;
+			off += len;
+		}
+	}
+
+	return off;
+}
+
+enum read_type {
+	READ_INT_VAR,
+	READ_MAP_VAR,
+	READ_STR_VAR,
+};
+
+struct read_var_ctx {
+	struct strobemeta_payload *data;
+	void *tls_base;
+	struct strobemeta_cfg *cfg;
+	size_t payload_off;
+	/* value gets mutated */
+	struct strobe_value_generic *value;
+	enum read_type type;
+};
+
+static int read_var_callback(__u64 index, struct read_var_ctx *ctx)
+{
+	switch (ctx->type) {
+	case READ_INT_VAR:
+		if (index >= STROBE_MAX_INTS)
+			return 1;
+		read_int_var(ctx->cfg, index, ctx->tls_base, ctx->value, ctx->data);
+		break;
+	case READ_MAP_VAR:
+		if (index >= STROBE_MAX_MAPS)
+			return 1;
+		if (ctx->payload_off > sizeof(ctx->data->payload) - READ_MAP_VAR_PAYLOAD_CAP)
+			return 1;
+		ctx->payload_off = read_map_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
+		break;
+	case READ_STR_VAR:
+		if (index >= STROBE_MAX_STRS)
+			return 1;
+		if (ctx->payload_off > sizeof(ctx->data->payload) - STROBE_MAX_STR_LEN)
+			return 1;
+		ctx->payload_off = read_str_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
+		break;
+	}
+	return 0;
+}
+
+/*
+ * read_strobe_meta returns NULL, if no metadata was read; otherwise returns
+ * pointer to *right after* payload ends
+ */
+static void *read_strobe_meta(struct task_struct *task,
+			      struct strobemeta_payload *data)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	struct strobe_value_generic value = {0};
+	struct strobemeta_cfg *cfg;
+	size_t payload_off;
+	void *tls_base;
+
+	cfg = bpf_map_lookup_elem(&strobemeta_cfgs, &pid);
+	if (!cfg)
+		return NULL;
+
+	data->int_vals_set_mask = 0;
+	data->req_meta_valid = 0;
+	payload_off = 0;
+	/*
+	 * we don't have struct task_struct definition, it should be:
+	 * tls_base = (void *)task->thread.fsbase;
+	 */
+	tls_base = (void *)task;
+
+	struct read_var_ctx ctx = {
+		.cfg = cfg,
+		.tls_base = tls_base,
+		.value = &value,
+		.data = data,
+		.payload_off = 0,
+	};
+	int err;
+
+	ctx.type = READ_INT_VAR;
+	err = bpf_loop(STROBE_MAX_INTS, read_var_callback, &ctx, 0);
+	if (err != STROBE_MAX_INTS)
+		return NULL;
+
+	ctx.type = READ_STR_VAR;
+	err = bpf_loop(STROBE_MAX_STRS, read_var_callback, &ctx, 0);
+	if (err != STROBE_MAX_STRS)
+		return NULL;
+
+	ctx.type = READ_MAP_VAR;
+	err = bpf_loop(STROBE_MAX_MAPS, read_var_callback, &ctx, 0);
+	if (err != STROBE_MAX_MAPS)
+		return NULL;
+
+	payload_off = ctx.payload_off;
+	/* this should not really happen, here only to satisfy verifier */
+	if (payload_off > sizeof(data->payload))
+		payload_off = sizeof(data->payload);
+
+	/*
+	 * return pointer right after end of payload, so it's possible to
+	 * calculate exact amount of useful data that needs to be sent
+	 */
+	return &data->payload[payload_off];
+}
+
+SEC("raw_tracepoint/kfree_skb")
+__success
+int on_event(struct pt_regs *ctx) {
+	pid_t pid =  bpf_get_current_pid_tgid() >> 32;
+	struct strobelight_bpf_sample* sample;
+	struct task_struct *task;
+	uint32_t zero = 0;
+	uint64_t ktime_ns;
+	void *sample_end;
+
+	sample = bpf_map_lookup_elem(&sample_heap, &zero);
+	if (!sample)
+		return 0; /* this will never happen */
+
+	sample->pid = pid;
+	bpf_get_current_comm(&sample->comm, TASK_COMM_LEN);
+	ktime_ns = bpf_ktime_get_ns();
+	sample->ktime = ktime_ns;
+
+	task = (struct task_struct *)bpf_get_current_task();
+	sample_end = read_strobe_meta(task, &sample->metadata);
+	sample->has_meta = sample_end != NULL;
+	sample_end = sample_end ? : &sample->metadata;
+
+	if ((ktime_ns >> STACK_TABLE_EPOCH_SHIFT) & 1) {
+		sample->kernel_stack_id = bpf_get_stackid(ctx, &stacks_1, 0);
+		sample->user_stack_id = bpf_get_stackid(ctx, &stacks_1, BPF_F_USER_STACK);
+	} else {
+		sample->kernel_stack_id = bpf_get_stackid(ctx, &stacks_0, 0);
+		sample->user_stack_id = bpf_get_stackid(ctx, &stacks_0, BPF_F_USER_STACK);
+	}
+
+	uint64_t sample_size = sample_end - (void *)sample;
+	/* should always be true */
+	if (sample_size < sizeof(struct strobelight_bpf_sample))
+		bpf_perf_event_output(ctx, &samples, 0, sample, 1 + sample_size);
+	return 0;
+}
+
+#else
+
+SEC("socket")
+__description("GCC refuses a function with six arguments, use a dummy test")
+__skip("GCC refuses a function with six arguments")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf2.c b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf2.c
new file mode 100644
index 000000000000..b7b1a43aa94e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf2.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* tailcall_bpf2bpf2.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	int ret = 1;
+
+	if (load_byte(skb, 0))
+		bpf_tail_call_static(skb, &jmp_table, 1);
+	else
+		bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+int count = 0;
+
+SEC("tc")
+__success __retval(1)
+#ifndef __clang__
+__skip("GCC does not keep the skb in R6 for LD_ABS")
+#endif
+int classifier_0(struct __sk_buff *skb)
+{
+	count++;
+	return subprog_tail(skb);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy1.c
new file mode 100644
index 000000000000..a66c972a91ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy1.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/* tailcall_bpf2bpf_hierarchy1.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+#include "bpf_test_utils.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+__success __retval(1)
+int entry(struct __sk_buff *skb)
+{
+	int ret = 1, ret1, ret2;
+
+	clobber_regs_stack();
+
+	count++;
+	ret1 = subprog_tail(skb);
+	ret2 = subprog_tail(skb);
+	__sink(ret1);
+	__sink(ret2);
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy2.c
new file mode 100644
index 000000000000..443dbe042de4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy2.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* tailcall_bpf2bpf_hierarchy2.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+int classifier_0(struct __sk_buff *skb);
+int classifier_1(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+		[1] = (void *) &classifier_1,
+	},
+};
+
+int count0 = 0;
+int count1 = 0;
+
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+__auxiliary
+int classifier_0(struct __sk_buff *skb)
+{
+	count0++;
+	subprog_tail0(skb);
+	return 0;
+}
+
+static __noinline
+int subprog_tail1(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 1);
+	return ret;
+}
+
+SEC("tc")
+__auxiliary
+int classifier_1(struct __sk_buff *skb)
+{
+	int ret;
+
+	count1++;
+	ret = subprog_tail1(skb);
+	__sink(ret);
+	return 0;
+}
+
+SEC("tc")
+__success __retval(33)
+int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
+{
+	int ret = 0, ret1, ret2;
+
+	clobber_regs_stack();
+
+	ret1 = subprog_tail0(skb);
+	ret2 = subprog_tail1(skb);
+	__sink(ret1);
+	__sink(ret2);
+	__sink(ret);
+	return (count1 << 16) | count0;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy3.c
new file mode 100644
index 000000000000..3b01c1b037ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy3.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* tailcall_bpf2bpf_hierarchy3.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+int classifier_0(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table0 SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table1 SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb, void *jmp_table)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+__auxiliary
+int classifier_0(struct __sk_buff *skb)
+{
+	int ret1, ret2;
+
+	count++;
+	ret1 = subprog_tail(skb, &jmp_table0);
+	ret2 = subprog_tail(skb, &jmp_table1);
+	__sink(ret1);
+	__sink(ret2);
+	return count;
+}
+
+SEC("tc")
+__success __retval(33)
+#ifndef __clang__
+__skip("GCC does not read 'count' again behind the tail calls")
+#endif
+int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	clobber_regs_stack();
+
+	bpf_tail_call_static(skb, &jmp_table0, 0);
+
+	__sink(ret);
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tailcall_callback.c b/tools/testing/selftests/bpf/progs/plain_c_tailcall_callback.c
new file mode 100644
index 000000000000..1be4843bf0e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tailcall_callback.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* tailcall_callback.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+int classifier_0(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
+
+SEC("tc")
+__auxiliary
+int classifier_0(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+static __noinline
+int callback_loop(int index, void **cb_ctx)
+{
+	int ret;
+
+	ret = subprog_tail0(*cb_ctx);
+	return ret ? 1 : 0;
+}
+
+static __noinline
+int callback_empty(int index, void *data)
+{
+	return 0;
+}
+
+/* callback involving subprog with tail call is rejected */
+SEC("tc")
+__failure
+__msg("cannot tail call within callback")
+int tailcall_callback_1(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_loop(1, callback_loop, &skb, 0);
+	return 0;
+}
+
+/* subprogs with tailcall do not affect no-tailcall callback */
+SEC("tc")
+__success __retval(0)
+int tailcall_callback_2(struct __sk_buff *skb)
+{
+	int ret;
+
+	clobber_regs_stack();
+
+	ret = subprog_tail0(skb);
+	__sink(ret);
+
+	bpf_loop(1, callback_empty, NULL, 0);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c b/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c
new file mode 100644
index 000000000000..751a7157d7d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+/* test_wakeup_source.c in plain C */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "wakeup_source.h"
+
+#define MAX_LOOP_ITER 1000
+#define RB_SIZE (16384 * 4)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RB_SIZE);
+} rb SEC(".maps");
+
+struct bpf_ws_lock;
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void) __ksym;
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock) __ksym;
+void *bpf_wakeup_sources_get_head(void) __ksym;
+
+SEC("syscall")
+__success __retval(0)
+int iterate_wakeupsources(void *ctx)
+{
+	struct list_head *head = bpf_wakeup_sources_get_head();
+	struct list_head *pos = head;
+	struct bpf_ws_lock *lock;
+	int i;
+
+	lock = bpf_wakeup_sources_read_lock();
+	if (!lock)
+		return 0;
+
+	for (i = 0; i < MAX_LOOP_ITER; i++) {
+		if (bpf_core_read(&pos, sizeof(pos), &pos->next) || !pos || pos == head)
+			break;
+
+		struct wakeup_event_t *e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
+
+		if (!e)
+			break;
+
+		struct wakeup_source *ws = bpf_core_cast(
+				(void *)pos - bpf_core_field_offset(struct wakeup_source, entry),
+				struct wakeup_source);
+		s64 active_time = 0;
+		bool active = BPF_CORE_READ_BITFIELD(ws, active);
+		bool autosleep_enable = BPF_CORE_READ_BITFIELD(ws, autosleep_enabled);
+		s64 last_time = ws->last_time;
+		s64 max_time = ws->max_time;
+		s64 prevent_sleep_time = ws->prevent_sleep_time;
+		s64 total_time = ws->total_time;
+
+		if (active) {
+			s64 curr_time = bpf_ktime_get_ns();
+			s64 prevent_time = ws->start_prevent_time;
+
+			if (curr_time > last_time)
+				active_time = curr_time - last_time;
+
+			total_time += active_time;
+			if (active_time > max_time)
+				max_time = active_time;
+			if (autosleep_enable && curr_time > prevent_time)
+				prevent_sleep_time += curr_time - prevent_time;
+		}
+
+		e->active_count = ws->active_count;
+		e->active_time_ns = active_time;
+		e->event_count = ws->event_count;
+		e->expire_count = ws->expire_count;
+		e->last_time_ns = last_time;
+		e->max_time_ns = max_time;
+		e->prevent_sleep_time_ns = prevent_sleep_time;
+		e->total_time_ns = total_time;
+		e->wakeup_count = ws->wakeup_count;
+
+		if (bpf_probe_read_kernel_str(
+				e->name, WAKEUP_NAME_LEN, ws->name) < 0)
+			e->name[0] = '\0';
+
+		bpf_ringbuf_submit(e, 0);
+	}
+
+	bpf_wakeup_sources_read_unlock(lock);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_tracing_stack_arg_tailcall_tgt.c b/tools/testing/selftests/bpf/progs/plain_c_tracing_stack_arg_tailcall_tgt.c
new file mode 100644
index 000000000000..eb521c8ec321
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_tracing_stack_arg_tailcall_tgt.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/* tracing_stack_arg_tailcall_tgt.c in plain C */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__u64 base;
+__u64 ret_stack;
+
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+/* g and h are on the stack, for the x86-64 kernel convention too. */
+static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
+				     __u64 e, __u64 f, __u64 g, __u64 h)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
+}
+
+/* No stack args of its own, so it can share a program with a tail call. */
+static __noinline __u64 call_stack(__u64 x)
+{
+	return callee_stack(x + 1, x + 2, x + 3, x + 4, x + 5, x + 6, x + 7,
+			    x + 8);
+}
+
+#endif
+
+/* Makes the program tail_call_reachable, though callee_stack() is not. */
+static __noinline int subprog_tail(void *ctx)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return ret;
+}
+
+SEC("syscall")
+__success __retval(0) __arch_x86_64 __arch_arm64
+int run(void *ctx)
+{
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+	ret_stack = call_stack(base);
+#endif
+	return subprog_tail(ctx);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_verifier_arena_large.c b/tools/testing/selftests/bpf/progs/plain_c_verifier_arena_large.c
new file mode 100644
index 000000000000..4c5339edb06f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_verifier_arena_large.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+/* verifier_arena_large.c in plain C */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+#define ARENA_SIZE (1ull << 32)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_SIZE / PAGE_SIZE);
+} arena SEC(".maps");
+
+#define PAGE_CNT 100
+__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
+__u8 __arena *base;
+
+/*
+ * Check that arena's range_tree algorithm allocates pages sequentially
+ * on the first pass and then fills in all gaps on the second pass.
+ */
+__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
+		int max_idx, int step)
+{
+	__u8 __arena *pg;
+	int i, pg_idx;
+
+	for (i = 0; i < page_cnt; i++) {
+		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
+					   NUMA_NO_NODE, 0);
+		if (!pg)
+			return step;
+		pg_idx = (unsigned long) (pg - base) / PAGE_SIZE;
+		if (first_pass) {
+			/* Pages must be allocated sequentially */
+			if (pg_idx != i)
+				return step + 100;
+		} else {
+			/* Allocator must fill into gaps */
+			if (pg_idx >= max_idx || (pg_idx & 1))
+				return step + 200;
+		}
+		*pg = pg_idx;
+		page[pg_idx] = pg;
+	}
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0) __skip_without_arena
+int big_alloc2(void *ctx)
+{
+	__u8 __arena *pg;
+	int i, err;
+
+	base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!base)
+		return 1;
+	bpf_arena_free_pages(&arena, (void __arena *)base, 1);
+
+	err = alloc_pages(PAGE_CNT, 1, true, PAGE_CNT, 2);
+	if (err)
+		return err;
+
+	/* Clear all even pages */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 3;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 1);
+		page[i] = NULL;
+	}
+
+	/* Allocate into freed gaps */
+	err = alloc_pages(PAGE_CNT / 2, 1, false, PAGE_CNT, 4);
+	if (err)
+		return err;
+
+	/* Free pairs of pages */
+	for (i = 0; i < PAGE_CNT; i += 4) {
+		pg = page[i];
+		if (*pg != i)
+			return 5;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
+		page[i] = NULL;
+		barrier();
+		page[i + 1] = NULL;
+	}
+
+	/* Allocate 2 pages at a time into freed gaps */
+	err = alloc_pages(PAGE_CNT / 4, 2, false, PAGE_CNT, 6);
+	if (err)
+		return err;
+
+	/* Check pages without freeing */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 7;
+	}
+
+	pg = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+
+	if (!pg)
+		return 8;
+	/*
+	 * The first PAGE_CNT pages are occupied. The new page
+	 * must be above.
+	 */
+	if ((pg - base) / PAGE_SIZE < PAGE_CNT)
+		return 9;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/plain_c_verifier_iterating_callbacks.c
new file mode 100644
index 000000000000..64a50586e9d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_verifier_iterating_callbacks.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* verifier_iterating_callbacks.c in plain C */
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define ARR_SZ 1000000
+char arr[ARR_SZ];
+
+SEC("socket")
+__success __retval(0xd495cdc0)
+int cond_break1(const void *ctx)
+{
+	unsigned long i;
+	unsigned int sum = 0;
+
+	for (i = 0; i < ARR_SZ; i++)
+		sum += i;
+	for (i = 0; i < ARR_SZ; i++) {
+		sum += i + arr[i];
+	}
+
+	return sum;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_verifier_loop_as_is.c b/tools/testing/selftests/bpf/progs/plain_c_verifier_loop_as_is.c
new file mode 100644
index 000000000000..daa05d2b7b57
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_verifier_loop_as_is.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* verifier_loop_as_is.c in plain C */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64[9]);
+} map SEC(".maps");
+
+/* 8 comes back to the head of the inner loop, and goes from there to the head of the outer one */
+SEC("socket")
+__success __retval(0)
+#ifndef __clang__
+__skip("GCC unrolls the inner loop")
+#endif
+int inner_loop_stops_at_8(void *ctx)
+{
+	__u32 key = 0;
+	__u64 n = 0, *v;
+	int i, j;
+
+	v = bpf_map_lookup_elem(&map, &key);
+	if (!v)
+		return 0;
+	for (i = 0; i < 100; i++) {
+		for (j = 0; j < 100; j++) {
+			if (*(volatile __u64 *)v == 1)
+				continue;
+			if (n < 8)
+				v[n++] = 0;
+		}
+	}
+	return v[n];
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/plain_c_xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/plain_c_xdp_lb_bench.c
new file mode 100644
index 000000000000..1499e53f117f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/plain_c_xdp_lb_bench.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/* xdp_lb_bench.c and bench_bpf_timing.bpf.h in plain C */
+
+#include <stddef.h>
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/in.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_compiler.h"
+#include "xdp_lb_bench_common.h"
+#include "bpf_misc.h"
+
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+#ifndef BENCH_NR_SAMPLES
+#define BENCH_NR_SAMPLES	4096
+#endif
+#ifndef BENCH_NR_CPUS
+#define BENCH_NR_CPUS		256
+#endif
+#define BENCH_CPU_MASK		(BENCH_NR_CPUS - 1)
+
+__u64 timing_samples[BENCH_NR_CPUS][BENCH_NR_SAMPLES];
+__u32 timing_idx[BENCH_NR_CPUS];
+
+volatile __u32 batch_iters;
+volatile __u32 timing_enabled;
+
+static void bench_record_sample(__u64 elapsed_ns)
+{
+	__u32 cpu, idx;
+
+	if (!timing_enabled)
+		return;
+
+	cpu = bpf_get_smp_processor_id() & BENCH_CPU_MASK;
+	idx = timing_idx[cpu];
+
+	if (idx >= BENCH_NR_SAMPLES)
+		return;
+
+	timing_samples[cpu][idx] = elapsed_ns;
+	timing_idx[cpu] = idx + 1;
+}
+
+/*
+ * @body:  expression to time; return value (int) stored in __bench_result.
+ * @reset: undo body's side-effects so each iteration starts identically.
+ *         May reference __bench_result.  Use ({}) for empty reset.
+ *
+ * Runs batch_iters timed iterations, then one untimed iteration whose
+ * return value the macro evaluates to (for validation).
+ */
+#define BENCH_BPF_LOOP(body, reset) ({					\
+	__u64 __bench_start = bpf_ktime_get_ns();			\
+	__u32 __bench_i;						\
+	int __bench_result;						\
+									\
+	for (__bench_i = 0;						\
+	     __bench_i < batch_iters;					\
+	     __bench_i++) {						\
+		__bench_result = (body);				\
+		reset;							\
+	}								\
+									\
+	bench_record_sample(bpf_ktime_get_ns() - __bench_start);	\
+									\
+	__bench_result = (body);					\
+	__bench_result;							\
+})
+
+#ifndef IPPROTO_FRAGMENT
+#define IPPROTO_FRAGMENT 44
+#endif
+
+/* jhash helpers */
+
+static inline __u32 rol32(__u32 word, unsigned int shift)
+{
+	return (word << shift) | (word >> ((-shift) & 31));
+}
+
+#define __jhash_mix(a, b, c)			\
+{						\
+	a -= c;  a ^= rol32(c, 4);  c += b;	\
+	b -= a;  b ^= rol32(a, 6);  a += c;	\
+	c -= b;  c ^= rol32(b, 8);  b += a;	\
+	a -= c;  a ^= rol32(c, 16); c += b;	\
+	b -= a;  b ^= rol32(a, 19); a += c;	\
+	c -= b;  c ^= rol32(b, 4);  b += a;	\
+}
+
+#define __jhash_final(a, b, c)			\
+{						\
+	c ^= b; c -= rol32(b, 14);		\
+	a ^= c; a -= rol32(c, 11);		\
+	b ^= a; b -= rol32(a, 25);		\
+	c ^= b; c -= rol32(b, 16);		\
+	a ^= c; a -= rol32(c, 4);		\
+	b ^= a; b -= rol32(a, 14);		\
+	c ^= b; c -= rol32(b, 24);		\
+}
+
+#define JHASH_INITVAL 0xdeadbeef
+
+static inline __u32 __jhash_nwords(__u32 a, __u32 b, __u32 c, __u32 initval)
+{
+	a += initval;
+	b += initval;
+	c += initval;
+	__jhash_final(a, b, c);
+	return c;
+}
+
+static inline __u32 jhash_2words(__u32 a, __u32 b, __u32 initval)
+{
+	return __jhash_nwords(a, b, 0, initval + JHASH_INITVAL + (2 << 2));
+}
+
+static inline __u32 jhash2_4words(const __u32 *k, __u32 initval)
+{
+	__u32 a, b, c;
+
+	a = b = c = JHASH_INITVAL + (4 << 2) + initval;
+
+	a += k[0]; b += k[1]; c += k[2];
+	__jhash_mix(a, b, c);
+
+	a += k[3];
+	__jhash_final(a, b, c);
+
+	return c;
+}
+
+static void ipv4_csum(struct iphdr *iph)
+{
+	__u16 *next_iph = (__u16 *)iph;
+	__u32 csum = 0;
+	int i;
+
+	__pragma_loop_unroll_full
+	for (i = 0; i < (int)(sizeof(*iph) >> 1); i++)
+		csum += *next_iph++;
+
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+	iph->check = ~csum;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, struct vip_definition);
+	__type(value, struct vip_meta);
+} vip_map SEC(".maps");
+
+struct lru_inner_map {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__type(key, struct flow_key);
+	__type(value, struct real_pos_lru);
+	__uint(max_entries, DEFAULT_LRU_SIZE);
+} lru_inner SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, BENCH_NR_CPUS);
+	__array(values, struct lru_inner_map);
+} lru_mapping SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CH_RINGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u32);
+} ch_rings SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, struct real_definition);
+} reals SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, STATS_SIZE);
+	__type(key, __u32);
+	__type(value, struct lb_stats);
+} stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, struct lb_stats);
+} reals_stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct ctl_value);
+} ctl_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct vip_definition);
+} vip_miss_stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, __u32);
+} lru_miss_stats SEC(".maps");
+
+volatile __u32 flow_mask;
+volatile __u32 cold_lru;
+__u32 batch_gen;
+
+/*
+ * old_eth MUST be read BEFORE writing the outer header because
+ * bpf_xdp_adjust_head makes them overlap.
+ */
+static int encap_v4(struct xdp_md *xdp, __be32 saddr, __be32 daddr,
+		    __u16 payload_len, const __u8 *dst_mac)
+{
+	struct ethhdr *new_eth, *old_eth;
+	void *data, *data_end;
+	struct iphdr *iph;
+
+	if (bpf_xdp_adjust_head(xdp, -(int)sizeof(struct iphdr)))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+
+	new_eth = data;
+	iph     = data + sizeof(struct ethhdr);
+	old_eth = data + sizeof(struct iphdr);
+
+	if (new_eth + 1 > data_end || old_eth + 1 > data_end || iph + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, dst_mac, sizeof(new_eth->h_dest));
+	new_eth->h_proto = bpf_htons(ETH_P_IP);
+
+	__builtin_memset(iph, 0, sizeof(*iph));
+	iph->version  = 4;
+	iph->ihl      = sizeof(*iph) >> 2;
+	iph->protocol = IPPROTO_IPIP;
+	iph->tot_len  = bpf_htons(payload_len + sizeof(*iph));
+	iph->ttl      = 64;
+	iph->saddr    = saddr;
+	iph->daddr    = daddr;
+	ipv4_csum(iph);
+
+	return 0;
+}
+
+static int encap_v6(struct xdp_md *xdp, const __be32 saddr[4],
+		    const __be32 daddr[4], __u8 nexthdr, __u16 payload_len,
+		    const __u8 *dst_mac)
+{
+	struct ethhdr *new_eth, *old_eth;
+	void *data, *data_end;
+	struct ipv6hdr *ip6h;
+
+	if (bpf_xdp_adjust_head(xdp, -(int)sizeof(struct ipv6hdr)))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+
+	new_eth = data;
+	ip6h    = data + sizeof(struct ethhdr);
+	old_eth = data + sizeof(struct ipv6hdr);
+
+	if (new_eth + 1 > data_end || old_eth + 1 > data_end || ip6h + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, dst_mac, sizeof(new_eth->h_dest));
+	new_eth->h_proto = bpf_htons(ETH_P_IPV6);
+
+	__builtin_memset(ip6h, 0, sizeof(*ip6h));
+	ip6h->version     = 6;
+	ip6h->nexthdr     = nexthdr;
+	ip6h->payload_len = bpf_htons(payload_len);
+	ip6h->hop_limit   = 64;
+	__builtin_memcpy(&ip6h->saddr, saddr, sizeof(ip6h->saddr));
+	__builtin_memcpy(&ip6h->daddr, daddr, sizeof(ip6h->daddr));
+
+	return 0;
+}
+
+static void update_stats(void *map, __u32 key, __u16 bytes)
+{
+	struct lb_stats *st = bpf_map_lookup_elem(map, &key);
+
+	if (st) {
+		st->v1 += 1;
+		st->v2 += bytes;
+	}
+}
+
+static void count_action(int action)
+{
+	struct lb_stats *st;
+	__u32 key;
+
+	if (action == XDP_TX)
+		key = STATS_XDP_TX;
+	else if (action == XDP_PASS)
+		key = STATS_XDP_PASS;
+	else
+		key = STATS_XDP_DROP;
+
+	st = bpf_map_lookup_elem(&stats, &key);
+	if (st)
+		st->v1 += 1;
+}
+
+static bool is_under_flood(void)
+{
+	__u32 key = STATS_NEW_CONN;
+	struct lb_stats *conn_st = bpf_map_lookup_elem(&stats, &key);
+	__u64 cur_time;
+
+	if (!conn_st)
+		return true;
+
+	cur_time = bpf_ktime_get_ns();
+	if ((cur_time - conn_st->v2) > ONE_SEC) {
+		conn_st->v1 = 1;
+		conn_st->v2 = cur_time;
+	} else {
+		conn_st->v1 += 1;
+		if (conn_st->v1 > MAX_CONN_RATE)
+			return true;
+	}
+	return false;
+}
+
+static struct real_definition *connection_table_lookup(void *lru_map,
+						       struct flow_key *flow,
+						       __u32 *out_pos)
+{
+	struct real_pos_lru *dst_lru;
+	struct real_definition *real;
+	__u32 key;
+
+	dst_lru = bpf_map_lookup_elem(lru_map, flow);
+	if (!dst_lru)
+		return NULL;
+
+	/* UDP connections use atime-based timeout instead of FIN/RST */
+	if (flow->proto == IPPROTO_UDP) {
+		__u64 cur_time = bpf_ktime_get_ns();
+
+		if (cur_time - dst_lru->atime > LRU_UDP_TIMEOUT)
+			return NULL;
+		dst_lru->atime = cur_time;
+	}
+
+	key = dst_lru->pos;
+	*out_pos = key;
+	real = bpf_map_lookup_elem(&reals, &key);
+	return real;
+}
+
+static bool get_packet_dst(struct real_definition **real, struct flow_key *flow,
+			   struct vip_meta *vip_info, bool is_v6, void *lru_map,
+			   bool is_rst, __u32 *out_pos)
+{
+	bool under_flood;
+	__u32 hash, ch_key;
+	__u32 *ch_val;
+	__u32 real_pos;
+
+	under_flood = is_under_flood();
+
+	if (is_v6) {
+		__u32 src_hash = jhash2_4words((__u32 *)flow->srcv6, MAX_VIPS);
+
+		hash = jhash_2words(src_hash, flow->ports, CH_RING_SIZE);
+	} else {
+		hash = jhash_2words(flow->src, flow->ports, CH_RING_SIZE);
+	}
+
+	ch_key = CH_RING_SIZE * vip_info->vip_num + hash % CH_RING_SIZE;
+	ch_val = bpf_map_lookup_elem(&ch_rings, &ch_key);
+	if (!ch_val)
+		return false;
+	real_pos = *ch_val;
+
+	*real = bpf_map_lookup_elem(&reals, &real_pos);
+	if (!(*real))
+		return false;
+
+	if (!(vip_info->flags & F_LRU_BYPASS) && !under_flood && !is_rst) {
+		struct real_pos_lru new_lru = { .pos = real_pos };
+
+		if (flow->proto == IPPROTO_UDP)
+			new_lru.atime = bpf_ktime_get_ns();
+		bpf_map_update_elem(lru_map, flow, &new_lru, BPF_ANY);
+	}
+
+	*out_pos = real_pos;
+	return true;
+}
+
+static void update_vip_lru_miss_stats(struct vip_definition *vip, bool is_v6,
+				      __u32 real_idx)
+{
+	struct vip_definition *miss_vip;
+	__u32 key = 0;
+	__u32 *cnt;
+
+	miss_vip = bpf_map_lookup_elem(&vip_miss_stats, &key);
+	if (!miss_vip)
+		return;
+
+	if (is_v6) {
+		if (miss_vip->vipv6[0] != vip->vipv6[0] || miss_vip->vipv6[1] != vip->vipv6[1] ||
+		    miss_vip->vipv6[2] != vip->vipv6[2] || miss_vip->vipv6[3] != vip->vipv6[3])
+			return;
+	} else {
+		if (miss_vip->vip != vip->vip)
+			return;
+	}
+
+	if (miss_vip->port != vip->port || miss_vip->proto != vip->proto)
+		return;
+
+	cnt = bpf_map_lookup_elem(&lru_miss_stats, &real_idx);
+	if (cnt)
+		*cnt += 1;
+}
+
+static __noinline int process_packet(struct xdp_md *xdp)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	struct real_definition *dst = NULL;
+	struct vip_definition vip_def = {};
+	struct ctl_value *cval;
+	struct flow_key flow = {};
+	struct vip_meta *vip_info;
+	struct lb_stats *data_stats;
+	struct udphdr *uh;
+	__be32 tnl_src[4];
+	void *lru_map;
+	void *l4;
+	__u16 payload_len;
+	__u32 real_pos = 0, cpu_num, key;
+	__u8 proto;
+	int action = XDP_DROP;
+	bool is_v6, is_syn = false, is_rst = false;
+
+	if (eth + 1 > data_end)
+		goto out;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		is_v6 = true;
+	} else if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		is_v6 = false;
+	} else {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	if (is_v6) {
+		struct ipv6hdr *ip6h = (void *)(eth + 1);
+
+		if (ip6h + 1 > data_end)
+			goto out;
+		if (ip6h->nexthdr == IPPROTO_FRAGMENT)
+			goto out;
+
+		payload_len = sizeof(struct ipv6hdr) + bpf_ntohs(ip6h->payload_len);
+		proto = ip6h->nexthdr;
+
+		__builtin_memcpy(flow.srcv6, &ip6h->saddr, sizeof(flow.srcv6));
+		__builtin_memcpy(flow.dstv6, &ip6h->daddr, sizeof(flow.dstv6));
+		__builtin_memcpy(vip_def.vipv6, &ip6h->daddr, sizeof(vip_def.vipv6));
+		l4 = (void *)(ip6h + 1);
+	} else {
+		struct iphdr *iph = (void *)(eth + 1);
+
+		if (iph + 1 > data_end)
+			goto out;
+		if (iph->ihl != 5)
+			goto out;
+		if (iph->frag_off & bpf_htons(PCKT_FRAGMENTED))
+			goto out;
+
+		payload_len = bpf_ntohs(iph->tot_len);
+		proto = iph->protocol;
+
+		flow.src    = iph->saddr;
+		flow.dst    = iph->daddr;
+		vip_def.vip = iph->daddr;
+		l4 = (void *)(iph + 1);
+	}
+
+	/* TCP and UDP share the same port layout at offset 0 */
+	if (proto != IPPROTO_TCP && proto != IPPROTO_UDP) {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	uh = l4;
+	if ((void *)(uh + 1) > data_end)
+		goto out;
+	flow.port16[0] = uh->source;
+	flow.port16[1] = uh->dest;
+
+	if (proto == IPPROTO_TCP) {
+		struct tcphdr *th = l4;
+
+		if ((void *)(th + 1) > data_end)
+			goto out;
+		is_syn = th->syn;
+		is_rst = th->rst;
+	}
+
+	flow.proto    = proto;
+	vip_def.port  = flow.port16[1];
+	vip_def.proto = proto;
+
+	vip_info = bpf_map_lookup_elem(&vip_map, &vip_def);
+	if (!vip_info) {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	key = STATS_LRU;
+	data_stats = bpf_map_lookup_elem(&stats, &key);
+	if (!data_stats)
+		goto out;
+	data_stats->v1 += 1;
+
+	cpu_num = bpf_get_smp_processor_id();
+	lru_map = bpf_map_lookup_elem(&lru_mapping, &cpu_num);
+	if (!lru_map)
+		goto out;
+
+	if (!(vip_info->flags & F_LRU_BYPASS) && !is_syn)
+		dst = connection_table_lookup(lru_map, &flow, &real_pos);
+
+	if (!dst) {
+		if (flow.proto == IPPROTO_TCP) {
+			struct lb_stats *miss_st;
+
+			key = STATS_LRU_MISS;
+			miss_st = bpf_map_lookup_elem(&stats, &key);
+			if (miss_st)
+				miss_st->v1 += 1;
+		}
+
+		if (!get_packet_dst(&dst, &flow, vip_info, is_v6, lru_map, is_rst, &real_pos))
+			goto out;
+
+		update_vip_lru_miss_stats(&vip_def, is_v6, real_pos);
+		data_stats->v2 += 1;
+	}
+
+	key = 0;
+	cval = bpf_map_lookup_elem(&ctl_array, &key);
+	if (!cval)
+		goto out;
+
+	update_stats(&stats, vip_info->vip_num, payload_len);
+	update_stats(&reals_stats, real_pos, payload_len);
+
+	if (is_v6) {
+		create_encap_ipv6_src(flow.port16[0], flow.srcv6[0], tnl_src);
+		if (encap_v6(xdp, tnl_src, dst->dstv6, IPPROTO_IPV6, payload_len, cval->mac))
+			goto out;
+	} else if (dst->flags & F_IPV6) {
+		create_encap_ipv6_src(flow.port16[0], flow.src, tnl_src);
+		if (encap_v6(xdp, tnl_src, dst->dstv6, IPPROTO_IPIP, payload_len, cval->mac))
+			goto out;
+	} else {
+		if (encap_v4(xdp, create_encap_ipv4_src(flow.port16[0], flow.src), dst->dst,
+			     payload_len, cval->mac))
+			goto out;
+	}
+
+	action = XDP_TX;
+
+out:
+	count_action(action);
+	return action;
+}
+
+static int strip_encap(struct xdp_md *xdp, const struct ethhdr *saved_eth)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	int hdr_sz;
+
+	if (eth + 1 > data_end)
+		return -1;
+
+	hdr_sz = (eth->h_proto == bpf_htons(ETH_P_IPV6)) ? (int)sizeof(struct ipv6hdr)
+							 : (int)sizeof(struct iphdr);
+
+	if (bpf_xdp_adjust_head(xdp, hdr_sz))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+	eth      = data;
+
+	if (eth + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(eth, saved_eth, sizeof(*saved_eth));
+	return 0;
+}
+
+static void randomize_src(struct xdp_md *xdp, int saddr_off, __u32 *rand_state)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	__u32 *saddr   = data + saddr_off;
+
+	*rand_state ^= *rand_state << 13;
+	*rand_state ^= *rand_state >> 17;
+	*rand_state ^= *rand_state << 5;
+
+	if ((void *)(saddr + 1) <= data_end)
+		*saddr = *rand_state & flow_mask;
+}
+
+SEC("xdp")
+__success
+int xdp_lb_bench(struct xdp_md *xdp)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	struct ethhdr saved_eth;
+	__u32 rand_state = 0;
+	__u32 batch_hash = 0;
+	int saddr_off = 0;
+	bool is_v6;
+
+	if (eth + 1 > data_end)
+		return XDP_DROP;
+
+	__builtin_memcpy(&saved_eth, eth, sizeof(saved_eth));
+
+	is_v6 = (saved_eth.h_proto == bpf_htons(ETH_P_IPV6));
+
+	saddr_off = sizeof(struct ethhdr) + (is_v6 ? offsetof(struct ipv6hdr, saddr) :
+					     offsetof(struct iphdr, saddr));
+
+	if (flow_mask)
+		rand_state = bpf_get_prandom_u32() | 1;
+
+	if (cold_lru) {
+		__u32 *saddr = data + saddr_off;
+
+		batch_gen++;
+		batch_hash = (batch_gen + bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
+		if ((void *)(saddr + 1) <= data_end)
+			*saddr ^= batch_hash;
+	}
+
+	return BENCH_BPF_LOOP(
+		process_packet(xdp),
+		({
+			if (__bench_result == XDP_TX) {
+				if (strip_encap(xdp, &saved_eth))
+					return XDP_DROP;
+				if (rand_state)
+					randomize_src(xdp, saddr_off, &rand_state);
+			}
+			if (cold_lru) {
+				void *d = (void *)(long)xdp->data;
+				void *de = (void *)(long)xdp->data_end;
+				__u32 *__sa = d + saddr_off;
+
+				if ((void *)(__sa + 1) <= de)
+					*__sa ^= batch_hash;
+			}
+		})
+	);
+}
+
+#else
+
+SEC("socket")
+__description("stack_arg is not supported by compiler or jit, use a dummy test")
+__skip("stack_arg is not supported by compiler or jit")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

