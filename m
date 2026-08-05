Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5322F7EF6
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892528; cv=none; b=h/8i8dyO3GfU/MXNCdkO6EI3ZgHjcD+dd8qBceRMe7reYhZ1Fi4zAf6jES/EheywKIAxgtuj/UNIMgjBNx6B9CDYM9m5qmhjRUTMpIhaiRlhWrLlnHAyYopK7yLgYD239+bZ+cusy4/PrdrIk6g1wiY5g2+shlwwrFXH/pgzicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892528; c=relaxed/simple;
	bh=XMPAcO4zrt3SsyL8yaYcJQeib+2/LOsEwJnBGkzlOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjaVrdmFV2HXl5VTYDCgESwrBKSEoK3VnpWFyL5iWY4tU6oLUyERdALy8dahORiRzra/ciRsl7anQGEaueOdPiqkceA4db1d5We+xLiYLD6lN/ak65NeATGXlzjH8Z7dp9oH8IF+IdC37m73aIJcEURan41MB9HS23HSehZNO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0IdWnos; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0IdWnos"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-47fde295992so355414f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892525; x=1786497325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gpfe1CPu8jiYx1giAahwf8+pQAiZcln1tkFg3CdpzBY=;
        b=O0IdWnosYbmGQsXJrkbR/lUIC3Dgaae2IIZTh3VvkCkA4iIFF6l6lgYFFdNgV4BCFL
         D/tmWUfaQHTTw0i9PBVabf7Pw6lRP/z5GRvhV8upgS0MwG2mOXu9cJusX26dbanzSqta
         xQrYy/PtMGqm5o3SgLdS1i4BDsQ716PDe5pdQThuGRe/Iobji9hYS4nVfrTBFp1vsT29
         4VyILiTulw5crVRhXXm61vpeh5MxyigaotCmK+zfYvj5e+A5EkQ0Fq9iWgbDU/gw7hnM
         CgWND1QnofX+dIu6d49VpFkzFqtiRihB9Kqsg+khvPfkgHMDedfaPamJm5K9SBNafQZl
         L+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892525; x=1786497325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gpfe1CPu8jiYx1giAahwf8+pQAiZcln1tkFg3CdpzBY=;
        b=Ph+GcVSYoK5YCT6DyHXjHar97furRIOyge8qiOgtQJva/pvV5FSe8LTF3Wbj2EYlI6
         fjn9ghh01S4ndzFVAYgJkA+uaxMilQHiTC7czGxbwiQO4WUuFd+7TxpDR33DbvcqnNaz
         TLn4UgLvv+ocUhAVy/MiUORfC2jzeGQesLN9HeoP7/IYpAeK0ov+vwy3wOFTl3CNidaq
         /4Hu5NQ46VO73i08C8jFIOJ+o+8MW7F0cDzBhBq4A6LpfSk6Fv3NNKm8/W6DD+1osKe5
         7SqYyN9EDZ96tU5OTjJt/hK1FEpGvoUFZovZTnCGJUgxtr9oLvjkED3Iv+S1aZrt8suQ
         pyJg==
X-Gm-Message-State: AOJu0YzvEA8V4H+MG8WIMkI80OzlClSygSr+IhjHCbj3pL1VoSsCnnF8
	1+uSafJScFVMw02OeR/zIwJJ7eKq6s+OPz+xFeAmAsEBc81eUYXS00mBi/138T48
X-Gm-Gg: AR+sD13OATuY0bCDNoQgOL58Gf2RZ989fuM9BjchACekOY9jvo9QhiC/7wMJ3bW57Jj
	wSJc/6eD6z2qArkIS5hKj5uDQAdo10f4+/FPJMaV4SyXN7Ch8TvK3kj04pg8xCNVLyS2DbOZqIF
	mWQsPfUdU2MsnB+AD8tbHY8hucEEF60+mxxSTb1tfbMfCgV6PTmDaaBgBr1Qq8zyKFL0J5iZjXS
	Wjn2dz+heIQMp6g0P36Uwbezn52mAoENcN8Dms6IkuG+jgGvNTwoxXnRuE/VC3s8wPVZkA2AdgN
	Peltay9MEu/49EHy3vWWTb07sXRbKSYb/1Qc9WCUEpjLNcD4JymPaug8mqoU7xQjdfeLVkFBDxc
	UgH/ukBpWE7KCoOXta+fq/kvTMawHkfBTSzXfaw7G7k1g2WD6DojPHzO8ZQ+bj1jEwXPQA/jDmZ
	fmvFQGJKoN6VOuuZ35t+fjVj137kDhhN4lUsEcAgw11S71PoT763bR7/LXfCBeG07yOO0fbpxr6
	ve/VMK77A0xD8awo/BdSFJYK6b0PP/z+bEtPq7G3ducHseDlB8T9RnnGU694OinyeSJnDgEbhsp
	kmV9wg02+21cOFwZhIyEb7nGZaA=
X-Received: by 2002:a05:6000:240a:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47fe81d732emr13201126f8f.15.1785892525019;
        Tue, 04 Aug 2026 18:15:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5bb9sm4538795f8f.10.2026.08.04.18.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Test subprogram instruction statistics
Date: Wed,  5 Aug 2026 03:15:14 +0200
Message-ID: <20260805011517.1717238-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7668; i=memxor@gmail.com; h=from:subject; bh=XMPAcO4zrt3SsyL8yaYcJQeib+2/LOsEwJnBGkzlOMc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz+3XpEtVnVqzKpY+nyD9waqHxb6nwPvW1tL5X/k/q BhvfurZUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn4LGf4H6rUm1k7lf/z0z2/ PqXctI2VVT54QTZDKmtKzWGBIwqmhxn+R2grSRol/A+sL7LK6HqqNG8B6xwf5VUnrBpaTIz2fU5 hBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add small verifier programs with deterministic instruction streams to
exercise per-subprogram own and inclusive instruction accounting. Use
assembly for normal call chains and straight-line callback bodies
containing only moves, calls, and returns or exits, so control-flow
pruning does not make the expected counts unstable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_subprog_insn_stats.c   | 225 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b79bafca68f7..19d03f6d6525 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -100,6 +100,7 @@
 #include "verifier_stack_arg_order.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
+#include "verifier_subprog_insn_stats.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subprog_topo.skel.h"
 #include "verifier_subreg.skel.h"
@@ -255,6 +256,7 @@ void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
 void test_verifier_stack_arg_order(void)      { RUN(verifier_stack_arg_order); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
+void test_verifier_subprog_insn_stats(void)   { RUN(verifier_subprog_insn_stats); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
new file mode 100644
index 000000000000..b7ac55f4f136
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct timer_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct timer_value);
+} timer_map SEC(".maps");
+
+SEC("?raw_tp")
+__success __log_level(4)
+__msg("subprog 0 (stats_main_only) main insns_own 2 insns_total 2 stack 0")
+__msg("processed 2 insns")
+__naked int stats_main_only(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_chain_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_chain_parent(void)
+{
+	asm volatile (
+		"call stats_chain_leaf;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * own: 2 + 2 + 2 = 6
+ * totals: leaf 2, parent 2 + 2 = 4, main 2 + 4 = 6
+ */
+__msg("subprog 0 (stats_static_chain) main insns_own 2 insns_total 6 stack 0")
+__msg("subprog {{[0-9]+}} (stats_chain_parent) static insns_own 2 insns_total 4 stack 0")
+__msg("subprog {{[0-9]+}} (stats_chain_leaf) static insns_own 2 insns_total 2 stack 0")
+__msg("processed 6 insns")
+__naked int stats_static_chain(void)
+{
+	asm volatile (
+		"call stats_chain_parent;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_shared_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+int stats_global_root(void)
+{
+	asm volatile (
+		"call stats_shared_leaf;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * stats_shared_leaf is explored once under each independent root.
+ * own: main 3 + leaf 4 + global 2 = 9
+ * root totals: main 5 + global 4 = 9
+ */
+__msg("subprog 0 (stats_shared_roots) main insns_own 3 insns_total 5 stack 0")
+__msg("subprog {{[0-9]+}} (stats_shared_leaf) static insns_own 4 insns_total 4 stack 0")
+__msg("subprog {{[0-9]+}} (stats_global_root) global insns_own 2 insns_total 4 stack 0")
+__msg("processed 9 insns")
+__naked int stats_shared_roots(void)
+{
+	asm volatile (
+		"call stats_shared_leaf;"
+		"call stats_global_root;"
+		"exit;"
+	);
+}
+
+__noinline __used
+static int stats_async_leaf(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	return 0;
+}
+
+__noinline __used
+static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
+				  struct timer_value *value, void *ctx)
+{
+	asm volatile (
+		"r1 = r3;"
+		"r2 = %[stats_async_leaf];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: __imm_ptr(stats_async_leaf),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * own: 9 + 6 + 2 = 17
+ * totals: leaf 2, scheduler 6 + 2 = 8, main 17
+ */
+__msg("subprog 0 (stats_async_direct) main insns_own 9 insns_total 17 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_own 6 "
+      "insns_total 8 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_leaf) static insns_own 2 "
+      "insns_total 2 stack 0")
+__msg("processed 17 insns")
+__naked int stats_async_direct(void)
+{
+	asm volatile (
+		"r1 = %[timer_map] ll;"
+		"r2 = %[stats_async_schedule];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timer_map),
+		  __imm_ptr(stats_async_schedule),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+__noinline __used
+static int stats_async_nested_leaf(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	return 0;
+}
+
+__noinline __used
+static int stats_async_outer(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	asm volatile (
+		"r1 = r3;"
+		"r2 = %[stats_async_nested_leaf];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: __imm_ptr(stats_async_nested_leaf),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+__noinline __used
+static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
+					 struct timer_value *value, void *ctx)
+{
+	asm volatile (
+		"r1 = r3;"
+		"r2 = %[stats_async_outer];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: __imm_ptr(stats_async_outer),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * own: 9 + 6 + 6 + 2 = 23
+ * totals: leaf 2, outer 8, scheduler 14, main 23
+ */
+__msg("subprog 0 (stats_async_nested) main insns_own 9 insns_total 23 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_own 6 "
+      "insns_total 14 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_outer) static insns_own 6 "
+      "insns_total 8 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_nested_leaf) static insns_own 2 "
+      "insns_total 2 stack 0")
+__msg("processed 23 insns")
+__naked int stats_async_nested(void)
+{
+	asm volatile (
+		"r1 = %[timer_map] ll;"
+		"r2 = %[stats_async_nested_schedule];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timer_map),
+		  __imm_ptr(stats_async_nested_schedule),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

